require 'yle_tf/logger'

class YleTf
  module Action
    class Command
      attr_reader :command

      def initialize(app, command)
        @app = app
        @command = command
      end

      def call(env)
        if env[:tf_options][:only_hooks]
          Logger.debug "Skipping command #{command.class} due to `--only-hooks`"
        else
          Logger.debug "Executing command #{command.class} with env: #{env.inspect}"
          command.new.execute(env)
        end

        @app.call(env)
      end
    end
  end
end
