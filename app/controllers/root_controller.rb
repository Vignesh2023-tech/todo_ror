class RootController < ApplicationController

    def index
        @Todos = Todo.all
        render 'index'
    end

    def create
        @todo = Todo.new
        @todo.title = params[:title]
        @todo.due_date = params[:due_date]
        @todo.user_id = current_user.id
        @todo.save
        redirect_to :action => 'index'
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
        @todo.save
        redirect_to :action => 'index'
    end

    def delete
        @todo = Todo.find(params[:id])
        @todo.destroy
        redirect_to :action => 'index'
    end

end
