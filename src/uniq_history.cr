require "./uniq_history/*"

module UniqHistory
  class Filter
    def initialize(input : IO)
      @input = input
    end

    def de_duplicate
      format_output(command_cache)
    end

    private def format_output(cache)
      cache.map { |command, number|
        [number, command].join(" ")
      }.join("\n")
    end

    private def command_cache
      @input.each_line.each_with_object({} of String => String) { |line, cache|
        number, command = number_and_command(line)
        cache[command] ||= number unless number.empty? || command.empty?
      }
    end

    private def number_and_command(line)
      matches = line.scan(/(\d+)\s(.*)/)
      return ["", ""] if matches.empty?
      [matches[0][1], matches[0][2].strip]
    end
  end
end
