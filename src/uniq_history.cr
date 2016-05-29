require "./uniq_history/*"

module UniqHistory
  class Filter
    def initialize(io : IO)
      @io = io
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
      @io.each_line.each_with_object({} of String => String) { |line, cache|
        number, command = number_and_command(line)
        cache[command] ||= number
      }
    end

    private def number_and_command(line)
      match = line.scan(/(\d+)\s(.*)/).first
      [match[1], match[2]]
    end
  end
end
