require 'rails_helper'

class Calculator
  def add(a, b)
    a + b
  end
end

class MathService
  def initialize(calculator)
    @calculator = calculator
  end

  def add_numbers(x, y)
    @calculator.add(x, y)
  end
end

RSpec.describe MathService do

  describe MathService do
    let(:calculator) { instance_double(Calculator) } # Using instance_double for mock
  
    subject { described_class.new(calculator) }
  
    describe '#add_numbers' do
      it 'calls the add method on calculator with correct arguments' do
        # Stubbing the add method of the calculator instance to return a predefined value
        allow(calculator).to receive(:add).with(2, 3).and_return(5)
  
        expect(subject.add_numbers(2, 3)).to eq(5)
      end
  
      it 'verifies that the add method is called with correct arguments' do
        # Mocking the add method of the calculator instance to expect it to be called with specific arguments
        expect(calculator).to receive(:add).with(2, 3)
  
        subject.add_numbers(2, 3)
      end
    end
  end
end
