require 'codebreaker/version'

require 'codebreaker/game'
require 'codebreaker/console_service'
require 'yaml'
module Codebreaker
  module Yaml_io
    def appned(file_name)
      yaml_string = self.to_yaml
      yaml_string += File.read file_name if File.exist?(file_name)
      File.write(file_name, yaml_string)
    end
  end
  class Player
    include(Yaml_io)
    attr_accessor :name, :score, :is_win
    def initialize
      @name = ''
      @score = 0
      @is_win = false
    end
  end
end
