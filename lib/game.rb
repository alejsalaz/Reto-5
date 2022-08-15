# frozen_string_literal: true

# Banner será necesario para imprimir los mensajes decorados.
require './lib/banner'
# Handler será necesario para manipular el archivo de texto.
require './lib/handler'
# Player contiene la lógica relacionada con el jugador.
require './lib/player'
# Questionnaire será necesario para mostrar y evaluar las preguntas hechas.
require './lib/questionnaire'

# Game maneja la lógica principal del juego.
module Game
  # Game maneja todo el transcurso del juego.
  class Reto
    include Banner
    include Questionnaire
    extend Handler
    # Introducción
    read_file('assets/instructions.txt')
    Message.show('Greeting', '¡Te damos la bienvenida!')
    # Ajustando juego
    @player = Player.new
    @replay = true
    @left_attempts = 5

    def self.play
      @quiz = Quiz.new
      until @quiz.questions_left.zero?
        Message.space
        game_over and break if @player.lives.zero?

        # <3: 3 | pts: 0 | ?: 2
        @player.show_stats(@quiz.questions_left)
        # ¿Cuál es la extensión utilizada para guardar un archivo de Ruby?
        @quiz.pop_question
        # .rb | .rrb | .ruby | Ninguna
        @quiz.print_prompts

        update_stats
      end

      @player.show_final_stats
    end

    def self.update_stats
      if @quiz.correct_answer?
        @player.extra_score += 25
        Message.show('Congrats', "Así se hace, #{@player.name}.")
      else
        @player.lives -= 1
        @player.base_score > 25 ? @player.base_score /= 2 : @player.base_score = 0
        Message.show('Warning', "No, #{@player.name}. No era esa. :(")
      end
      @player.answered_questions += 1
      @quiz.questions_left -= 1
    end

    def self.game_over
      system 'clear' || (system 'cls')

      Message.show('Game Over', "#{@player.name}, la próxima lo harás mejor.")

      @quiz.questions_left = 0
    end

    # Jugando
    def self.start
      until @left_attempts.zero?
        play

        @player.lives = @left_attempts -= 1

        # Fin del juego
        if @left_attempts > 1
          show_replay_prompt
          replay = gets.chomp.to_i
          validate_replay(replay)
        end
        break unless @replay
      end
    end

    def self.validate_replay(replay)
      until replay.between?(1, 2)
        show_replay_prompt
        replay = gets.chomp.to_i
      end

      @replay = false if replay == 2
    end

    def self.show_replay_prompt
      Message.multiple_show(
        'Info',
        [
          '¿Quieres jugar otra vez? | 1: Sí | 2: No |',
          "Tienes #{@left_attempts} intentos restantes."
        ],
        petition: true
      )
    end

    start
  end
end
