# frozen_string_literal: true

# Colorize permite dar colores a los mensajes.
require 'colorize'

module Banner
  COLORS = %i[
    black
    light_black
    red
    light_red
    green
    light_green
    yellow
    light_yellow
    blue
    light_blue
    magenta
    light_magenta
    cyan
    light_cyan
    white
    light_white
  ].freeze

  TITLES = %w[
    Congratulate
    Error
    Greeting
    Info
    Question
    Option
    Warning
  ].freeze

  # Message contiene todos los métodos para dar formato a las cadenas que se
  # mostrarán en consola.
  class Message
    def self.show(title, message, petition: false)
      @title = TITLES.include?(title) ? title : TITLES[1]
      adjust_message(message)

      @side_color = COLORS.sample
      @center_color = COLORS.sample

      puts [
        # |-Título─-|
        top_line,
        # | Mensaje |
        @message,
        # |-───────-|
        bottom_line
      ].join("\n")
      # ─:
      print '─:' if petition
    end

    def self.adjust_message(string)
      # |
      @message = '| '
      if string.length > 58
        lines = string.scan(/.{1,58}/)
        # | Mensaje-|
        # largo
        @message += lines.join("-|\n")
      else
        @message += string.ljust(58, ' ')
        # | Mensaje |
        @message += ' |'
      end
    end

    def self.top_line
      # |-
      '|-'.send(@side_color) +
        # |-Título
        @title.to_s +
        # |-Título─
        ('─' * (58 - @title.length)).send(@center_color) +
        # |-Título─-|
        '-|'.send(@side_color)
    end

    def self.bottom_line
      # |-
      '|-'.send(@side_color) +
        # |-───────
        ('─' * 58).send(@center_color) +
        # |-───────-|
        '-|'.send(@side_color)
    end
  end
end
