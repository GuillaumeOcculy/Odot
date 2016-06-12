class TodoItem < ActiveRecord::Base

  # Associations
  belongs_to :todo_list

  # Validations
  validates :content, presence: true, length: { minimum: 2 }
end
