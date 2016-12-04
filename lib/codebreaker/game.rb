module Codebreaker
  class Game
    def initialize
      @secret_code = ''
    end

    def start
      init_game
    end

    def init_game
      @secret_code = generate_secret_code     
    end
    
    def generate_secret_code 
      '1234'
    end
    
    def secret_code_valid?(code)
      true
    end
  end
end
