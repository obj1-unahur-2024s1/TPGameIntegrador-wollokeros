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

class Mapa{
	
	const fondo = new Imagen(image = "./assets/fondoNegro_grid.jpg") 
	method enemigosAAsesinar()
	method sonidoMapa(){
		const sonidoMapa = game.sound("./assets/sonidos/nivelUno.mp3")
		sonidoMapa.play()
		sonidoMapa.volume(0.4)
	}
	method crear(){
		self.sonidoMapa()
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
				const enemigo = new Enemigo(position=game.at(11,12))
				game.addVisual(enemigo)
				game.onTick( enemigo.unTiempoDeDisparo(), enemigo.identity().toString(), { => enemigo.disparar() })
				game.onTick( 500, enemigo.identity().toString(), { => if (enemigo.image() != "./assets/explota.jpg") enemigo.moverA(enemigo.posicionAleatoria()) })
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
				game.onTick( 500, enemigo.identity().toString(), { => if (enemigo.image() != "./assets/explota.jpg") enemigo.moverA(enemigo.posicionAleatoria()) })
				enemigosASpawnear -=1
			}else{
				game.removeTickEvent("nuevoEnemigo2")
			}

		})
		
		
	}
	
}


class Mapa1 inherits Mapa{
	const enemigosAAsesinar = [ 
		new Asesinar( position=game.at(14,10) ),
		new Asesinar( position=game.at(15,10) )
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
	
		tablero.crearColumnaDeLadrillos_EnXCoordenadasy(1, [1,2,3,4,8,9,10,11])
		tablero.crearColumnaDeLadrillos_EnXCoordenadasy(3, [1,2,3,4,8,9,10,11])
		tablero.crearColumnaDeLadrillos_EnXCoordenadasy(9, [1,2,3,4,8,9,10,11])
		tablero.crearColumnaDeLadrillos_EnXCoordenadasy(11, [1,2,3,4,8,9,10,11])
		
		tablero.crearColumnaDeLadrillos_EnXCoordenadasy(5, [3,4,5,9,10,11])
		tablero.crearColumnaDeLadrillos_EnXCoordenadasy(7, [3,4,5,9,10,11])
		
		tablero.crearFilaDeLadrillos_EnyCoordenadasX(6, [2,3,9,10] )
		
		tablero.crearCementoEnCoordenada( game.at(6, 6) )
		tablero.crearCementoEnCoordenada( game.at(7, 6) )
		tablero.crearCementoEnCoordenada( game.at(5, 6) )
		tablero.crearCementoEnCoordenada( game.at(0, 6) )
		tablero.crearCementoEnCoordenada( game.at(12, 6) )
	}
	
}

class Mapa2 inherits Mapa{
	const enemigosAAsesinar = [ 
		new Asesinar( position=game.at(14,10) ),
		new Asesinar( position=game.at(14,11) ),
		new Asesinar( position=game.at(15,10) ),
		new Asesinar( position=game.at(15,11) )
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
		
		
		tablero.crearCementoEnCoordenada( game.at(0, 6) )
		tablero.crearLadrilloEnCoordenada( game.at(1, 6) )
		tablero.crearLadrilloEnCoordenada( game.at(0, 7) )
		tablero.crearLadrilloEnCoordenada( game.at(0, 5) )
		
		tablero.crearCementoEnCoordenada( game.at(6, 8) )
		tablero.crearCementoEnCoordenada( game.at(7, 8) )
		tablero.crearLadrilloEnCoordenada( game.at(8, 8) )
		tablero.crearLadrilloEnCoordenada( game.at(5, 8) )
		tablero.crearLadrilloEnCoordenada( game.at(6, 9) )
		tablero.crearLadrilloEnCoordenada( game.at(7, 9) )
		tablero.crearLadrilloEnCoordenada( game.at(6, 7) )
		tablero.crearLadrilloEnCoordenada( game.at(7, 7) )
		
		tablero.crearCementoEnCoordenada( game.at(6, 3) )
		tablero.crearCementoEnCoordenada( game.at(7, 3) )
		tablero.crearLadrilloEnCoordenada( game.at(8, 3) )
		tablero.crearLadrilloEnCoordenada( game.at(5, 3) )
		tablero.crearLadrilloEnCoordenada( game.at(6, 4) )
		tablero.crearLadrilloEnCoordenada( game.at(7, 4) )
		tablero.crearLadrilloEnCoordenada( game.at(6, 2) )
		tablero.crearLadrilloEnCoordenada( game.at(7, 2) )
		
		tablero.crearCementoEnCoordenada( game.at(13, 6) )
		tablero.crearLadrilloEnCoordenada( game.at(12, 6) )
		tablero.crearLadrilloEnCoordenada( game.at(13, 7) )
		tablero.crearLadrilloEnCoordenada( game.at(13, 5) )
		
		tablero.crearLadrilloEnCoordenada( game.at(0, 0) )
		tablero.crearLadrilloEnCoordenada( game.at(13, 0) )
		tablero.crearLadrilloEnCoordenada( game.at(0, 12) )
		tablero.crearLadrilloEnCoordenada( game.at(13, 12) )
		
		tablero.crearLadrilloEnCoordenada( game.at(0, 1) )
		tablero.crearLadrilloEnCoordenada( game.at(1, 0) )
		tablero.crearLadrilloEnCoordenada( game.at(12, 0) )
		tablero.crearLadrilloEnCoordenada( game.at(13, 1) )
		tablero.crearLadrilloEnCoordenada( game.at(0, 11) )
		tablero.crearLadrilloEnCoordenada( game.at(1, 12) )
		tablero.crearLadrilloEnCoordenada( game.at(12, 12) )
		tablero.crearLadrilloEnCoordenada( game.at(13, 11) )
		
		tablero.crearLadrilloEnCoordenada( game.at(2, 3) )
		tablero.crearLadrilloEnCoordenada( game.at(3, 4) )
		tablero.crearLadrilloEnCoordenada( game.at(4, 5) )
		tablero.crearLadrilloEnCoordenada( game.at(5, 6) )
		
		
		tablero.crearLadrilloEnCoordenada( game.at(11, 3) )
		tablero.crearLadrilloEnCoordenada( game.at(10, 4) )
		tablero.crearLadrilloEnCoordenada( game.at(9, 5) )
		tablero.crearLadrilloEnCoordenada( game.at(8, 6) )
		
		tablero.crearCementoEnCoordenada( game.at(10, 8) )
		tablero.crearCementoEnCoordenada( game.at(3, 8) )
		
		
	}
	
}


class Mapa3 inherits Mapa{
	const enemigosAAsesinar = [ 
		new Asesinar( position=game.at(14,10) ),
		new Asesinar( position=game.at(14,11) ),
		new Asesinar( position=game.at(15,10) ),
		new Asesinar( position=game.at(15,11) )
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
		
		tablero.crearColumnaDeLadrillos_EnXCoordenadasy(1, [0,1,2,3,4,5])
		tablero.crearCementoEnCoordenada( game.at(0, 5) )
		tablero.crearLadrilloEnCoordenada( game.at(3, 0) )
		tablero.crearColumnaDeLadrillos_EnXCoordenadasy(3, [2,3])
		tablero.crearCementoEnCoordenada( game.at(3, 4) )
		tablero.crearCementoEnCoordenada( game.at(3, 5) )
		tablero.crearFilaDeLadrillos_EnyCoordenadasX(7, [1,2,3])
		
		tablero.crearColumnaDeLadrillos_EnXCoordenadasy(12, [0,1,2,3,4,5])
		tablero.crearCementoEnCoordenada( game.at(13, 5) )
		tablero.crearLadrilloEnCoordenada( game.at(10, 0) )
		tablero.crearColumnaDeLadrillos_EnXCoordenadasy(10, [2,3])
		tablero.crearCementoEnCoordenada( game.at(10, 4) )
		tablero.crearCementoEnCoordenada( game.at(10, 5) )
		tablero.crearFilaDeLadrillos_EnyCoordenadasX(7, [10,11,12])
		
		tablero.crearLadrilloEnCoordenada( game.at(11,11) )
		tablero.crearLadrilloEnCoordenada( game.at(10,10) )

		tablero.crearLadrilloEnCoordenada( game.at(1,11) )
		tablero.crearLadrilloEnCoordenada( game.at(2,10) )
		tablero.crearFilaDeLadrillos_EnyCoordenadasX(6, [6,5,7,8])
		tablero.crearCementoEnCoordenada( game.at(6, 12) )
		tablero.crearCementoEnCoordenada( game.at(6, 11) )
		tablero.crearCementoEnCoordenada( game.at(6, 10) )
		tablero.crearCementoEnCoordenada( game.at(6, 9) )
		tablero.crearCementoEnCoordenada( game.at(7, 12) )
		tablero.crearCementoEnCoordenada( game.at(7, 11) )
		tablero.crearCementoEnCoordenada( game.at(7, 10) )
		tablero.crearCementoEnCoordenada( game.at(7, 9) )
		
		tablero.crearColumnaDeLadrillos_EnXCoordenadasy(5, [1,2,3,4])
		tablero.crearColumnaDeLadrillos_EnXCoordenadasy(6, [1,2])
		tablero.crearColumnaDeLadrillos_EnXCoordenadasy(8, [1,2,3,4])
	}
	
}
