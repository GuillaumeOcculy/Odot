class TodoList < ActiveRecord::Base

  # Associations
  has_many :todo_items
  belongs_to :user
  
  # Validation
  validates :title, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 5 }

  def has_completed_items?
    todo_items.complete.size > 0
  end

  def has_incompleted_items?
    todo_items.incomplete.size > 0
  end

end
