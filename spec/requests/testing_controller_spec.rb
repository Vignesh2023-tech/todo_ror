require 'rails_helper'

class CoolClass
  def self.foo
    'bar'
  end

  def greeting
    puts "coming"
    byebug
    "hello"
  end
end

RSpec.describe "TestingControllers", type: :request do
  let(:mocked_cool_class) { instance_double(CoolClass) }

  # it 'returns cool! because we kindly asked it to' do
  #   allow(mocked_cool_class).to receive(:foo).and_return('cool!')
  #   expect(mocked_cool_class.foo).to eq('cool!')
  # end

  it "returns hello da" do
    allow(mocked_cool_class).to receive(:greeting).and_return("hello da")
    expect(mocked_cool_class.greeting).to eq("hello da")
  end
end


# RSpec.describe "TestingControllers", type: :request do
#   let(:mocked_cool_instance) { instance_double(CoolClass) }

#   it 'returns cool! because we kindly asked it to' do
#     allow(CoolClass).to receive(:foo).and_return('cool!')
#     expect(CoolClass.foo).to eq('cool!')
#   end

#   it "returns hello da" do
#     allow(mocked_cool_instance).to receive(:greeting).and_return("hello da")
#     expect(mocked_cool_instance.greeting).to eq("hello da")
#   end
# end
