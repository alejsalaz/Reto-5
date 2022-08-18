# frozen_string_literal: true

# Printer será necesario para imprimir los mensajes decorados.
require './app/lib/printer'
# Handler será necesario para manipular el archivo de texto.
require './app/lib/file_handler'
# QuestionsController será necesario para manipular el archivo de las preguntas.
class QuestionsController
  extend FileHandler
  extend Printer

  def self.index
    current_question = 0

    questions_array = (0..count_lines('./app/model/questions.txt') - 1).to_a.delete_if(&:odd?)
    questions_array.each do |question_index|
      current_question += 1

      beautiful_print(
        'Question',
        "Pregunta n°#{current_question}: #{read_line('./app/model/questions.txt', question_index)}"
      )
      beautiful_array_print('Options', read_line('./app/model/questions.txt', question_index + 1).split(' | '))
    end
  end

  def self.show(question_index)
    if question_index >= count_lines('./app/model/questions.txt')
      print_file('./app/assets/error.txt')
    else
      beautiful_print(
        'Question',
        read_line('./app/model/questions.txt', question_index)
      )
      beautiful_array_print('Options', read_line('./app/model/questions.txt', question_index + 1).split(' | '))
    end
  end

  def self.add(question, answers)
    write_lines('./app/model/questions.txt', [question, answers])
  end

  def self.edit(question_index, question, answers)
    overwrite_lines('./app/model/questions.txt', question_index, [question, answers])
  end

  def self.destroy(question_index)
    delete_lines('./app/model/questions.txt', question_index)
  end
end
