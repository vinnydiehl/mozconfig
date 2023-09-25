# frozen_string_literal: true

require "optimist"
require "tty-prompt"

require "core_ext/string"

VERSION = File.read(File.expand_path("../VERSION", __dir__)).strip.freeze

module MozConfig
  class TUI
    def initialize
      check_options

      unless File.exist?("mozconfig")
        $stderr.puts "Error: mozconfig not found."
        exit 1
      end

      # Fix whitespace-only lines and split by paragraph, then each paragraph
      # into lines
      @mozconfig = File.read("mozconfig")
        .gsub(/^\s+$/, "")
        .split(/\n{2,}/)
        .map { |p| p.lines.map(&:strip_beginning) }

      # Only paragraphs that begin with a comment are recognized as configs;
      # anything else will remain active globally.
      configs, @globals = @mozconfig.partition { |p| p.first.commented? }
      # Form configs into a hash with the names as keys
      @configs = configs.to_h { |cfg| [cfg.first.uncomment.strip, cfg[1..]] }
      # Globals won't be manipulated further so we can rejoin them
      @globals.map!(&:join)

      # Find the active config
      @active = @configs.find { |_, options| !options.first.commented? }.first
    end

    def run
      selection = begin
        TTY::Prompt.new.select("Pick a configuration", @configs, default: @active)
      rescue TTY::Reader::InputInterrupt
        $stderr.puts "\nProcess interrupted. Closing"
        exit 130
      end

      output = "#{@globals.join("\n\n")}\n\n"

      output << @configs.map do |name, options|
        action = options == selection ? :uncomment : :comment
        "#{name.comment}\n#{options.map(&action).join}"
      end.join("\n\n")

      File.write("mozconfig", output)
    end

    private

    # Parses command-line options.
    def check_options
      @opts = Optimist.options do
        version "mozconfig Picker #{VERSION}"
        banner version
        banner "https://github.com/vinnydiehl/mozconfig"
        banner "\nOptions:"
        opt :version, "display version number"
        opt :help, "display this message"
        educate_on_error
      end
    end
  end
end
