# frozen_string_literal: true

module Doomfire
  module Platform
    module_function

    def lib_ext
      RbConfig::CONFIG['SOEXT']
    end

    def unix?
      RbConfig::CONFIG['host_os'].match?(/(aix|darwin|linux|(net|free|open)bsd|cygwin|solaris|irix|hpux)/i)
    end
  end
end
