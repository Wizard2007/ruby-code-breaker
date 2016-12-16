require 'spec_helper'

module Codebreaker
  RSpec.describe ConsoleService, 'Test ConsoleService' do
    subject { ConsoleService.new }
    context '# Test main console procedures ' do
      it 'exit game should set flag @is_session_over and print console message' do
        subject.instance_variable_set(:@is_session_over, false)
        expect{subject.exit}.to output("your exit game\n").to_stdout
        expect(subject.instance_variable_get(:@is_session_over)).to eq(true)
      end
      it 'hint should decrement variable @hint_count and print console message @hint_count > 0' do
        subject.instance_variable_set(:@hint_count, 1)
        subject.current_game.stub(:get_hint_digit).and_return('6')
        expect{subject.hint}.to output("one of digits is : 6\n").to_stdout
        expect(subject.instance_variable_get(:@hint_count)).to eq(0)
      end

      it 'hint should decrement variable @hint_count and print console message @hint_count = 0' do
        subject.instance_variable_set(:@hint_count, 0)
        expect{subject.hint}.to output("your spend all hints\n").to_stdout
        expect(subject.instance_variable_get(:@hint_count)).to eq(0)
      end

      it 'puts unknown command' do         
        expect{subject.unknown_command('test')}.to output("unknown command 'test'\n").to_stdout        
      end
      [:exit, :hint, :show_validation_result].each do |name|
        it "should process_user_input #{name.to_s}" do
          subject.start
          expect(subject).to receive(:send_user_input).with(name)
          subject.process_user_input(name)
        end
      end
    end
    context '# Test user input ' do
      it 'it should get any not empty user input' do
        l_test_input = 'test input'
        subject.start
        subject.stub(:gets).and_return(l_test_input)
        expect(subject).to receive(:send).with(:unknown_command, l_test_input)
        subject.get_user_input
      end
      it 'it should be not empty' do
        subject.start
        subject.stub(:gets).and_return('')
        expect(subject).to receive(:send).with(:empty_input)
        subject.get_user_input
      end

      it 'it should be validate by Game'
      it 'should test send_user_input'
      it 'should test show_validation_result'
    end
  end
end
