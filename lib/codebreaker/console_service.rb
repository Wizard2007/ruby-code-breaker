require "codebreaker/version"

require 'codebreaker/game'

module Codebreaker
  class ConsoleService  
    def get_user_input
      user_input = gets
      unput.chmp
      if 
      process_user_input(user_input)
    end
    def process_user_input(user_input)
      if respond_to_missing?(':#{user_input}') 
        send(user_input.to_sym)
      else
        send(:unknown_command, user_input)
      end 
    end
    def empty_input
      puts 'your should enter comman or digits'
    end
    def unknown_command(command)
      puts "unknown command '#{command}'"
    end
    def exit
      puts 'your exit game'
    end
  end
end
