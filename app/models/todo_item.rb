class TodoItem < ActiveRecord::Base

  # Associations
  belongs_to :todo_list

  # Validations
  validates :content, presence: true, length: { minimum: 2 }

  # Scopes
  scope :complete, -> { where("completed_at is not null") }
  scope :incomplete, -> { where(completed_at: nil) }
  
  def completed?
    !completed_at.blank?
  end
end
