class Api::TodoListsController < Api::ApiController

  before_action :find_todo_list, only: [:show, :update, :destroy]

  def index
    render json: TodoList.all
  end

  def show
    render json: @list.as_json(include: :todo_items)
  end

  def create
    list = TodoList.new(list_params)
    if list.save
      render status: 200, json: { message: 'Successfully created To-do List.', todo_list: list }.to_json
    else
      render status: 422, json: { message: list.errors }.to_json
    end
  end

  def update
    if @list.update(list_params)
      render status: 200, json: { message: "Successfully updated", todo_list: @list }.to_json
    else
      render status: 422, json: { message: "The To-do list could not be updated.", todo_list: @list }.to_json
    end
  end

  def destroy
    if @list.destroy
      render status: 200, json: { message: "Successfully deleted To-do List." }.to_json
    end
  end

  private

  def find_todo_list
    @list = current_user.todo_lists.find(params[:id])
  end

  def list_params
    params.require(:todo_list).permit(:title, :description)
  end
end
