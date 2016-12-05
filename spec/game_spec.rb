require 'spec_helper'

module Codebreaker
  RSpec.describe Game do
    context '#start' do
      let(:game) {Game.new}
      
      before do
        game.start
      end

      it 'saves secret code' do
        expect(game.instance_variable_get(:@secret_code)).not_to be_empty
      end

      it 'saves 4 numbers secret code' do
        expect(game.instance_variable_get(:@secret_code).length).to eq(4)
      end

      it 'saves secret code with numbers from 1 to 9' do
        expect(game.instance_variable_get(:@secret_code)).to match(/[1-9]+/)
      end      
         
      it 'secret code has different numbers' do        
        game.instance_variable_set(:@secret_code, '1234')
        expect(game.secret_code_valid?).to eq(true)
      end
      
      it 'secret code has equal numbers' do
        game.instance_variable_set(:@secret_code, '1233')
        expect(game.secret_code_valid?).to eq(false)
      end
      
      it 'valid generation' do 
        game.generate_secret_code
        expect(game.secret_code_valid?).to eq(true) 
      end

      it 'user guess code' do
        game.instance_variable_set(:@secret_code, '1234')
        expect(game.check_code('1234')).to eq('++++')
      end

      it 'user don\'t guess ' do
        game.instance_variable_set(:@secret_code, '1234')
        expect(game.check_code('5678')).to be_empty
      end
       
      it 'user don\'t gues order of all digits' do
        game.instance_variable_set(:@secret_code, '1234')
        expect(game.check_code('4321')).to eq('----')
      end
       
    end
  end
end
