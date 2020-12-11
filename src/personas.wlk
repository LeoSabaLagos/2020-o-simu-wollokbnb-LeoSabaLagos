import destinos.*

class Persona {
	
	// Punto 2
	// Saber cuándo le cabe un destino a una persona. 
	// A todos les cabe los destinos si son copados pero además tienen un criterio propio
	
	var criterio
	
	// Para el Punto 3 sirve
	var destinosVisitados = #{}
	
	var humor 
	
	method leCabe(destino) = destino.esCopado() and criterio.seCumple(destino,self)
	
	method viajoAMasDeTresCiudades() = destinosVisitados.size() > 3
	
	// El humor puede ir cambiando de forma dinámica.
	method humor(estadoHumor){
		humor =  estadoHumor
	}
	
	method estaDeHumor() = humor
	
	// Punto 3
	// Para viajar a estos lugares, necesitamos saber si primero se acepta un destino propuesto. 
	method viajarA(destino){
		self.acepta(destino)
		
		// A su vez, el destino suma uno a la cantidad de pasajeros que lo visitaron.
		// agregar destino que visitó
	}
	
	// Esto ocurre cuando le cabe un destino y viajó a 5 destinos o menos. 
	method acepta(destino){
		if(not self.leCabe(destino))
			self.error("No le cabe el destino a la persona")
		else if (self.viajoAMasDeCincoDestinos())
			self.error("Viajó a más de 5 destinos")
		else 
			
	}
	// Caso contrario debe expresar un mensaje acorde con el motivo de rechazo (“No le cabe el destino a la persona” o “Viajó a más de 5 destinos”). 
	
	method viajoAMasDeCincoDestinos() = destinosVisitados.size() > 5
	
	
}

object carlos inherits Persona {
	// Carlos tiene su propio criterio y es que con tal de viajar, no tiene problemas. No importa si el destino es copado o no.
	override method leCabe(destino) = true
}

//////// Criterios ////////

object comodo { 
	// Cómodos: les gusta estar siempre en grandes ciudades porque tienen todo a mano, entonces quieren ir sólo a las capitales. 
	method seCumple(destino,_) = destino.esCapital()
}

object vago {
	// Vagos si ya viajaron a más de 3 ciudades no quieren seguir viajando.
	method seCumple(_,persona) = not persona.viajoAMasDeTresCiudades()
}

object tocToc {
	// TocToc van sólo si el precio del viaje es par y si está de humor. El humor puede ir cambiando de forma dinámica.
	method seCumple(destino,persona) = destino.precioPasajeEsPar() and persona.estaDeHumor()  
}

object disociativo {
	// Disociativos que pueden tener una combinación de algunos de los criterios anteriores. Se tienen que cumplir todos a la vez.
	var criteriosACumplirse = #{}
	
	method seCumple() = criteriosACumplirse.all({ criterio => criterio.seCumple() })
}
