# frozen_string_literal: true

# Printer será necesario para imprimir los mensajes decorados.
require './lib/printer'
# Handler será necesario para manipular el archivo de texto.
require './lib/file_handler'
# Quiz se encarga de leer las preguntas que se le harán al jugador.
class Quiz
  include Printer
  include FileHandler

  OPTIONS = %w[
    A
    B
    C
    D
  ].freeze

  attr_accessor :questions_left

  def initialize(questions_left)
    @questions_left = questions_left
    @questions = shuffle_questions
  end

  def shuffle_questions
    (0..count_lines('assets/questions.txt') - 1).to_a.shuffle.delete_if(&:odd?)
  end

  def pop_question
    @current_question = @questions.pop
    @current_answer = [read_line('assets/questions.txt', @current_question + 1).split(' | ')[0]]

    beautiful_print('Question', read_line('assets/questions.txt', @current_question))
  end

  def print_prompts
    @current_prompts = read_line('assets/questions.txt', @current_question + 1).split(' | ').shuffle

    options = []
    @current_prompts.each_with_index do |prompt, index|
      options << "#{OPTIONS[index]} ─:#{prompt}"
    end

    array_beautiful_print('Options', options)
  end

  def correct_answer?(answer)
    answer == @current_answer[1]
  end

  def request_answer
    @current_prompts.each_with_index do |prompt, index|
      @current_answer << OPTIONS[index] if prompt == @current_answer[0]
    end

    beautiful_print('Info', 'Ingresa la opción correcta', petition: true)
    answer = gets.chomp.capitalize

    until valid_answer?(answer)
      beautiful_print('Error', 'Ingresa el caracter que identifica la respuesta.', petition: true)
      answer = gets.chomp.capitalize
    end

    answer
  end

  def valid_answer?(answer)
    case @current_prompts.size
    when 2
      answer.match?('^[a-bA-B]{1}$')
    when 4
      answer.match?('^[a-dA-D]{1}$')
    end
  end
end
