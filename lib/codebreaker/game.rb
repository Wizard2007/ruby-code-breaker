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
      generate_secret_code     
    end
    
    def generate_secret_code 
      digits = []
      @secret_code = ''
      10.times {|i| digits << i}
      4.times do
        i = (rand() * digits.size).to_i       
        @secret_code += digits[i].to_s
        digits.delete_at(i)       
      end      
    end   
    def secret_code_valid?
      @secret_code.chars.each do |symbol|
        return false if @secret_code.count(symbol) > 1 
      end
      true
    end

    def check_code(code)
      result = ''
      code.chars.each_with_index do |element, index|
        if element == @secret_code[index] 
          result += '+'  
        else 
          result += '-' if @secret_code.include?(element)
        end
      end
      result
    end
   
    def play_game
    end
  end
end
