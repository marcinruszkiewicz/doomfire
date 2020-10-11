# frozen_string_literal: true

module Doomfire
  module Platform
    module_function

    def find_lib(library_name)
      library = "#{library_name}.#{lib_ext}"

      possible_locations = [
        # Ubuntu 20.04 LTS
        '/usr/lib/x86_64-linux-gnu'
      ]

      possible_locations << File.join(`brew --prefix sdl2`.chomp, 'lib') if homebrew_installed?

      Dir.glob(
        possible_locations.map do |path|
          File.expand_path(File.join(path, library))
        end
      ).first
    end

    def lib_ext
      RbConfig::CONFIG['SOEXT']
    end

    def unix?
      RbConfig::CONFIG['host_os'].match?(/(aix|darwin|linux|(net|free|open)bsd|cygwin|solaris|irix|hpux)/i)
    end

    def homebrew_installed?
      ENV['PATH'].include?('homebrew/bin')
    end
  end
end
