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

    attr_accessor :total_questions

    def initialize
      Message.show('Info', 'Ingresa el número de preguntas que quieres contestar.', petition: true)
      @total_questions = gets.chomp.to_i

      until total_questions.between?(5, 10)
        Message.show('Error', 'El número debe estar entre 5 y 10.', petition: true)
        @total_questions = gets.chomp.to_i
      end

      @questions = (0..count_lines('assets/questions.txt') - 1).to_a.shuffle.delete_if(&:odd?)
    end

    def ask_question
      current_question = @questions.pop
      Message.show('Question', read_line('assets/questions.txt', current_question))

      @answers = read_line('assets/questions.txt', current_question + 1).split(' | ').shuffle
      index = 0
      @answers.each do |option|
        Message.show('Option', "#{OPTIONS[index]} ─:#{option}")
        index += 1
      end
    end

    def rate_answer
      Message.show('Info', 'Ingresa la opción correcta', petition: true)
      answer = gets.chomp.capitalize

      until valid_answer?(answer)
        Message.show('Error', 'Ingresa el caracter que identifica la respuesta.', petition: true)
        answer = gets.chomp.capitalize
      end
    end

    def valid_answer?(answer)
      case @answers.size
      when 2
        answer.match?('^[a-bA-B]{1}$')
      when 4
        answer.match?('^[a-dA-D]{1}$')
      end
    end
  end
end
