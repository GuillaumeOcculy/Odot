class TodoList < ActiveRecord::Base

  # Associations
  has_many :todo_items
  
  # Validation
  validates :title, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 5 }


end
