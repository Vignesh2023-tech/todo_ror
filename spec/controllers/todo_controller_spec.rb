require 'rails_helper'

RSpec.describe RootController, type: :request do

  describe "Getting index page" do

    it "returns a success response" do
      get '/index'
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do

      it "returns 200 ok response" do
        post "/create", params: {title: "Rspec", due_date:"2024-10-10", user_id: 1}
        expect(response).to have_http_status(201)
      end

      it "returns random number" do
        post "/create", params: {title: "Rspec", due_date:"2024-10-10", user_id: 1}
        byebug
        expect(JSON.parse(response.body) ['errors']).to include "Title must be given"
      end
    end

    describe "with invalid parameters" do

      context "when title is empty" do

        it "returns status 400" do
          post "/create", params: {title: "", due_date:"2024-10-10", user_id: 1}
          expect(response).to have_http_status(400)
        end

        it "returns title must be given" do
          post "/create", params: {title: "", due_date:"2024-10-10", user_id: 1}
          expect(JSON.parse(response.body) ['errors']).to include "Title must be given"
        end

        it "doesn't return empty message" do
          post "/create", params: {title: "", due_date:"2024-10-10", user_id: 1}
          expect(JSON.parse(response.body) ['errors']).to_not be_empty
        end
      end

      context "when due_date is empty" do

        it "returns status 400" do
          post "/create", params: {title: "Rspec", due_date:"", user_id: 1}
          expect(response).to have_http_status(400)
        end

        it "returns due_date must be given" do
          post "/create", params: {title: "Rspec", due_date:"", user_id: 1}
          expect(JSON.parse(response.body) ['errors']).to include "Due date must be given"
        end

        it "doesn't return empty message" do
          post "/create", params: {title: "Rspec", due_date:"", user_id: 1}
          expect(JSON.parse(response.body) ['errors']).to_not be_empty
        end
      end

      context 'When due_date is invalid' do
        
        it "returns status 400" do
          post "/create", params: {title: "Rspec", due_date:"2024-01-01", user_id: 1}
          expect(response).to have_http_status(400)
        end

        it "returns error message" do
          post "/create", params: {title: "Rspec", due_date:"2024-01-01", user_id: 1}
          expect(JSON.parse(response.body) ['errors']).to include "Invalid due_date"
        end

        it "doesn't returns empty message" do
          post "/create", params: {title: "Rspec", due_date:"2024-01-01", user_id: 1}
          expect(JSON.parse(response.body) ['errors']).to_not be_empty
        end
      end

      context "when user_id is empty" do

        it "returns status 400" do
          post "/create", params: {title: "Rspec", due_date:"2024-10-10", user_id: ""}
          expect(response).to have_http_status(400)
        end

        it "returns due_date must be given" do
          post "/create", params: {title: "Rspec", due_date:"2024-10-10", user_id: ""}
          expect(JSON.parse(response.body) ['errors']).to include "User must be given"
        end

        it "doesn't return empty message" do
          post "/create", params: {title: "Rspec", due_date:"2024-10-10", user_id: ""}
          expect(JSON.parse(response.body) ['errors']).to_not be_empty
        end
      end

      context 'When user_id is not exists' do

        it 'returns status 400' do
          post '/create', params: {title: "Rspec", due_date:"2024-10-10", user_id: 100 }
          expect(response).to have_http_status(400)
        end

        it 'returns error message' do
          post '/create', params: {title: "Rspec", due_date:"2024-10-10", user_id:100 }
          expect(JSON.parse(response.body) ['errors']).to include "User not found"
        end

        it "doesn't returns empty message" do
          post '/create', params: {title: "Rspec", due_date:"2024-10-10", user_id:100 }
          expect(JSON.parse(response.body) ['errors']).to_not be_empty
        end
      end

      context 'When user_id is less than or equal to zero' do

        it 'returns status 400' do
          post '/create', params: {title: "Rspec", due_date:"2024-03-06", user_id: 0 }
          expect(response).to have_http_status(400)
        end

        it 'returns error message' do
          post '/create', params: {title: "Rspec", due_date:"2024-10-10", user_id:0 }
          expect(JSON.parse(response.body) ['errors']).to include "Invalid user_id"
        end

        it "doesn't returns empty message" do
          post '/create', params: {title: "Rspec", due_date:"2024-10-10", user_id:0 }
          expect(JSON.parse(response.body) ['errors']).to_not be_empty
        end

        it 'returns status 400' do
          post '/create', params: {title: "Rspec", due_date:"2024-10-10", user_id: -1 }
          expect(response).to have_http_status(400)
        end

        it 'returns error message' do
          post '/create', params: {title: "Rspec", due_date:"2024-10-10", user_id:-3 }
          expect(JSON.parse(response.body) ['errors']).to include "Invalid user_id"
        end

        it "doesn't returns empty message" do
          post '/create', params: {title: "Rspec", due_date:"2024-10-10", user_id:-312 }
          expect(JSON.parse(response.body) ['errors']).to_not be_empty
        end
      end

    end
  end

=begin

  describe "when updating Todo" do
    describe "When using invalid inputs" do
      context "When todo_id is less than or equal to zero" do

        it "returns status 400" do
          put '/todos/0', params: {completed: true}
          expect(response).to have_http_status(400)
        end

        it 'returns error message' do
          put '/todos/0', params: {completed: true}
          expect(JSON.parse(response.body) ['error']).to eq "Invalid todo_id"
        end

        it "doesn't returns empty message" do
          put '/todos/0', params: {completed: true}
          expect(JSON.parse(response.body) ['error']).to_not be_empty
        end

        it "returns status 400" do
          put '/todos/-1', params: {completed: true}
          expect(response).to have_http_status(400)
        end

        it 'returns error message' do
          put '/todos/-4', params: {completed: true}
          expect(JSON.parse(response.body) ['error']).to eq "Invalid todo_id"
        end

        it "doesn't returns empty message" do
          put '/todos/-543', params: {completed: true}
          expect(JSON.parse(response.body) ['error']).to_not be_empty
        end

      end

      # context "When todo_id is invalid" do

      #   it "return status 400" do
      #     puts '/todos/100', params: {completed: true}
      #     expect(response).to have_http_status(400)
      #   end
      # end
    end
  end
=end
end
