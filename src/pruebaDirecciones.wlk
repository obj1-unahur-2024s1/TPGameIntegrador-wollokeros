import wollok.game.*
import tablero.*

object arriba{
	
	method mover(objeto){
		objeto.position( objeto.position().up(1) )
	}
	
	method esLibreParaMoverA(unObjecto){
		return tablero.esLugarLibreEn( unObjecto.position().up(1) )
	}
	
	method opuesto(){
		return abajo
	}
	
	//De vuelve una coordenada con posicion del objeto dado con un movimiento a esat direccion
	method posicionMasDe(objeto){
		return game.at( objeto.position().x() , objeto.position().y() + 1 )
	}

}

object abajo{
	
	method mover(objeto){
		objeto.position( objeto.position().down(1) )
	}
	
	method esLibreParaMoverA(unObjecto){
		return tablero.esLugarLibreEn( unObjecto.position().down(1) )
	}
	
	method opuesto(){
		return arriba
	}
	
	method posicionMasDe(objeto){
		return game.at( objeto.position().x() , objeto.position().y() - 1 )
	}
}
object izquierda{

	method mover(objeto){
		objeto.position( objeto.position().left(1) )
	}
	
	method esLibreParaMoverA(unObjecto){
		return tablero.esLugarLibreEn( unObjecto.position().left(1) )
	}
	
	method opuesto(){
		return derecha
	}
	
	method posicionMasDe(objeto){
		return game.at( objeto.position().x() - 1 , objeto.position().y() )
	}
	
}
object derecha{

	method mover(objeto){
		objeto.position( objeto.position().right(1) )
	}
	
	method esLibreParaMoverA(unObjecto){
		return tablero.esLugarLibreEn( unObjecto.position().right(1) )
	}
	
	method opuesto(){
		return izquierda
	}
	
	method posicionMasDe(objeto){
		return game.at( objeto.position().x() + 1 , objeto.position().y() )
	}
	
}