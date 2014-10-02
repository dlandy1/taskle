class TodosController < ApplicationController

  def index
    @todos = Todo.all
    authorize @todos
  end

  def show
    @topic = Todo.find(params[:todo_id])
    @items = @todo.items
  end

  def edit
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      redirect_to @todo, notice: "Topic was saved successfully."
    else
      flash[:error] = "Error creating topic. Please try again."
      render :new
    end
  end

  def update
    
  end

  def destroy
    
  end

  def todo_params
    params.require(:todo).permit(:title)
  end

end
