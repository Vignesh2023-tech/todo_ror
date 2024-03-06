require 'rails_helper'

RSpec.describe RootController, type: :request do

  describe "Getting index page" do

    it "returns a success response" do
      get '/index'
      expect(response).to have_http_status(200)
    end
  end

  describe "Creating Todo" do
    describe "When using invalid inputs" do

      context 'When title is empty' do
        
        it "returns status 400" do
          post "/create", params: {title: "", due_date:"2024-03-06", user_id: 1}
          expect(response).to have_http_status(400)
        end

        it "returns error message" do
          post "/create", params: {title: "", due_date:"2024-03-06", user_id: 1}
          # expect(JSON.parse(response.body) ['error']).to_not be_empty
          expect(JSON.parse(response.body) ['error']).to eq "title cannot be empty"
        end

        it "doesn't return empty message" do
          post "/create", params: {title: "", due_date:"2024-03-06", user_id: 1}
          expect(JSON.parse(response.body) ['error']).to_not be_empty
        end
      end

      context 'When due_date is empty' do
        
        it "returns status 400" do
          post "/create", params: {title: "Rspec", due_date:"", user_id: 1}
          expect(response).to have_http_status(400)
        end

        it "returns error message" do
          post "/create", params: {title: "Rspec", due_date:"", user_id: 1}
          expect(JSON.parse(response.body) ['error']).to eq "due_date cannot be empty or nil"
        end

        it "doesn't returns empty message" do
          post "/create", params: {title: "Rspec", due_date:"", user_id: 1}
          expect(JSON.parse(response.body) ['error']).to_not be_empty
        end
      end

      context 'When due_date is invalid' do
        
        it "returns status 400" do
          post "/create", params: {title: "Rspec", due_date:"2024-01-01", user_id: 1}
          expect(response).to have_http_status(400)
        end

        it "returns error message" do
          post "/create", params: {title: "Rspec", due_date:"2024-01-01", user_id: 1}
          expect(JSON.parse(response.body) ['error']).to eq "Invalid due_date"
        end

        it "doesn't returns empty message" do
          post "/create", params: {title: "Rspec", due_date:"2024-01-01", user_id: 1}
          expect(JSON.parse(response.body) ['error']).to_not be_empty
        end
      end

      context 'When user_id is empty' do

        it 'returns status 400' do
          post '/create', params: {title: "Rspec", due_date:"2024-03-06", user_id:"" }
          expect(response).to have_http_status(400)
        end

        it 'returns error message' do
          post '/create', params: {title: "Rspec", due_date:"2024-03-06", user_id:"" }
          expect(JSON.parse(response.body) ['error']).to eq "user_id cannot be empty or nil"
        end

        it "doesn't returns empty message" do
          post '/create', params: {title: "Rspec", due_date:"2024-03-06", user_id:"" }
          expect(JSON.parse(response.body) ['error']).to_not be_empty
        end
      end

      context 'When user_id is less than or equal to zero' do

        it 'returns status 400' do
          post '/create', params: {title: "Rspec", due_date:"2024-03-06", user_id: 0 }
          expect(response).to have_http_status(400)
        end

        it 'returns error message' do
          post '/create', params: {title: "Rspec", due_date:"2024-03-06", user_id:0 }
          expect(JSON.parse(response.body) ['error']).to eq "Invalid user_id"
        end

        it "doesn't returns empty message" do
          post '/create', params: {title: "Rspec", due_date:"2024-03-06", user_id:0 }
          expect(JSON.parse(response.body) ['error']).to_not be_empty
        end

        it 'returns status 400' do
          post '/create', params: {title: "Rspec", due_date:"2024-03-06", user_id: -1 }
          expect(response).to have_http_status(400)
        end

        it 'returns error message' do
          post '/create', params: {title: "Rspec", due_date:"2024-03-06", user_id:-3 }
          expect(JSON.parse(response.body) ['error']).to eq "Invalid user_id"
        end

        it "doesn't returns empty message" do
          post '/create', params: {title: "Rspec", due_date:"2024-03-06", user_id:-312 }
          expect(JSON.parse(response.body) ['error']).to_not be_empty
        end
      end

      context 'When user_id is not exists' do

        it 'returns status 400' do
          post '/create', params: {title: "Rspec", due_date:"2024-03-06", user_id: 100 }
          expect(response).to have_http_status(400)
        end

        it 'returns error message' do
          post '/create', params: {title: "Rspec", due_date:"2024-03-06", user_id:100 }
          expect(JSON.parse(response.body) ['error']).to eq "Couldn't find User with 'id'=100"
        end

        it "doesn't returns empty message" do
          post '/create', params: {title: "Rspec", due_date:"2024-03-06", user_id:100 }
          expect(JSON.parse(response.body) ['error']).to_not be_empty
        end
      end

    end

    describe "when using valid inputs" do

      it "returns 201 response" do
        post '/create', params: {title: "Test case", due_date:"2024-05-01", user_id:1}
        expect(response).to have_http_status(201)
      end

    end
  end

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
end
