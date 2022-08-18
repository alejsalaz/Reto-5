# frozen_string_literal: true

# Printer será necesario para imprimir los mensajes decorados.
require './app/lib/printer'
# Game contiene toda la lógica del juego, jugador, quiz y demás.
require './app/lib/game'
# QuestionsController tiene el CRUD para las preguntas.
require './app/lib/quiz_handler'
# Reto permite correr un juego o actualizar las preguntas del juego.
class Reto
  extend FileHandler
  extend Printer

  beautiful_print('Greeting', '¡Te damos la bienvenida!')

  def self.request_action
    beautiful_print('Info', '¿Qué quieres hacer hoy? | 1: Jugar | 2: Editar |', petition: true)
  end

  def self.validate_action(action)
    until action.match(/^[1-2]$/)
      request_action
      action = gets.chomp
    end
  end

  request_action
  action = gets.chomp
  validate_action(action)

  system 'clear' || (system 'cls')

  case action.to_i
  when 1
    print_file('./app/assets/game_instructions.txt')

    Game.run
  when 2
    QuizHandler.run
  else
    print_file('./app/assets/error.txt')
  end
end
