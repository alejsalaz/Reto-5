# Banner será necesario para imprimir los mensajes decorados.
require './lib/banner.rb'
include Banner

# Handler será necesario para manipular el archivo de texto
require './lib/handler.rb'
include Handler

class Question

end

class Player

end

class Game
  # TODO: Introducción
  read_file('assets/instructions.txt')
  Message.show("Info", "¡Te damos la bienvenida!")
  # //Message.show("Info", "<3: #{vidas} | pts: #{puntos} | ?: #{preguntas} ")
  # TODO: Ajustando juego

  # TODO: Jugando

  # TODO: Fin del juego
end
