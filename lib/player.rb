# frozen_string_literal: true

# Printer será necesario para imprimir los mensajes decorados.
require './lib/printer'
# Player maneja la lógica del jugador, su nombre, puntaje y vidas.
class Player
  include Printer

  attr_accessor :lives, :base_score, :extra_score, :answered_questions
  attr_reader :name

  def initialize
    @name = request_name
    @lives = 5
    @base_score = 100
    @extra_score = 0
    @answered_questions = 0
  end

  def print_request_name
    beautiful_print(
      'Info',
      'Por favor ingresa tu nombre.',
      petition: true
    )
  end

  def request_name
    print_request_name
    name = gets.chomp.capitalize
    until name.match(/^\D+$/) && !name.strip.empty?
      print_invalid_name
      name = gets.chomp.capitalize
    end

    name
  end

  def print_invalid_name
    beautiful_print(
      'Error',
      'El nombre no debe contener números ni estar vacío.',
      petition: true
    )
  end

  def print_stats(questions_left)
    beautiful_print(@name.to_s, "<3: #{@lives} | pts: #{@base_score + @extra_score} | ?: #{questions_left}.")
  end

  def print_final_stats
    array_beautiful_print(
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
