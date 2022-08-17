# frozen_string_literal: true

# Player contiene la lógica relacionada con el jugador.
require './lib/player'
# Quiz será necesario para mostrar y evaluar las preguntas hechas.
require './lib/quiz'

# Game maneja todo el transcurso del juego.
class Game
  extend FileHandler
  extend Printer
  # Introducción
  read_file('assets/instructions.txt')
  beautiful_print('Greeting', '¡Te damos la bienvenida!')
  # Ajustando juego
  @player = Player.new
  @replay = true
  @left_attempts = 5
  # Jugando
  def self.run
    until @left_attempts.zero?
      play

      @player.lives = @left_attempts -= 1
      # Fin del juego
      if @left_attempts != 0
        print_request_replay
        replay = gets.chomp.to_i
        validate_replay(replay)
      end
      break unless @replay
    end
  end

  def self.play
    @quiz = Quiz.new(request_quiz)
    until @quiz.questions_left.zero?
      game_over and break if @player.lives.zero?

      put_space
      # <3: 3 | pts: 0 | ?: 2
      @player.print_stats(@quiz.questions_left)
      # ¿Cuál es la extensión utilizada para guardar un archivo de Ruby?
      @quiz.pop_question
      # .rb | .rrb | .ruby | Ninguna
      @quiz.print_prompts

      update_stats
    end

    @player.print_final_stats
  end

  def self.request_quiz
    beautiful_print('Info', 'Ingresa el número de preguntas que quieres contestar.', petition: true)
    questions_left = gets.chomp.to_i
    until questions_left.between?(5, 10)
      beautiful_print('Error', 'El número debe estar entre 5 y 10.', petition: true)
      questions_left = gets.chomp.to_i
    end

    questions_left
  end

  def self.game_over
    system 'clear' || (system 'cls')

    beautiful_print('Game Over', "#{@player.name}, la próxima lo harás mejor.")

    @quiz.questions_left = 0
  end

  def self.update_stats
    if @quiz.correct_answer?(@quiz.request_answer)
      @player.extra_score += 25

      beautiful_print('Congrats', "Así se hace, #{@player.name}.")
    else
      @player.lives -= 1
      @player.base_score > 6 ? @player.base_score /= 2 : @player.base_score = 0

      beautiful_print('Warning', "No, #{@player.name}. No era esa. :(")
    end

    @player.answered_questions += 1
    @quiz.questions_left -= 1
  end

  def self.validate_replay(replay)
    until replay.between?(1, 2)
      print_request_replay
      replay = gets.chomp.to_i
    end

    @replay = false if replay == 2
  end

  def self.print_request_replay
    array_beautiful_print(
      'Info',
      [
        '¿Quieres jugar otra vez? | 1: Sí | 2: No |',
        "Tienes #{@left_attempts} intentos restantes."
      ],
      petition: true
    )
  end
end

Game.run
