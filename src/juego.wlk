import wollok.game.*
import tablero.*
import elementosDelJuego.*
import teclado.*
import mapas.*

object juego {
	var iniciado = false
	
	method iniciar(){
		game.title("Battle city")
			
		game.height(13)
		game.width(17)
		
		self.configurarMenu()
	}
		
	method configurarMenu(){
		
		const menu = new Imagen(image = "./assets/menuPrincipal.jpg")
		game.addVisual(menu)
		
		keyboard.enter().onPressDo{
			if (!iniciado) {
				game.removeVisual(menu)
				iniciado = true
				self.iniciarJuego()
			}
		}
	}

	method iniciarJuego(){
		game.clear()
		tablero.mapaActual().crear()
	}
	
	method ganaste(){
		const juegoCompletado = new Imagen(image = "./assets/juegoCompletado.jpg") 
		game.clear()
		game.addVisual(juegoCompletado)
	}
	
	method gameOver(){
		const gameOver = new Imagen(image = './assets/gameOver.jpg')
		game.clear()
		game.addVisual(gameOver)
	}
}

class Imagen {
	
	var property image
	var property position = game.origin() 
	
}	
