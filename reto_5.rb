# Preguntas
# -------------------------------------
questions_array =
[
  {
    id: 1,
    prompt: """¿Qué imprimiría el siguiente código?
    > pedro = 'Pedro'
    > maria = pedro
    > puts maria
    ------------------------------------
    a) 'Pedro'
    b) 'maria'
    c) 'Maria'
    d) nil
    ------------------------------------""",
    answer: "a"
  },
  {
    id: 2,
    prompt: """
    ------------------------------------
    ¿Cuál sería el resultado de la siguiente expresión?
    > 'YO' + 'LO'
    ------------------------------------
    a) Lanzaría un error
    b) Ninguna de las anteriores
    c) 4241
    d) 'YOLO'
    ------------------------------------""",
    answer: "d"
  },
  {
    id: 3,
    prompt: """
    ------------------------------------
    ¿Cuál de las siguientes expresiones es un comentario válido en Ruby??
    ------------------------------------
    a) # Esto es un comentario
    b) /* esto es un comentario */
    c) // Esto es un comentario
    d) <!— esto es un comentario —>
    ------------------------------------""",
    answer: "a"
  },
  {
    id: 4,
    prompt: """
    ------------------------------------
    En Ruby todos los métodos retornan algún valor
    ------------------------------------
    a) Verdadero
    b) Falso
    ------------------------------------""",
    answer: "a"
  },
  {
    id: 5,
    prompt: """
    ------------------------------------
    ¿Qué imprimiría en pantalla el siguiente código?
    > num = 5
    > 3.times { num = num + 5 }\n
    > puts num

    a) 5
    b) 25
    c) Un error
    d) 15
    e) 20
    ------------------------------------""",
    answer: "e"
  }
]

# Funcionalidades
# -------------------------------------
class Question
  attr_accessor :prompt, :answer

  def initialize(prompt, answer)
    @prompt = prompt
    @answer = answer
  end
end

questions = [
  Question.new(questions_array[0][:prompt], questions_array[0][:answer]),
  Question.new(questions_array[1][:prompt], questions_array[1][:answer]),
  Question.new(questions_array[2][:prompt], questions_array[2][:answer]),
  Question.new(questions_array[3][:prompt], questions_array[3][:answer]),
  Question.new(questions_array[4][:prompt], questions_array[4][:answer])
]

def run_test(questions, lives)
  score = 0
  max_lives = lives
  questions.each do |question|
    break if lives == 0
    puts question.prompt, "\nTu respuesta: "
    answer = gets.chomp()
    if answer == question.answer
      score += 1
      congrat(score)
    else
      lives -= 1
      if lives > 1
        wrong(lives)
        redo
      elsif lives == 1
        note(lives)
        redo
      else
        game_over()
      end
    end
  end
  game_finished?(max_lives, lives)
end

def congrat(score)
  print "-" * 36 + "\n" +
  "¡Buena!\n" +
  "Ahora tienes  #{score} puntos.\n" +
  "-" * 36 + "\n"
end

def wrong(lives)
  print "-" * 36 +"\n" +
    "Uy, esa no era la respuesta,\n" +
    "pero no pasa nada, te quedan #{lives} vidas.\n" +
    "-" * 36 + "\n"
end

def note(lives)
  print "-" * 36 +"\n" +
    "Uy, esa no era la respuesta,\n" +
    "ten cuidado, te queda #{lives} vida.\n" +
    "-" * 36 + "\n"
end

def game_finished?(max_lives, lives)
  if lives > 0
    print "-" * 36 +"\n" +
      "¡Has superado el reto! :)\n" +
      "terminaste con #{lives}/#{max_lives} vidas.\n" +
      "-" * 36 + "\n"
  end
end

def game_over()
  print "-" * 36 +"\n" +
    "No pudiste superar el reto :(\n" +
    "ya no te quedan vidas.\n" +
    "-" * 36 + "\n"
  true
end

# Interfaz
# -------------------------------------
mainloop = true
while mainloop
  print "=" * 70+"\n" +
    "¡Esto es reto 5!\n" +
    "-" * 70+ "\n" +
    "Tienes 3 vidas, responde con el carácter correcto para ganar.\n" +
    "-" * 70+ "\n" +
    "!Vamos!\n" +
    "=" * 70 +"\n"
  run_test(questions, 3)
  mainloop = false
end
