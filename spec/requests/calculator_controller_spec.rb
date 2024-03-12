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
      allow(cal1).to receive(:add).and_return(2)
      expect(cal1.add(3,3)).to eq(2)

      allow(cal2).to receive(:add).with(4,4)
      cal2.add(4,4)

      allow(cal1).to receive(:add).with(2,3).and_return(9)
      expect(cal1.add(2,3)).to eq(9)
    end

    # mock
    it "asdfasf" do
      expect(cal2).to receive(:add).with(4,5)
      cal2.add(4,5)

      expect(cal1).to receive(:add).and_return(10)
      expect(cal1.add(3,3)).to eq(10)

      expect(cal1).to receive(:add).with(6,6).and_return(12)
      expect(cal1.add(6,6)).to eq(12)
    end
  end


  describe "adding two numberss" do

    it "returns result for allow any instance of" do

      cal1 = Calculator.new
      cal2 = Calculator.new

      allow_any_instance_of(Calculator).to receive(:add).and_return(9)
      expect(cal1.add(2,3)).to eq(9)
      expect(cal2.add(3,4)).to eq(9)

      allow_any_instance_of(Calculator).to receive(:add).with(3,3)
      cal1.add(3,3)
      cal2.add(3,3)

      allow_any_instance_of(Calculator).to receive(:add).with(1,1).and_return(6)
      expect(cal1.add(1,1)).to eq(6)
      expect(cal2.add(1,1)).to eq(6)

      # USING PROC
      fixed_proc = Proc.new { |x| x*2 }
      fixed_ans = fixed_proc.call(5)
      allow_any_instance_of(Calculator).to receive(:add).and_return(fixed_ans)
      expect(cal1.add(2,3)).to eq(10)
      expect(cal2.add(3,4)).to eq(10)

      fixed_ans2 = fixed_proc.call(10)
      allow_any_instance_of(Calculator).to receive(:add).with(1,1).and_return(fixed_ans2)
      expect(cal1.add(1,1)).to eq(20)
      expect(cal2.add(1,1)).to eq(20)

    end

    it "returns result expect any instance of" do
      cal1 = Calculator.new
      cal2 = Calculator.new

      # expect_any_instance_of(Calculator).to receive(:add).with(2,3)
      # cal1.add(2,3)

      # expect_any_instance_of(Calculator).to receive(:add).and_return(1)
      # expect(cal2.add(1,1)).to eq(1)

      expect_any_instance_of(Calculator).to receive(:add).with(3,3).and_return(1)
      expect(cal2.add(3,3)).to eq(1)
      # expect(cal1.add(3,3)).to eq(1) # only works for one instance

    end

  end

end
