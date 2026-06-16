class Nave{
  var velocidad
  var direccionAlSol
  var combustible

  method acelerar(cuanto) { velocidad = 100000.min(velocidad + cuanto) }
  method desacelerar(cuanto) { velocidad = 0.max(velocidad - cuanto) }

  method irHaciaElSol() { direccionAlSol = 10 }
  method escaparDelSol() { direccionAlSol = -10 }
  method ponerseParaleloAlSol() { direccionAlSol = 0 }

  method acercarseUnPocoAlSol(){ direccionAlSol = (direccionAlSol + 1).min(10)}
  method alejarseUnPocoDelSol() { direccionAlSol = (direccionAlSol - 1).max(0)}

  method cargarCombustible(carga){ combustible += carga }
  method descargarCombustible(carga){ combustible -= carga }

  method prepararViaje() {
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }

  method esTranquila() = combustible >= 4000 && velocidad < 12000

  
  method escapar()
  method avisar() 
  method recibirAmenaza(){
    self.escapar()
    self.avisar()
  }

  method tienePocaActividad() = true
  method relajao() = self.esTranquila() && self.tienePocaActividad()
}