class ItemsController < ApplicationController
   respond_to :html#, :js
  
  def create
    @todo = Todo.find(params[:todo_id])
    @items = @todo.items

    @item = @items.new( item_params )
    @item.todo = @todo
    @new_item = Item.new

    if @item.save
      flash[:notice] = "Task was created successfully."
      redirect_to [@todo]
    else
      flash[:error] = "Error creating Task. It must be more than 2 characters. Please try again."
      redirect_to [@todo]
    end
  end

  def destroy
    @todo = Todo.find(params[:todo_id])
    @item = @todo.items.find(params[:id])

    if @item.destroy
      flash[:notice] = "Task was deleted successfully."
    else
      flash[:error] = "Error deleting task."
    end

    respond_with(@item) do |format|
      format.html { redirect_to [@todo] }
    end
  end

  private
  def item_params
    params.require(:item).permit(:description)
  end

end
