require 'spec_helper'

module Codebreaker
  RSpec.describe Game , 'Test Game' do
    subject {Game.new}
    context '#start' do
      before do
        subject.start
      end

      it 'saves secret code' do
        expect(subject.instance_variable_get(:@secret_code)).not_to be_empty
      end

      it 'saves 4 numbers secret code' do
        expect(subject.instance_variable_get(:@secret_code).length).to eq(4)
      end

      it 'saves secret code with numbers from 1 to 9' do
        expect(subject.instance_variable_get(:@secret_code)).to match(/[1-6]+/)
      end      
         
      it 'secret code has different numbers' do
        subject.instance_variable_set(:@secret_code, '1234')
        expect(subject.secret_code_valid?).to eq(true)
      end
      
      it 'secret code has equal numbers' do
        subject.instance_variable_set(:@secret_code, '1233')
        expect(subject.secret_code_valid?).to eq(false)
      end
      
      it 'valid generation' do
        subject.generate_secret_code
        expect(subject.secret_code_valid?).to eq(true)
      end

      it 'user guess code' do
        subject.instance_variable_set(:@secret_code, '1234')
        expect(subject.check_code('1234')).to eq('++++')
      end

      it 'user don\'t guess ' do
        subject.instance_variable_set(:@secret_code, '1234')
        expect(subject.check_code('5678')).to be_empty
      end
       
      it 'user don\'t gues order of all digits' do
        subject.instance_variable_set(:@secret_code, '1234')
        expect(subject.check_code('4321')).to eq('----')
      end
       
    end
  end
end
