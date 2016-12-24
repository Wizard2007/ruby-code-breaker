require 'spec_helper'

module Codebreaker
  RSpec.describe ConsoleService, 'Test ConsoleService' do
    subject { ConsoleService.new }
    context '# Test main console procedures ' do

      it 'yes procedure' do
        subject.instance_variable_set(:@start_new_game, false)
        expect{subject.yes}.to output("ok we will start new game\n").to_stdout
        expect(subject.instance_variable_get(:@start_new_game)).to eq(true)
      end
      it 'no procedure' do
        subject.instance_variable_set(:@start_new_game, true)
        expect{subject.no}.to output("ok we will close your session\n").to_stdout
        expect(subject.instance_variable_get(:@start_new_game)).to eq(false)
      end
      it 'shoud print your vin' do
        subject.instance_variable_set(:@is_game_over, false)
        expect{subject.your_vin}.to output("your vin\n").to_stdout
        expect(subject.instance_variable_get(:@is_game_over)).to eq(true)
      end
      it 'shoud print your loose' do
        subject.instance_variable_set(:@is_game_over, false)
        expect{subject.your_loose}.to output("your loose\n").to_stdout
        expect(subject.instance_variable_get(:@is_game_over)).to eq(true)
      end
      it 'exit game should set flag @is_session_over and print console message' do
        subject.instance_variable_set(:@is_session_over, false)
        expect{subject.exit_}.to output("your exit game\n").to_stdout
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
      it ' should call get_user_input puts start new game?' do
        expect(subject).to receive(:get_user_input)
        subject.instance_variable_set(:@restaet_was_called, false)
        expect{subject.restart_game}.to output("start new game? type yes / no\n").to_stdout
        expect(subject.instance_variable_get(:@restaet_was_called)).to eq(true)
      end
      array_of_main_function = [:exit_, :hint, :show_validation_result, :your_vin,:your_lose,:restart_game,:yes,:no]
      array_of_main_function.each do |name|
        it "should process_user_input #{name.to_s}" do
          subject.start
          subject.instance_variable_set(:@restaet_was_called, false)
          expect(subject).to receive(:send_user_input).with(name)
          subject.process_user_input(name)
        end
      end
      sub_array_of_main_function = array_of_main_function - [:yes,:no]
      sub_array_of_main_function.each do |name|
        it "should re ask  #{name.to_s}" do
          subject.start
          subject.instance_variable_set(:@restaet_was_called, true)
          expect(subject).to receive(:send).with(:restart_game)
          subject.process_user_input(name)
        end
      end
    end
    context '# Test user input ' do
      it 'should get any not empty user input' do
        l_test_input = 'test input'
        subject.start
        subject.stub(:gets).and_return(l_test_input)
        expect(subject).to receive(:send).with(:unknown_command, l_test_input)
        subject.get_user_input
      end
      it 'should be not empty' do
        subject.start
        subject.stub(:gets).and_return('')
        expect(subject).to receive(:send).with(:empty_input)
        subject.get_user_input
      end
      it 'should be validate by Game' do
        subject.start
        user_input = '1111'
        expect(subject).to receive(:send).with(:show_validation_result,user_input)
        subject.process_user_input(user_input)
      end
      it 'not validated by game and call send_user_input(user_input)' do
        subject.start
        user_input = 'vvv'
        expect(subject).to receive(:send_user_input).with(user_input)
        subject.process_user_input(user_input)
      end
      [:test].each do |name|
        it "should test call process_user_input and call send_user_input :unknown_command #{name}" do
          subject.start
          expect(subject).to receive(:send).with(:unknown_command, name.to_s)
          subject.process_user_input(name)
        end
      end

      [['1111','1111',"validation result : ++++\n"], ['1234','4321',"validation result : ----\n"] , ['1245','1254',"validation result : ++--\n"]].each do  |l_secret_code, l_code, l_out_put|
        it "should show validation result for #{l_secret_code} and user input #{l_code}" do
          subject.start
          subject.current_game.instance_variable_set(:@secret_code, l_secret_code);
          expect{subject.show_validation_result(l_code)}.to output(l_out_put).to_stdout
        end
      end
    end
  end
end
