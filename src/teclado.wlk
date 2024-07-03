import wollok.game.*
import elementosDelJuego.*
import tablero.*
import pruebaDirecciones.*

object teclado {
	
	method configuracionDeHeroe(tankito){
		keyboard.up().onPressDo{ tankito.moverA(arriba) }
		keyboard.down().onPressDo{ tankito.moverA(abajo) }
		keyboard.right().onPressDo{ tankito.moverA(derecha) }
		keyboard.left().onPressDo{ tankito.moverA(izquierda) }
		
		keyboard.space().onPressDo{ tankito.disparar() }
	}
	
}





















