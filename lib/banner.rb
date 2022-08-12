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
    Info
    Warning
    Error
    Congratulate
    Greeting
  ].freeze

  # Message contiene todos los métodos para dar formato a las cadenas que se
  # mostrarán en consola.
  class Message
    def self.show(title, message, petition: false)
      @title = adjust_text(title)
      @message = adjust_text(message)

      @side_color = COLORS.sample
      @center_color = COLORS.sample

      puts [
        # |-Título─-|
        top_line,
        # | Mensaje |
        message_line,
        # |-───────-|
        bottom_line
      ].join("\n")
      # ─:
      print '─:' if petition
    end

    def self.adjust_text(string)
      if string.length > 58
        string.slice(1..58)
      else
        TITLES.include?(string) ? string : string.ljust(58, ' ')
      end
    end

    def self.top_line
      # |-
      '|-'.send(@side_color) +
        # |-Título
        @title.to_s +
        # |-Título─
        ('─' * (@message.length - @title.length)).send(@center_color) +
        # |-Título─-|
        '-|'.send(@side_color)
    end

    def self.message_line
      # | Mensaje |
      "| #{@message} |"
    end

    def self.bottom_line
      # |-
      '|-'.send(@side_color) +
        # |-───────
        ('─' * @message.length).send(@center_color) +
        # |-───────-|
        '-|'.send(@side_color)
    end
  end
end
