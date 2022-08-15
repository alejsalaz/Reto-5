# frozen_string_literal: true

# Banner será necesario para imprimir los mensajes decorados.
require './lib/banner'

# Handler será necesario para manipular el archivo de texto.
require './lib/handler'

# Questionnaire será necesario para mostrar y evaluar las preguntas hechas.
require './lib/questionnaire'

# Player maneja la lógica del jugador, su nombre, puntaje y vidas.
class Player
  include Banner

  attr_accessor :lives
  attr_reader :name

  def initialize
    Message.show('Info', 'Por favor ingresa tu nombre.', petition: true)
    name = gets.chomp.capitalize

    until self.class.valid_name?(name) == true
      Message.show('Error', 'El nombre no debe contener números ni estar vacío.', petition: true)
      name = gets.chomp.capitalize
    end

    @name = name
    @lives = 3
  end

  def self.valid_name?(name)
    name.match(/^\D+$/) && !name.strip.empty? ? true : false
  end
end

# Game maneja todo el transcurso del juego.
class Game
  include Banner
  include Questionnaire
  extend Handler
  # Introducción
  read_file('assets/instructions.txt')
  Message.show('Greeting', '¡Te damos la bienvenida!')
  # //Message.show('Info', '<3: #{vidas} | pts: #{puntos} | ?: #{preguntas} ')
  # Ajustando juego
  def self.play
    player = Player.new
    quiz = Quiz.new
    until quiz.total_questions.zero?
      quiz.ask_question
      quiz.rate_answer
      quiz.total_questions -= 1
    end
  end
  # Jugando
  play
  # TODO: Fin del juego
end
