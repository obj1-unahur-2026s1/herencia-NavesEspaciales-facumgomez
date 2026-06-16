import nave.*


class Baliza inherits Nave{
  var color
  var cantidadCambiosDeColor

  method cambiarColorBaliza(unColor) { 
    color = unColor 
    cantidadCambiosDeColor += 1
  }

  override method prepararViaje() {
    super();
    self.cambiarColorBaliza("Verde")
    self.ponerseParaleloAlSol()
  }

  override method esTranquila() = super() && color != "Rojo"

  override method escapar(){ self.irHaciaElSol() }
  override method avisar(){ self.cambiarColorBaliza("Rojo") }

  override method tienePocaActividad() = cantidadCambiosDeColor == 0
}

class Pasajeros inherits Nave{
  const cantidadDePasajeros
  var racionesDeComida = 0
  var cantidadDeBebidas = 0
  var cantidadDeRacionServida = 0

  method cargarRacionesDeComida(cantidad){ racionesDeComida += cantidad }
  method descargarRacionesDeComida(cantidad){ 
    racionesDeComida -= cantidad
    cantidadDeRacionServida += cantidad
  }

  method cargarBebidas(cantidad){ cantidadDeBebidas += cantidad }
  method descargarBebidas(cantidad){ cantidadDeBebidas -= cantidad }

  override method prepararViaje() {
    super();
    self.cargarRacionesDeComida(4)
    self.cargarBebidas(6)
    self.acercarseUnPocoAlSol()
  }

  override method escapar(){ velocidad *= 2 }
  override method avisar(){ 
    racionesDeComida = 0.max(racionesDeComida - cantidadDePasajeros)
    cantidadDeBebidas = 0.max(cantidadDeBebidas - cantidadDePasajeros * 2)
  }

  override method tienePocaActividad() = cantidadDeRacionServida >= 50
}

class Combate inherits Nave{
  const mensajesEmitidos = [] 
  var estaInvisible
  var misilesDesplegados

  method ponerseVisible() { estaInvisible = true }
  method ponerseInvisible() { estaInvisible = false }
  method estaInvisible() = estaInvisible

  method desplegarMisiles() { misilesDesplegados = true }
  method replegarMisiles() { misilesDesplegados = false }
  method misilesDesplegados() = misilesDesplegados

  method emitirMensaje(mensaje){ mensajesEmitidos.add(mensaje) }
  method mensajesEmitidos() = mensajesEmitidos
  method primerMensajeEmitido() = mensajesEmitidos.first()
  method ultimoMensajeEmitido() = mensajesEmitidos.last()
  method esEscueta() = mensajesEmitidos.all({ m => m.size() <= 30 })
  method emitioMensaje(mensaje) = mensajesEmitidos.contains(mensaje)

  override method prepararViaje() {
    super();
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitioMensaje("Saliendo en misión")
  }

  override method esTranquila() = super() && !misilesDesplegados

  override method escapar() {
    self.acercarseUnPocoAlSol()
    self.alejarseUnPocoDelSol()
  }
  override method avisar() { self.emitirMensaje("Amenaza recibida") }
}

class Hospital inherits Pasajeros{
  var quirofanosPreparados

  method prepararQuirofano() { quirofanosPreparados = true }
  method desarmarQuirofano() { quirofanosPreparados = false }

  override method esTranquila() = super() && !quirofanosPreparados

  override method recibirAmenaza(){ 
    super();
    self.prepararQuirofano()
  }
}

class Sigilosa inherits Combate{
  override method esTranquila() = super() && !self.estaInvisible()

  override method escapar() {
    super();
    self.desplegarMisiles()
    self.ponerseInvisible()
  }
}