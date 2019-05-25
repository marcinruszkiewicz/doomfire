# frozen_string_literal: true

module Doomfire
  class WindowSize
    def terminal_width
      return 80 unless unix?

      result = dynamic_width
      result < 20 ? 80 : result
    rescue StandardError
      80
    end

    # rubocop:disable Lint/DuplicateMethods
    begin
      require 'io/console'

      def dynamic_width
        if IO.console
          dynamic_width_via_io_object
        else
          dynamic_width_via_system_calls
        end
      end
    rescue LoadError
      def dynamic_width
        dynamic_width_via_system_calls
      end
    end
    # rubocop:enable Lint/DuplicateMethods

    def dynamic_width_via_io_object
      _rows, columns = IO.console.winsize
      columns
    end

    def dynamic_width_via_system_calls
      dynamic_width_stty.nonzero? || dynamic_width_tput
    end

    def dynamic_width_stty
      `stty size 2>/dev/null`.split[1].to_i
    end

    def dynamic_width_tput
      `tput cols 2>/dev/null`.to_i
    end

    def unix?
      RUBY_PLATFORM =~ /(aix|darwin|linux|(net|free|open)bsd|cygwin|solaris|irix|hpux)/i
    end
  end
end
