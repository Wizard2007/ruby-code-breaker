module Codebreaker
  class Game
    attr_accessor :cuser_name, :attempt_count, :hint_count
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
      code.chars.each do |symbol|
        return false if code.count(symbol) > 1 
      end
      true
    end
    
    def play_game
    end
  end
end
