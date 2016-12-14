require 'spec_helper'

module Codebreaker
  RSpec.describe ConsoleService, 'Test ConsoleService' do
    subject { ConsoleService.new }
    context '# Test main console procedures ' do
      it 'exit game STDOUT and set flag @is_session_over ' do
        subject.instance_variable_set(:@is_session_over, false)
        expect{subject.exit}.to output("your exit game\n").to_stdout
        expect(subject.instance_variable_get(:@is_session_over)).to eq(true)
      end
      it 'puts unknown command' do         
        expect{subject.unknown_command('test')}.to output("unknown command 'test'\n").to_stdout        
      end
      [:exit].each do |name|
        it "should process_user_input #{name.to_s}" do           
          expect(subject).to receive(:send).with(name)
          subject.process_user_input(name)
        end
      end
    end
    context '# Test user input ' do
      it 'it should get user input' do 
        #subject.stub(:gets).and_return('test input')
        #subject.process_user_input        
      end
      it 'it should be not empty '
      it 'it should be valid console command'
      it 'it should be validate by Game '
    end
  end
end
