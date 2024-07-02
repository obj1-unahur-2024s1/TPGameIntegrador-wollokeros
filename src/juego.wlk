import wollok.game.*
import tablero.*
import elementosDelJuego.*
import teclado.*
import mapas.*

object imagenInicial{
	var property position = game.at(0,0)
	var property image = './assets/menuPrincipal.jpg'

}

object imagenGameOver{
	var property position = game.at(0,0)
	var property image = './assets/gameOver.jpg'

}

object fondoNegro{
	var property position = game.at(0,0)
	var property image = './assets/fondoNegro.jpg'

}


object juego {
	
	method menuPrincipal(){
		game.title("Battle city")
		game.width(17)
		game.height(13)

		game.addVisual(imagenInicial)
	}
	
	method iniciarJuego(){
		//game.removeVisual(imagenInicial)
		game.clear()
		tablero.mapaActual().crear()
	}
	
	method ganaste(){
		//falta implementarlo xD
		game.clear()
		game.addVisual(fondoNegro)
	}
	
	method gameOver(){
		game.clear()
		game.addVisual(imagenGameOver)
	}
}
