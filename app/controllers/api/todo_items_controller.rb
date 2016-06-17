class Api::TodoItemsController < Api::ApiController

  before_action :find_todo_list
  before_action :find_todo_item, only: [:show, :update, :destroy]

  def index
    items = @list.todo_items
    render json: items
  end

  def show
    render json: @item
  end

  def create
    item = @list.todo_items.new(item_params)
    if item.save
      render status: 200, json: {
        message: "Successfully created To-do Item.",
        todo_list: @list,
        todo_item: item
      }.to_json
    else
      render status: 422, json: {
        message: "To-do Item creation failed.",
        errors: item.errors
      }.to_json
    end
  end

  def update
    if @item.update(item_params)
      render status: 200, json: {
        message: "Successfully updated To-do Item.",
        todo_list: @list,
        todo_item: @item
      }.to_json
    else
      render staus: 422, json: {
        message: @item.errors
      }.to_json
    end
  end

  def destroy
    @item.destroy
    render status: 200, json: {
      message: "Successfully deleted", todo_list: @list, todo_item: @item
    }.to_json
  end

  private

  def item_params
    params.require(:todo_item).permit(:content)
  end

  def find_todo_list
    @list = current_user.todo_lists.find(params[:todo_list_id])
  end

  def find_todo_item
    @item = @list.todo_items.find(params[:id])
  end
end
