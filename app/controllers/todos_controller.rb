class TodosController < ApplicationController

  def index
    @todos = Todo.all
    authorize @todos
  end

  def show
      @user = current_user
      @todo = Todo.find(params[:id])
      @items = @todo.items
      authorize @todo
  end

  def edit
     @todo = Todo.find(params[:id])
    authorize @todo
  end

  def new
    @todo =Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.user_id = current_user.id
    if @todo.save
      redirect_to @todo, notice: "Todo was saved successfully."
    else
      flash[:error] = "Error creating todo. Please try again."
      render :new
    end
  end

  def update
    @todo = Todo.find(params[:id])
    authorize @todo
    if @todo.update_attributes(todo_params)
      redirect_to @todo
    else
      flash[:error] = "There was an error todo."
      render :edit
    end
  end

  def destroy
  @todo = Todo.find(params[:id])
  name = @todo.title

  authorize @todo
    if @todo.delete
       flash[:notice] = "\"#{name}\" was deleted successfully."
       redirect_to users_path
    else
      flash[:error] = "There was an error deleting the todo."
      render :show
    end
  end

  def todo_params
    params.require(:todo).permit(:title)
  end

end
