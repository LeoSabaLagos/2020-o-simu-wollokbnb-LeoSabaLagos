class Destino {
	
	// De cada destino se conoce su nombre
	var nombre
	// el precio del pasaje (ida y vuelta) 
	var pasaje
	//y una serie de características que tiene: “salto de agua”, “montañas”, “ocio nocturno”,”monumento a la bandera”, etc
	var caracteristicas = #{}
	
	// Cada destino tiene un clima
	const clima
	
	// Punto 1
	// Además se pusieron de acuerdo en saber cuando un lugar es copado. 
	// Esto lo definieron si es lugar es barato (es decir que el pasaje sale menos de $100.000) y y además depende del clima:
	method esCopado() = self.esBarato() and clima.esCopadoParaElDestino(self)
	
	// El lugar es barato si el pasaje sale menos de $100.000
	method esBarato() = pasaje < 100000
	
	method tieneMasDeCuatroCaracteristicas() = caracteristicas.size() > 4
	
	// Los lugares de moda son Estambul, Cuzco, Barcelona y Tokio.
	method estaDeModa() = nombre == "Estambul" or nombre == "Cuzco" or nombre == "Barcelona" or nombre == "Tokio"
	
}

////////// Climas ////////////////

object frio {
	// Climas fríos: acá es necesario moverse para mantener el calor, por lo tanto son copados si tienen más de 4 características.
	method esCopadoParaElDestino(destino) = destino.tieneMasDeCuatroCaracteristicas()
}

object templado {
	// Climas templados les resulta un poco indistinto, pero les parece copado algún lugar de moda. Los lugares de moda son Estambul, Cuzco, Barcelona y Tokio.
	method esCopadoParaElDestino(destino) = destino.estaDeModa()
}

object tropical {
	// Climas tropicales son todos copados.
	method esCopadoParaElDestino(destino) = true
}