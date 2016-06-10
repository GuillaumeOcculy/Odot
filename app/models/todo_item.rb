class TodoItem < ActiveRecord::Base

  # Associations
  belongs_to :todo_list
end
