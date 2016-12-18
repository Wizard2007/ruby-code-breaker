module Codebreaker
  class Game
    attr_accessor :cuser_name, :attempt_count, :hint_count, :code_size, :user_vin, :step_count, :max_step_count
    def initialize
      @secret_code = ''
      @code_size = 4
      @step_count = 0
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

    def secret_code_valid?(code = '')
      return false if code == nil
      l_secret_code = @secret_code
      l_secret_code = code if code != ''
      l_secret_code.match( /[1-6]+/) ? true : false
    end

    def check_code(code)
      result = ''
      @step_count += 1
      @user_vin = false
      if @secret_code == code
        @user_vin = true
        return result = '++++'
      end
      l_code = String.new(@secret_code)
      code.chars.each_with_index do |element, index|
        l_include_index = 0
        if element == l_code[index]
          result += '+'
        else
          l_include_index = l_code.index(element)
          if l_include_index   
            result += '-' 
          else 
            l_include_index = 0
          end 
        end
        if l_include_index == 0
          l_code[index] = '*'
        else 
          l_code[l_include_index] = '*'
        end
        code[index] = '*'
      end
      result
    end
   
    def play_game
    end

    def get_hint_digit
      @secret_code.to_a.sample
    end
  end
end
