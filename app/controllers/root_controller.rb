class RootController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    render 'index'
  end

  def getdata
    @Todos = Todo.all.to_json
    render json: @Todos
  end

  def create
    title = params[:title]
    due_date = params[:due_date]
    user_id = params[:user_id]

    @Todo = Todo.new(title: title, due_date:due_date, user_id: user_id)
    if @Todo.save!
      puts "Todo saved successfully#{@Todo}"
    else
      puts "Todo not saved successfully"
    end
  end

  def update
    @todo = Todo.find(params[:id])
    puts params[:completed]
    @todo.completed = params[:completed]
    @todo.save
    redirect_to :action => 'index', notice:"Todo updated sucessfully!"
  end

  def delete
    @todo = Todo.find(params[:id])
    @todo.destroy
    redirect_to :action => 'index', notice: "Todo deleted sucessfully!"
  end

end
