# frozen_string_literal: true

# Colorize permite dar colores a los mensajes.
require 'colorize'
# Printer contiene todos los métodos para dar formato a las cadenas que se
# mostrarán en consola.
module Printer
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
  # Títulos recomendados: Congrats, Error, Game Over,
  # Greeting, Info, Question, Options, Warning.
  def beautiful_print(title, message, petition: false)
    @title = title.length > 58 ? title.slice(1..58).capitalize : title

    @side_color = COLORS.sample
    @center_color = COLORS.sample
    puts [
      # |-Título─-|
      top_line,
      # | Mensaje |
      adjust_message(message),
      # |-───────-|
      bottom_line
    ].join("\n")
    # ─:
    print '─:' if petition
  end

  def adjust_message(string)
    # |
    message = '| '
    if string.length > 58
      lines = string.scan(/.{1,58}/)
      # | Mensaje-|
      # largo
      message += lines.join("-|\n")
    else
      message += string.ljust(58, ' ')
      # | Mensaje |
      message += ' |'
    end

    message
  end

  def top_line
    # |-
    '|-'.send(@side_color) +
      # |-Título
      @title.to_s +
      # |-Título─
      ('─' * (58 - @title.length)).send(@center_color) +
      # |-Título─-|
      '-|'.send(@side_color)
  end

  def bottom_line
    # |-
    '|-'.send(@side_color) +
      # |-───────
      ('─' * 58).send(@center_color) +
      # |-───────-|
      '-|'.send(@side_color)
  end

  def put_space
    puts ('=' * 62).send(COLORS.sample)
  end

  def array_beautiful_print(title, message, petition: false)
    @title = title.length > 58 ? title.slice(1..58).capitalize : title

    @side_color = COLORS.sample
    @center_color = COLORS.sample
    # |-Título─────-|
    puts top_line
    # | A. Mensajes |
    # | B. Mensajes |
    message.each { |line| puts "| #{line.ljust(58, ' ')} |" }
    # |-───────────-|
    puts bottom_line
    # ─:
    print '─:' if petition
  end
end
