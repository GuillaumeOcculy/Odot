class TodoItemsController < ApplicationController
  def index
    @todo_list = TodoList.find(params[:todo_list_id])
    @todo_items = @todo_list.todo_items
  end
end
