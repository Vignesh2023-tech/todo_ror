class RootController < ApplicationController

    def index
        @Todos = Todo.all
        render 'index'
    end

    def create
        @todo = Todo.new
        @todo.title = params[:title]
        @todo.description = params[:description]
        @todo.save
        redirect_to :action => 'index'
    end

    def update
        @todo = Todo.find(params[:id])
        #@todo.save
        #redirect_to :action => 'index'
        render 'update'
    end

    def updateform
        @todo = Todo.find(params[:id])
        @todo.title = params[:title]
        @todo.description = params[:description]
        @todo.save
        redirect_to :action => 'index'
    end

    def delete
        @todo = Todo.find(params[:id])
        @todo.destroy
        redirect_to :action => 'index'
    end

end
