import wollok.game.*
import mapas.*
import pruebaDirecciones.*

object tablero {

	var posicionesOcupadas = []
	
	var unNumero = 0
	const mapas = [ new Mapa1(), new Mapa2(), new Mapa3() ]
	
	method vaciarPosiciones(){
		posicionesOcupadas = []
	}
	
	
	method mapaActual(){
		//PROPOSITO: Devuelve el mapa actual que se esta jugando.
		return mapas.get(unNumero)
	}
	
	method siguienteMapa(){
		//PROPOSITO: Cambia el mapa actual
		unNumero +=1
	}
	
	method numeroDeMapa(){
		return  unNumero + 1
	}
	
	
	method crearLadrilloEnCoordenada(unaCoordenada){
		const unLadrillo = new Ladrillo( position=unaCoordenada, direccionDeBala=0)
		game.addVisual( unLadrillo )
		self.posicionesOcupadas().add( unLadrillo.position() )
		
	}
	
	// CEMENTO
	
	method crearCementoEnCoordenada(unaCoordenada){
		const cemento = new Cemento( position=unaCoordenada, direccionDeBala=0)
		game.addVisual( cemento )
		self.posicionesOcupadas().add( cemento.position() )
		
	}
	
	method posicionesOcupadas(){
		return posicionesOcupadas
	}
	
	//method hayLadrilloEn(unaCoordenada){
	//	return not self.esLugarLibreEn() and 
	//}
	
	
				
	method esLugarLibreEn( unaCoordenada ){
		return not self.posicionesOcupadas().any( {unaPosicion => unaPosicion == unaCoordenada } )
	}
	
	method liberarCoordenada( unaCoordenada ){
		posicionesOcupadas = self.posicionesOcupadas().filter( {unaPosicion => unaPosicion != unaCoordenada } )
	}
	
	
	method crearColumnaDeLadrillos_EnXCoordenadasy(unaFila, unArray ){
		unArray.forEach({numero => self.crearLadrilloEnCoordenada( game.at(unaFila, numero) )} )
	}
	
	method crearFilaDeLadrillos_EnyCoordenadasX(unaColumna, unArray ){
		unArray.forEach( {numero => self.crearLadrilloEnCoordenada( game.at(numero, unaColumna) )} )
	}
	
	// ENEMIGO
	
	method ponerEnemigo(enemigo){
		self.posicionesOcupadas().add( enemigo.position() )
		game.addVisual(enemigo)
	}
	
}

class Ladrillo{
	var property image = "./assets/ladrilloo.jpg"
	var property position
	var property direccionDeBala = 0
	var property estaDestruido = false
	
	method esBalaEnemiga(){} 
	method esBalaEnemigaLaRecibida(balaRecibida){}
	
	method enExplosion(){
		return  "./assets/ladrillos/ladrilloRoto" +direccionDeBala+"E.jpg"
	}
	
	method destruido(){
		return "./assets/ladrillos/ladrilloRoto"+direccionDeBala+".jpg"
		
	}
	

	
	method serImpacado(){
		if( not estaDestruido ){
			//game.say( self, self.enExplosion().toString() )
			self.image( self.enExplosion() )
			estaDestruido = true
			game.schedule( 250, {self.image( self.destruido() )} )
		}else{
			self.image( "./assets/explota.jpg" )
			//game.removeVisual(self)
			game.schedule( 250, {game.removeVisual(self)} )
			tablero.liberarCoordenada(self.position())
		}
		const sonidoExplosion = game.sound("./assets/sonidos/ladrilloExplosion.mp3")
		sonidoExplosion.play()
		sonidoExplosion.volume(0.5)
				
	} 

}


class Cemento{
	// cemenoExplosionIzquierda
	var property image = "./assets/cemento/cemento.jpg"
	var property position
	var property direccionDeBala = 0
	
	method esBalaEnemiga(){} 
	
	method esBalaEnemigaLaRecibida(balaRecibida){}
	
	method enExplosion(){
		return "./assets/cemento/cementoExplosion"+direccionDeBala+".jpg"
	}
	
	method serImpacado(){
		self.image( self.enExplosion() )
		game.schedule( 150, {self.image("./assets/cemento/cemento.jpg" )} )
		const sonidoExplosion = game.sound("./assets/sonidos/cementoExplosion.mp3")
		sonidoExplosion.play()
		sonidoExplosion.volume(0.5)
	}
}









