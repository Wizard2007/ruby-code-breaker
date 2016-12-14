require "codebreaker/version"

require 'codebreaker/game'

module Codebreaker
  class ConsoleService  
    attr_accessor :is_game_over. :is_session_over
    def initializer()
      @is_game_over = false
      @is_session_over = false
    end
    def get_user_input
      user_input = gets.chmod!
      (user_input != '') ? process_user_input(user_input) : process_user_input(:empty_input)
    end
    def process_user_input(user_input)
      user_input_sym = user_input.to_sym
      respond_to_missing?(user_input_sym) ? send(user_input_sym) : send(:unknown_command, user_input)
    end
    def empty_input
      puts 'your should enter comman or digits'
    end
    def unknown_command(command)
      puts "unknown command '#{command}'"
    end
    def exit
      @is_session_over = true
      puts 'your exit game'      
    end
  end
end
