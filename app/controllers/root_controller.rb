class RootController < ApplicationController
	before_action :validation_for_create, only: :create

	before_action :check_due_date_is_valid, only: :create
	before_action :check_user_id_is_exists, only: :create
	
	before_action :check_todo_id_is_valid, only: :update

	def index
		@Todos = Todo.all
		# render json: {status: 200}
		render 'index'
	end

	def create
		@todo = Todo.new
		@todo.title = params[:title]
		@todo.due_date = params[:due_date]
		if params[:user_id]
			@todo.user_id = params[:user_id]
		else
		  @todo.user_id = current_user.id
		end

		begin 
			@todo.save
			render json: {message: "sucess"},status: 201
			# redirect_to :action => 'index'
		rescue StandardError => e
			render json: {error: e}, status: 400
		end
	end

	# def update
	#     @todo = Todo.find(params[:id])
	#     #@todo.save
	#     #redirect_to :action => 'index'
	#     render 'update'
	# end

	def update
		@todo = Todo.find(params[:id])
		@todo.completed = params[:completed]
		begin
			@todo.save
			render json: {message: "sucess"}, status: 200
		rescue Exception => e
			render json: {error: e}, status: 400
		end
		# redirect_to :action => 'index'
	end

	def delete
		@todo = Todo.find(params[:id])
		@todo.destroy
		redirect_to :action => 'index'
	end

	# validations
	def validation_for_create
		check_title_is_empty
		check_due_date_is_empty
		check_user_id_is_valid
	end

	def check_title_is_empty
		begin
			if params[:title] == ""
					raise "title cannot be empty"
			end
		rescue StandardError => e
			render json: { error: e},status: 400
		end
	end

	def check_due_date_is_empty
		puts
		begin
			if params[:due_date] == "" || params[:due_date] == nil
				raise "due_date cannot be empty or nil"
			end
		rescue StandardError => e
			render json: {error: e}, status: 400
		end
	end

	def check_due_date_is_valid
		current_time = Time.now.to_s
		begin
			if params[:due_date] < DateTime.parse(current_time).strftime("%Y-%m-%d")
				raise "Invalid due_date"
			end
		rescue StandardError => e
			render json: {error: e}, status: 400
		end
	end

	def check_user_id_is_valid
		if current_user != nil
			puts "current_user.id from root_controller"
		else
			begin
				if params[:user_id] == "" || params[:user_id] == nil
					raise "user_id cannot be empty or nil"
				elsif params[:user_id].to_i <= 0
					raise "Invalid user_id"
				end
			rescue StandardError => e
				render json: {error: e}, status: 400
			end
		end
	end

	def check_user_id_is_exists
		if current_user != nil
			begin
				user = User.find(current_user.id)
			rescue Exception => e
				render json: {error: e}, status: 400
			end
		else
			begin
				user = User.find(params[:user_id])
			rescue Exception => e
				render json: {error: e}, status: 400
			end
		end
	end

	def check_todo_id_is_valid
		begin
			if params[:id] == "" || params[:id] == nil
				raise "todo_id cannot be empty or nil"
			elsif params[:id].to_i <= 0
				raise "Invalid todo_id"
			end
		rescue StandardError => e
			render json: {error: e}, status: 400
		end
	end



end
