require 'rails_helper'

RSpec.describe Todo, type: :model do

  describe "Creating Todo" do
    describe "When using invalid inputs" do

      context "validates the presence of inputs" do

        it "returns title must be given" do
          todo = Todo.new(title: "", due_date: "2024-10-10", user_id: 1)
          expect(todo).not_to be_valid
          expect(todo.errors[:title]).to include("must be given")
        end

        it "return due_date must be given" do
          todo = Todo.new(title: "Rspec", due_date: "", user_id: 1)
          expect(todo).not_to be_valid
          expect(todo.errors[:due_date]).to include("must be given")
        end

        it "return user_id must be given" do
          todo = Todo.new(title: "Rspec", due_date: "2024-10-10", user_id: "")
          expect(todo).not_to be_valid
          expect(todo.errors[:user_id]).to include("must be given")
        end

      end

      context "When due_date is invalid" do
        
        it "returns due_date is in the present or future" do
          todo = Todo.new(title: "Rspec", due_date: "2024-01-01", user_id: 1)
          expect(todo).not_to be_valid
          expect(todo.errors[:due_date]).to include("Invalid due_date")
        end
      end

      context "When user_id is invalid" do
        
        it "returns user_id must be given" do
          todo = Todo.new(title: "Rspec", due_date: "2024-01-01", user_id: nil)
          expect(todo).not_to be_valid
          expect(todo.errors[:user_id]).to include("must be given")
        end

        it "returns user_id is invalid" do
          todo = Todo.new(title: "Rspec", due_date: "2024-10-10", user_id: -3)
          expect(todo).not_to be_valid
          expect(todo.errors[:user_id]).to include("Invalid user_id")
        end

        it "returns user_id is invalid" do
          todo = Todo.new(title: "Rspec", due_date: "2024-10-10", user_id: 0)
          expect(todo).not_to be_valid
          expect(todo.errors[:user_id]).to include("Invalid user_id")
        end

        it "returns user_id is invalid" do
          todo = Todo.new(title: "Rspec", due_date: "2024-10-10", user_id: 100)
          expect(todo).not_to be_valid
          expect(todo.errors[:user_id]).to include("User not found")
        end
      end

    end


    describe "when using valid inputs" do

      it "returns todo.rn not to be nil" do
        todo = Todo.new(title: "Rspec", due_date: "2024-10-10", user_id: 1)
        todo.save
        expect(todo.rn).not_to be_nil
      end

      it "returns todo.rn not to be nil using FactoryGirl" do
        todo = FactoryGirl.create(:todo)
        expect(todo.rn).not_to be_nil
      end
    end

    # skip_callback
    describe "#generate random number" do
    
      it "skips the before_save callback" do
        todo = Todo.new(title: "Rspec", due_date: "2024-10-10", user_id: 1)
        
        allow_any_instance_of(Todo).to receive(:generate_random_number)
        todo.save
        expect(todo.rn).to be_nil
      end

    end

    #skip_validation
    describe "#generate todo" do

      it "skip validation using FactoryGirl" do
        todo = create(:todo, :skip_user_id_validation)
        expect(todo.rn).not_to be_nil
      end

      it "skip validation using methods" do
        todo = Todo.new(title: "Rspec", due_date: "2024-01-01", user_id: 1)
        todo.skip_user_id_validation
        expect(todo).to be_valid
      end
    end
  end

end
