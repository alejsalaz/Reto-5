# frozen_string_literal: true

# Questionnaire contiene las opciones de respuesta y la clase encargada del quiz.
module Questionnaire
  OPTIONS = %w[
    A
    B
    C
    D
  ].freeze
  # Quiz se encarga de leer las preguntas que se le harán al jugador.
  class Quiz
    include Banner
    include Handler

    attr_accessor :questions_left

    def initialize
      Message.show('Info', 'Ingresa el número de preguntas que quieres contestar.', petition: true)
      @questions_left = gets.chomp.to_i

      until questions_left.between?(5, 10)
        Message.show('Error', 'El número debe estar entre 5 y 10.', petition: true)
        @questions_left = gets.chomp.to_i
      end

      @questions = (0..count_lines('assets/questions.txt') - 1).to_a.shuffle.delete_if(&:odd?)
    end

    def pop_question
      @current_question = @questions.pop
      @current_answer = [read_line('assets/questions.txt', @current_question + 1).split(' | ')[0]]

      Message.show('Question', read_line('assets/questions.txt', @current_question))
    end

    def print_prompts
      @current_prompts = read_line('assets/questions.txt', @current_question + 1).split(' | ').shuffle

      options = []
      @current_prompts.each_with_index do |prompt, index|
        options << "#{OPTIONS[index]} ─:#{prompt}"
      end

      Message.multiple_show('Options', options)
    end

    def correct_answer?
      @current_prompts.each_with_index do |prompt, index|
        @current_answer << OPTIONS[index] if prompt == @current_answer[0]
      end

      Message.show('Info', 'Ingresa la opción correcta', petition: true)
      answer = gets.chomp.capitalize

      until valid_answer?(answer)
        Message.show('Error', 'Ingresa el caracter que identifica la respuesta.', petition: true)
        answer = gets.chomp.capitalize
      end

      answer == @current_answer[1]
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
end
