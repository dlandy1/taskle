class ItemsController < ApplicationController
  
  
  def create
    @todo = Todo.find(params[:todo_id])
    @items = @todo.items

    @item = @items.new( item_params )
    @item.todo = @todo
    @new_item = Item.new

    if @item.save
      flash[:notice] = "Comment was created successfully."
     redirect_to [@todo]
    else
      flash[:error] = "Error creating comment. It must be more than 5 characters. Please try again."
      render "todos/show"
    end
  end

  private
  def item_params
    params.require(:item).permit(:description)
  end

end
