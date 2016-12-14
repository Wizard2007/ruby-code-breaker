require 'spec_helper'

module Codebreaker
  RSpec.describe ConsoleService, 'Test ConsoleService' do
    subject { ConsoleService.new }
    context '# Test user input ' do
      it 'it should get user input' do 
        subject.stub(:gets).and_return('test input')
        subject.process_user_input
        excpect(subject. )
      end
      it 'it should be not empty '
      it 'it should be valid console command'
      it 'it should be validate by Game '
    end
  end
end
