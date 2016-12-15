module Codebreaker
  class ConsoleService
    attr_reader :is_game_over, :is_session_over, :hint_count, :current_game

    def initializer()
      @is_game_over = false
      @is_session_over = false
      @hint_count = 1
    end
    def start
      @current_game = Game.new
    end
    def get_user_input
      user_input = String.new(gets.chomp())
      (user_input != '') ? process_user_input(user_input) : process_user_input(:empty_input)
    end
    def process_user_input(user_input)
      respond_to?(user_input) ? send(user_input) : send(:unknown_command, user_input.to_s)
      #send(user_input)
    end
    def empty_input
      puts 'your should enter command or digits'
    end
    def unknown_command(command)
      puts "unknown command '#{command}'"
    end   
    def exit
      @is_session_over = true
      puts 'your exit game'
    end
    def hint
      @hint_count -= 1
      if (@hint_count <0) then
        puts 'your spend all hints'
        @hint_count = 0
      else
        puts "one of digits is : #{@current_game.get_hint_digit}"
      end
    end
  end
end
