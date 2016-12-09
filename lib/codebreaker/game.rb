module Codebreaker
  class Game
    attr_accessor :cuser_name, :attempt_count, :hint_count, :code_size
    def initialize
      @secret_code = ''
      @code_size = 4
    end

    def start
      init_game
    end

    def init_game
      generate_secret_code     
    end
    
    def generate_secret_code 
      digits = [1,2,3,4,5,6]
      @secret_code = digits.sample(code_size).join('')
    end

    def secret_code_valid?
      "/[1-@{code_size}]+/".match(@secret_code)
    end

    def check_code(code)
      result = ''
      l_code = string.new(@secret_code)
      code.chars.each_with_index do |element, index|
        if element == @l_code[index]
          result += '+'
        else
          result += '-' if l_code.include?(element)
        end
        l_code[index] = '*'
        code[index] = '*'
      end
      result
    end
   
    def play_game
    end
  end
end
