require 'rails_helper'

class Calculator
  def add(a, b)
    a + b
  end
end

RSpec.describe "CalculatorControllers", type: :request do

  # stubbing
  describe "adding two numbers" do

    cal1 = Calculator.new
    cal2 = Calculator.new

    it "returns result" do
      allow(cal1).to receive(:add).with(2,3).and_return(9)
      expect(cal1.add(2,3)).to eq(9)
    end
  end


  describe "adding two numberss" do

    it "returns result for all instances" do
      allow_any_instance_of(Calculator).to receive(:add).and_return(9)

      cal1 = Calculator.new
      cal2 = Calculator.new

      expect(cal1.add(2,3)).to eq(9)
      expect(cal2.add(3,4)).to eq(9)
    end
  end
end
