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

      it 'saves secret code with numbers from 1 to 6' do
        expect(game.instance_variable_get(:@secret_code)).to match(/[1-6]+/)
      end      
         
      it 'secret code has different numbers' do        
        game.instance_variable_set(:@secret_code, '1234')
        expect(game.secret_code_valid?).to eq(true)
      end
      
      it 'secret code has equal numbers' do
        game.instance_variable_set(:@secret_code, '1233')
        expect(game.secret_code_valid?).to eq(false)
      end
      it 'user guess code'

      it 'user don\'t guess '
    end
  end
end
