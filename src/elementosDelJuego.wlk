import wollok.game.*
import juego.*
import tablero.*
import pruebaDirecciones.*
import mapas.*

class Bala {
	
	var property image = self.direccionDeBala()
	var property position
	//var property direccion
	var property esBalaEnemiga = false
	
	//Para quew pueda impactar con ella misma
	var property direccionDeBala = 0
	
	method direccionDeBala(){
		return if( direccionDeBala == arriba ) "./assets/bala/bala-arriba.jpg" 
		else if ( direccionDeBala == abajo ) "./assets/bala/bala-abajo.jpg" 
		else if( direccionDeBala == izquierda ) "./assets/bala/bala-izquierda.jpg" 
		else "./assets/bala/bala-derecha.jpg"
	}
	
	method unId(){
		return self.identity().toString()
	}
	
	method explota(){
		game.removeVisual(self)
		game.removeTickEvent(self.unId())
	}
		
	method mover(){
		game.addVisual(self)
		//Eso solo se ejecua cuando la bala esa encima de un objeto
		game.onCollideDo( self, { elementoImpacado =>
				elementoImpacado.direccionDeBala( direccionDeBala.opuesto() ) 
				elementoImpacado.esBalaEnemigaLaRecibida( esBalaEnemiga )
				//game.schedule( 200, {self.image( elementoImpacado.serImpacado() )} )
				elementoImpacado.serImpacado()
				self.explota()
			} ) 
		
		game.onTick( 50, self.unId(), { => 
			self.position( direccionDeBala.posicionMasDe(self) )
			//self.position( self.position() )
			if( self.position().y() > 12 or self.position().x() > 12) self.explota()
		})
		
	}
	
	method serImpacado(){
		//self.image("./assets/explota.jpg")
		//game.schedule( 150, {game.removeVisual(self)} )
	}
	
	// Evitar errores al chocar las balas
	method esBalaEnemiga(){} 
	method esBalaEnemigaLaRecibida(balaRecibida){}
	
}

class Personaje{
	
	var property direccionDeBala = arriba

	//Mètodo abstracto
	method mirarA(direccionAMirar)
	
	//Mètodo abstracto
	method image()
	
	//Mètodo abstracto
	method image(unaImagen)
	
	//metodo abstracto
	method esBalaEnemiga()
	
	method moverA(unaDireccion){
		if( self.mirarA(unaDireccion) != self.image() ){
			self.image( self.mirarA(unaDireccion) )
			direccionDeBala = unaDireccion
		} else if( self.estoyEnZona(unaDireccion) and unaDireccion.esLibreParaMoverA(self) ) unaDireccion.mover(self) 
	}
	
	method estoyEnZona(unaDireccion){
		return unaDireccion.posicionMasDe(self).x() != 13 and unaDireccion.posicionMasDe(self).x() != -1 and unaDireccion.posicionMasDe(self).y() != 13 and unaDireccion.posicionMasDe(self).y() != -1
	}
	
	method disparar(){
		const unaBala = new Bala(position= direccionDeBala.posicionMasDe(self), direccionDeBala=direccionDeBala, esBalaEnemiga=self.esBalaEnemiga()  )
		unaBala.mover()
	}
	
	method serImpacado(){
		self.image("./assets/explota.jpg")
		game.schedule( 150, {game.removeVisual(self)} )
		const sonidoExplosion = game.sound("./assets/sonidos/tankeExplosion.mp3")
		sonidoExplosion.play()
		sonidoExplosion.volume(0.5)
	}

}

class Tankito inherits Personaje{
	var esBalaEnemiga = false
	var esBalaEnemigaLaRecibida = true
	var puedoDisparar = true
		
	var image = "./assets/tanke/tanke-arriba.jpg"
	var property position = game.at(4,0)
	
	override method disparar(){
		//esto es asi para que se inabilite el disparar cuando quiera.
		//En este caso puedo disparar cada medi segundo.
		if( puedoDisparar ){
			puedoDisparar = false
			super()
			game.schedule( 500, {puedoDisparar = true} )
		} 
		
	} 
	 
	method esBalaEnemiga(){
		return esBalaEnemiga
	} 
	
	method esBalaEnemigaLaRecibida(balaRecibida){
		esBalaEnemigaLaRecibida = balaRecibida
	}
	  
	 
	override method image(){
	 	return image
	}
	
	override method image(unaImagen){
	 	image = unaImagen
	}

	 override method mirarA(direccionAMirar){
		return if( direccionAMirar == arriba ) "./assets/tanke/tanke-arriba.jpg"
		else if( direccionAMirar == abajo ) "./assets/tanke/tanke-abajo.jpg"
		else if( direccionAMirar == derecha ) "./assets/tanke/tanke-derecha.jpg"
		else "./assets/tanke/tanke-izquierda.jpg"
	}
	
	override method serImpacado(){
		if( esBalaEnemigaLaRecibida ){
			super()
			game.schedule( 2000 , { => juego.gameOver()} )
		}
	}
	
}

class Enemigo inherits Personaje{
	
	var esBalaEnemiga = true
	var esBalaEnemigaLaRecibida = false

	const unTiempoDeDisparo = [ 2000, 3000, 4000, 5000  ]
	const unaDireccion = [ arriba, abajo, derecha, izquierda  ]
	
	var image = "./assets/enemigo/enemigo-abajo.jpg"
	var property position
	 
	method esBalaEnemiga(){
		return esBalaEnemiga
	} 
	
	method esBalaEnemigaLaRecibida(balaRecibida){
		esBalaEnemigaLaRecibida = balaRecibida
	}
	 
	override method image(){
	 	return image
	}
	
	override method image(unaImagen){
	 	image = unaImagen
	}
	
	 override method mirarA(direccionAMirar){
		return if( direccionAMirar == arriba ) "./assets/enemigo/enemigo-arriba.jpg"
		else if( direccionAMirar == abajo ) "./assets/enemigo/enemigo-abajo.jpg"
		else if( direccionAMirar == derecha ) "./assets/enemigo/enemigo-derecha.jpg"
		else "./assets/enemigo/enemigo-izquierda.jpg"
	}
	
	override method serImpacado(){
		
		if( not esBalaEnemigaLaRecibida ){
			
			super()
			game.removeTickEvent(self.identity().toString())
			tablero.mapaActual().enemigosAAsesinar().find( { elemento => !elemento.fueAsesinado() } ).asesinar()
			
			if( tablero.mapaActual().enemigosAAsesinar().all{elemento => elemento.fueAsesinado()} ){
				tablero.siguienteMapa()
				game.schedule( 1000, {
				tablero.vaciarPosiciones()
				juego.iniciarJuego()
				} ) 
			}
			
				
		}
	}
 
	
	
	method unTiempoDeDisparo(){
		return unTiempoDeDisparo.anyOne()
	}
	
	method posicionAleatoria(){
		return unaDireccion.anyOne()
	}
	
}




