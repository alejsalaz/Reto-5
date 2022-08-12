require 'colorize'

module Banner
  COLORS = [
    :black,   :light_black,
    :red,     :light_red,
    :green,   :light_green,
    :yellow,  :light_yellow,
    :blue,    :light_blue,
    :magenta, :light_magenta,
    :cyan,    :light_cyan,
    :white,   :light_white
  ].freeze

  TITLES = [
    "Info",   "Warning",
    "Error",  "Congratulate"
  ].freeze

  class Message
    def self.show(title, message)
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
    end

    private

    def self.adjust_text(string)
      if string.length > 58
        string.slice(1..58)
      else
        TITLES.include?(string) ? string : string.ljust(58, ' ')
      end
    end

    def self.top_line
      # |-
      ("|-").send(@side_color) +
      # |-Título
      "#{@title}" +
      # |-Título─
      ("─" * (@message.length - (@title.length))).send(@center_color) +
      # |-Título─-|
      ("-|").send(@side_color)
    end

    def self.message_line
      # | Mensaje |
      ("| #{@message} |")
    end

    def self.bottom_line
      # |-
      ("|-").send(@side_color) +
      # |-───────
      ("─" * @message.length).send(@center_color) +
      # |-───────-|
      ("-|").send(@side_color)
    end

  end

end
