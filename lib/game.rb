# frozen_string_literal: true

# Banner será necesario para imprimir los mensajes decorados.
require './lib/banner'

# Handler será necesario para manipular el archivo de texto
require './lib/handler'

# Questionnaire se encarga de leer las preguntas que se le harán al jugador.
class Questionnaire
  include Banner
  attr_accessor :total_questions

  def initialize
    Message.show('Info', 'Ingresa el número de preguntas que quieres contestar.', petition: true)
    total_questions = gets.chomp.to_i

    until total_questions.between?(5, 10)
      Message.show('Error', 'El número debe estar entre 5 y 10.', petition: true)
      total_questions = gets.chomp.to_i
    end

    @total_questions = total_questions
  end
end

# Player maneja la lógica del jugador, su nombre, puntaje y vidas.
class Player
  include Banner

  attr_accessor :lives
  attr_reader :player_name

  def initialize
    Message.show('Info', 'Por favor ingresa tu nombre.', petition: true)
    player_name = gets.chomp.capitalize

    until self.class.valid_name?(player_name) == true
      Message.show('Error', 'El nombre no debe contener números ni estar vacío.', petition: true)
      player_name = gets.chomp.capitalize
    end

    @player_name = player_name
    @lives = 3
  end

  def self.valid_name?(player_name)
    player_name.match(/^\D+$/) && !player_name.strip.empty? ? true : false
  end
end

# Game maneja todo el transcurso del juego.
class Game
  include Banner
  extend Handler
  # Introducción
  read_file('assets/instructions.txt')
  Message.show('Greeting', '¡Te damos la bienvenida!')
  # //Message.show('Info', '<3: #{vidas} | pts: #{puntos} | ?: #{preguntas} ')
  # Ajustando juego
  Player.new
  Questionnaire.new
  # TODO: Jugando
  # until Questionnaire.total_questions.zero?
  #   puts Questionnaire.total_questions.to_s
  #   Questionnaire.total_questions -= 1
  # end
  # TODO: Fin del juego
end
