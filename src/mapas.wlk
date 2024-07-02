import wollok.game.*
import tablero.*
import elementosDelJuego.*
import teclado.*
import pruebaDirecciones.*
import juego.*

class Asesinar{
	var property image = "./assets/adornos/enemigo.jpg"  
	var property position	
	var property fueAsesinado = false
	
	method asesinar(){
		fueAsesinado = true
		image = "./assets/adornos/enemigoOscuro.jpg" 
	}
}

class Mapa inherits Imagen {
	
	const fondo = new Imagen(image = "./assets/fondoNegro.jpg") 
	
	method enemigosAAsesinar()
	
	method crear(){
		game.clear()
		var enemigosASpawnear = self.enemigosAAsesinar().size()
		game.addVisual(fondo)
		const tankito = new Tankito()
		game.addVisual(tankito)
		teclado.configuracionDeHeroe(tankito)
		
		keyboard.p().onPressDo{ juego.gameOver() }
		keyboard.d().onPressDo{ game.clear() }
		keyboard.r().onPressDo{ juego.iniciarJuego() }
		
		//game.schedule( enemigo.unTiempoDeDisparo() , {enemigo.disparar()} )

		game.onTick( 5000, "nuevoEnemigo1", { => 
			if( enemigosASpawnear != 0 ){
				const enemigo = new Enemigo(position=game.at(12,12))
				game.addVisual(enemigo)
				game.onTick( enemigo.unTiempoDeDisparo(), enemigo.identity().toString(), { => enemigo.disparar() })
				game.onTick( 500, enemigo.identity().toString(), { => enemigo.moverA(enemigo.posicionAleatoria()) })
				enemigosASpawnear -=1
			}else{
				game.removeTickEvent("nuevoEnemigo1")
			}

		})
		
		game.onTick( 5000, "nuevoEnemigo2", { => 
			if( enemigosASpawnear != 0 ){
				const enemigo = new Enemigo(position=game.at(2,12))
				game.addVisual(enemigo)
				game.onTick( enemigo.unTiempoDeDisparo(), enemigo.identity().toString(), { => enemigo.disparar() })
				game.onTick( 500, enemigo.identity().toString(), { => enemigo.moverA(enemigo.posicionAleatoria()) })
				enemigosASpawnear -=1
			}else{
				game.removeTickEvent("nuevoEnemigo2")
			}

		})
		
		
	}
	
}


class Mapa1 inherits Mapa{
	var enemigosAAsesinar = [ 
		new Asesinar( position=game.at(14,10) )
	]
	
	override method enemigosAAsesinar(){
		return enemigosAAsesinar
	}
	
	override method crear(){
		super()
		self.crearMapa1()
	}
	
	method crearMapa1(){
		self.enemigosAAsesinar().forEach{ elemento => game.addVisual(elemento) }
		//unaFila
		//self.crearLadrilloEnCoordenada( game.at(1,1) )
		//self.crearLadrilloEnCoordenada( game.at(3,1) )
		//self.crearLadrilloEnCoordenada( game.at(9,1) )
		//self.crearLadrilloEnCoordenada( game.at(11,1) )
		tablero.crearColumnaDeLadrillos_EnXCoordenadasy(1, [1,2,3,4,8,9,10,11])
		tablero.crearColumnaDeLadrillos_EnXCoordenadasy(3, [1,2,3,4,8,9,10,11])
		tablero.crearColumnaDeLadrillos_EnXCoordenadasy(9, [1,2,3,4,8,9,10,11])
		tablero.crearColumnaDeLadrillos_EnXCoordenadasy(11, [1,2,3,4,8,9,10,11])
		
		tablero.crearColumnaDeLadrillos_EnXCoordenadasy(5, [3,4,5,9,10,11])
		tablero.crearColumnaDeLadrillos_EnXCoordenadasy(7, [3,4,5,9,10,11])
		
		tablero.crearFilaDeLadrillos_EnyCoordenadasX(6, [2,3,9,10] )
		
		
		tablero.crearCementoEnCoordenada( game.at(0, 6) )
		tablero.crearCementoEnCoordenada( game.at(12, 6) )
	}
	
}

class Mapa2 inherits Mapa{
	var enemigosAAsesinar = [ 
		new Asesinar( position=game.at(14,10) ),
		new Asesinar( position=game.at(14,11) )
	]
	
	override method enemigosAAsesinar(){
		return enemigosAAsesinar
	}
	
	override method crear(){
		super()
		self.crearMapa2()
	}
	
	method crearMapa2(){
		self.enemigosAAsesinar().forEach{ elemento => game.addVisual(elemento) }
		
		tablero.crearColumnaDeLadrillos_EnXCoordenadasy(5, [3,4,5,9,10,11])
		
		tablero.crearFilaDeLadrillos_EnyCoordenadasX(6, [2,3,9,10] )
		
		
		tablero.crearCementoEnCoordenada( game.at(0, 6) )
		tablero.crearCementoEnCoordenada( game.at(0, 8) )
		
		tablero.crearCementoEnCoordenada( game.at(0, 7))
		tablero.crearCementoEnCoordenada( game.at(12, 8))
	}
	
}


class Mapa3 inherits Mapa{
	var enemigosAAsesinar = [ 
		new Asesinar( position=game.at(14,10) ),
		new Asesinar( position=game.at(14,11) ),
		new Asesinar( position=game.at(15,10) )
	]
	
	override method enemigosAAsesinar(){
		return enemigosAAsesinar
	}
	
	override method crear(){
		super()
		self.crearMapa3()
	}
	
	method crearMapa3(){
		self.enemigosAAsesinar().forEach{ elemento => game.addVisual(elemento) }
		
		tablero.crearCementoEnCoordenada( game.at(0, 5) )
		tablero.crearColumnaDeLadrillos_EnXCoordenadasy(1, [1,2,3,4,5])
		tablero.crearColumnaDeLadrillos_EnXCoordenadasy(3, [1,3,4])
		tablero.crearCementoEnCoordenada( game.at(3, 5) )
		tablero.crearCementoEnCoordenada( game.at(3, 6) )
		
	}
	
}