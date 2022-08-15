# frozen_string_literal: true

# Banner será necesario para imprimir los mensajes decorados.
require './lib/banner'

# Player maneja la lógica del jugador, su nombre, puntaje y vidas.
class Player
  include Banner

  attr_accessor :lives, :base_score, :extra_score, :answered_questions
  attr_reader :name

  def initialize
    self.class.show_name_prompt
    name = gets.chomp.capitalize

    self.class.validate_name(name)

    @name = name
    @lives = 5
    @base_score = 100
    @extra_score = 0
    @answered_questions = 0
  end

  def self.show_name_prompt
    Message.show(
      'Info',
      'Por favor ingresa tu nombre.',
      petition: true
    )
  end

  def self.validate_name(name)
    until name.match(/^\D+$/) && !name.strip.empty?
      show_invalid_name
      name = gets.chomp.capitalize
    end

    @name = name
  end

  def self.show_invalid_name
    Message.show(
      'Error',
      'El nombre no debe contener números ni estar vacío.',
      petition: true
    )
  end

  # def self.valid_name?(name)
  #   name.match(/^\D+$/) && !name.strip.empty? ? true : false
  # end

  def show_stats(questions_left)
    Message.show(@name.to_s, "<3: #{@lives} | pts: #{@base_score + @extra_score} | ?: #{questions_left}.")
  end

  def show_final_stats
    Message.multiple_show(
      'Puntaje final', [
        "Vidas: #{@lives}",
        "Pts base: #{@base_score}",
        "Pts extra: #{@extra_score}",
        "Pts totales: #{@base_score + @extra_score}",
        "Respuestas: #{@answered_questions}"
      ]
    )
  end
end
