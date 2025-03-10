class TodosController < ApplicationController
  


  def index
    matching_todos = Todo.all

    @list_of_todos = matching_todos.order({ :created_at => :desc })

    render({ :template => "todos/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_todos = Todo.where({ :id => the_id })

    @the_todo = matching_todos.at(0)

    render({ :template => "todos/show.html.erb" })
  end

  def create
    @the_todo = Todo.new
    @the_todo.content = params.fetch("query_content")
    @the_todo.user_id = session.fetch(:user_id)
    @the_todo.save
    
    redirect_to("/")

  end

  def update
    @todo = Todo.find(params[:path_id])
    current_stat = params.fetch("query_status")
    @todo.status=current_stat
    @todo.save
    redirect_to("/")
  end

    #the_todo.content = params.fetch("query_content")
    #the_todo.status = params.fetch("query_status")
    #the_todo.user_id = params.fetch("query_user_id")

  def destroy
    the_id = params.fetch("path_id")
    the_todo = Todo.where({ :id => the_id }).at(0)

    the_todo.destroy

    redirect_to("/todos", { :notice => "Todo deleted successfully."} )
  end
end
