class ItemsController < ApplicationController
  def create
    @todo = Todo.find(params[:todo_id])
    @items = @todo.items

    @item = items.new( item_params )
    @item.todo = @todo
    @new_item = Item.new

    authorize @item

    if @item.save
      flash[:notice] = "Comment was created successfully."
    else
      flash[:error] = "Error creating comment. It must be more than 5 characters. Please try again."
    end

    respond_with(@item) do |format|
      format.html { redirect_to [@todo] }
    end
  end
end
