require 'guard/rack'

module Guard
  class Rack < Plugin
    class Command
      attr_reader :options

      def initialize(options = {})
        @options = options
      end

      def build
        cmd = [options[:cmd]]

        cmd << configuration
        cmd << port
        cmd << daemon
        cmd << debug
        cmd << server

        cmd.flatten.compact
      end

      private

      def configuration
        [options[:config]]
      end

      def daemon
        return unless options[:daemon]

        ['--daemonize']
      end

      def debug
        return unless options[:debugger]

        ['--debug']
      end

      def port
        ['-p', options[:port].to_s]
      end

      def server
        return unless options[:server]

        ['--server', options[:server].to_s]
      end
    end
  end
end
