module Codebreaker
  class ConsoleService
    attr_reader :is_game_over, :is_session_over, :hint_count, :current_game

    def initializer()
    end
    def start
      @current_game = Game.new
      @is_session_over = false
      @is_game_over = false
      @hint_count = 1
    end
    def get_user_input
      user_input = String.new(gets.chomp())
      (user_input != '') ? process_user_input(user_input) : process_user_input(:empty_input)
    end
    def process_user_input(user_input)
      if @current_game.secret_code_valid?(user_input) then
        send(:show_validation_result, user_input)
      else
        send_user_input(user_input)
      end
    end
    def send_user_input(user_input)
      respond_to?(user_input) ? send(user_input) : send(:unknown_command, user_input.to_s)
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
    def show_validation_result(code)
      puts "validation result : #{@current_game.check_code(code)}"
    end
  end
end
