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
      @secret_code.match( /[1-6]+/) ? true : false
    end

    def check_code(code)
      result = ''
      return result = '++++' if @secret_code == code
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
  end
end
