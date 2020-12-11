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
		// Aca se valida si se acepta el destino, si no se acepta se devuelve el mensaje correspondiente
		self.acepta(destino)
		
		// Si el destino es aceptado, el destino suma uno a la cantidad de pasajeros que lo visitaron.
		self.visitar(destino)
		destino.sumaVisitante()
	}
	
	// Esto ocurre cuando le cabe un destino y viajó a 5 destinos o menos. 
	method acepta(destino){
		// Caso contrario debe expresar un mensaje acorde con el motivo de rechazo (“No le cabe el destino a la persona” o “Viajó a más de 5 destinos”). 
		if(not self.leCabe(destino))
			self.error("No le cabe el destino a la persona")
		else if (self.viajoAMasDeCincoDestinos())
			self.error("Viajó a más de 5 destinos")
			
	}
		
	method viajoAMasDeCincoDestinos() = destinosVisitados.size() > 5
	
	method visitar(destino) {
		destinosVisitados.add(destino)
	}
	
	// Punto 4
	// Queremos saber los viajes pulentas de una persona. 
	// Estos son los viajes que tienen un valor de pasaje de más de $200.000, ordenado por cantidad de pasajeros que visitaron cada destino. 
	method viajesPulentas() = self.destinosPulentas().sortedBy({ destino1 , destino2 => destino1.tieneMaVisitantesQue(destino2) })
	
	method destinosPulentas() = destinosVisitados.filter({ destino => destino.esPulenta() })
	
	
	
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
