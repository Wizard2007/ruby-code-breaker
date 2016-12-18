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

      it 'saves secret code with numbers from 1 to 6' do
        expect(subject.instance_variable_get(:@secret_code)).to match(/[1-6]+/)
      end               
                
      it 'valid generation' do
        subject.generate_secret_code
        expect(subject.secret_code_valid?).to eq(true)
      end

      it 'it should detect nil input' do
        expect(subject.secret_code_valid?(nil)).to eq(false)
      end

      it 'user guess code' do
        subject.instance_variable_set(:@step_count, 0)
        subject.instance_variable_set(:@secret_code, '1234')
        expect(subject.check_code('1234')).to eq('++++')
        expect(subject.instance_variable_get(:@step_count)).to eq(1)
      end

      it 'user don\'t guess ' do
        subject.instance_variable_set(:@step_count, 0)
        subject.instance_variable_set(:@secret_code, '1234')
        expect(subject.check_code('5678')).to be_empty
        expect(subject.instance_variable_get(:@step_count)).to eq(1)
      end
       
      it 'user don\'t gues order of all digits' do
        subject.instance_variable_set(:@step_count, 0)
        subject.instance_variable_set(:@secret_code, '1234')
        expect(subject.check_code('4321')).to eq('----')
        expect(subject.instance_variable_get(:@step_count)).to eq(1)
      end
      [[0,1,false],[1,1,true]]
      it 'should check game is over ' do
        subject.instance_variable_set(:@step_count, 1)
        subject.instance_variable_set(:@max_step_count, 1)
      end
    end
  end
end
