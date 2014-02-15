require 'rbconfig'
require_relative 'mouse/mac'
require_relative 'mouse/linux'

module Mouse
  class << self
    def new(speed)
      mouse_for os, speed
    end

    def mouse_for(os, speed)
      case os
        when :linux
          Mouse::Linux.new speed
        when :macosx
          Mouse::Mac.new speed
        end
    end

    private

    def os
      @os ||= (
        host_os = RbConfig::CONFIG['host_os']
        case host_os
        when /mswin|msys|mingw|cygwin|bccwin|wince|emc/
          :windows
        when /darwin|mac os/
          :macosx
        when /linux/
          :linux
        when /solaris|bsd/
          :unix
        else
          raise Error::WebDriverError, "unknown os: #{host_os.inspect}"
        end
      )
    end
  end

end
