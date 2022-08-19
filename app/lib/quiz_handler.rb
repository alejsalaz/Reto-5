# frozen_string_literal: true

# Printer será necesario para imprimir los mensajes decorados.
require './app/lib/printer'
# FileHandler será necesario para manipular el archivo de texto.
require './app/lib/file_handler'
# QuestionsController tiene el CRUD para las preguntas.
require './app/controllers/questions_controller'

# QuizHandler permite utilizar el questions_controller de forma gráfica.
class QuizHandler
  extend FileHandler
  extend Printer

  def self.run
    @quit = false

    until @quit.eql?(true)
      request_action
      action = gets.chomp
      validate_action(action)
    end
  end

  def self.request_action
    print_file('./app/assets/questions_instructions.txt')
    beautiful_print('Options', '¿Qué deseas hacer?', petition: true)
  end

  def self.validate_action(action)
    until action.match(/^[1-6]$/)
      request_action
      action = gets.chomp
    end

    run_action(action)
  end

  def self.run_action(action)
    case action.to_i
    when 1 then QuestionsController.index
    when 2 then show_question
    when 3 then add_question
    when 4 then QuestionsController.edit(validate_question_index, request_question_statement, request_question_answer)
    when 5 then QuestionsController.destroy(validate_question_index)
    when 6 then @quit = true
    else
      print_file('./app/assets/error.txt')
    end
  end

  def self.show_question
    request_question_index

    question = gets.chomp
    validate_question(question)
  end

  def self.request_question_index
    beautiful_print('Info', 'Ingresa el número de la pregunta que quieres revisar.', petition: true)
  end

  def self.validate_question(question)
    until valid_question_index?(question)
      request_question_index
      question = gets.chomp
    end

    QuestionsController.show(question.to_i + (question.to_i - 2))
  end

  def self.valid_question_index?(question)
    question.match(/^\d+$/) && question.to_i < count_lines('./app/model/questions.txt')
  end

  def self.add_question
    QuestionsController.add(request_question_statement, request_question_answer)
  end

  def self.validate_question_index(question = 'invalid question')
    until valid_question_index?(question)
      request_question_index
      question = gets.chomp
    end

    question.to_i + (question.to_i - 2)
  end

  def self.request_question_statement
    beautiful_print('Info', 'Ingresa el enunciado de la pregunta', petition: true)
    gets.chomp
  end

  def self.request_question_answer
    beautiful_print('Info', 'Ingresa las respuestas, ten en cuenta las recomendaciones.', petition: true)
    gets.chomp
  end
end
