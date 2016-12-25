module Codebreaker
  class Game
    attr_accessor :cuser_name, :attempt_count, :hint_count, :code_size, :user_win, :step_count, :max_step_count
    def initialize
      @secret_code = ''
      @code_size = 4
      @step_count = 0
      @max_step_count = 10
      @user_win = false
    end

    def start
      init_game
    end

    def init_game
      generate_secret_code
      @step_count = 0
    end
    
    def generate_secret_code 
      digits = [1,2,3,4,5,6]
      @secret_code = digits.sample(code_size).join('')
    end

    def game_over?
      @step_count > @max_step_count
    end

    def secret_code_valid?(code = '')
      return false if code.nil?
      l_secret_code = @secret_code
      l_secret_code = code if code != ''
      l_secret_code.match( /[1-6]+/) ? true : false
    end

    def check_user_guess(code)
      @user_win = @secret_code == code
      @user_win ? '++++' : ''
    end

    def check_code(code)
      @step_count += 1
      result = check_user_guess(code)
      return result if @user_win
      l_code = String.new(@secret_code)
      code.chars.each_with_index do |element, index|
        l_include_index = 0
        if element == l_code[index]
          result += '+'
        else
          l_include_index = l_code.index(element)
          l_include_index ? result += '-' : l_include_index = 0
        end
        (l_include_index == 0) ? l_code[index] = '*' : l_code[l_include_index] = '*'
      end
      result
    end

    def get_hint_digit
      @secret_code.split('').sample
    end
  end
end
