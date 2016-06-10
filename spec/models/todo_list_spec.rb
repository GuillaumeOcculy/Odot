require 'rails_helper'

RSpec.describe TodoList, type: :model do

  it { is_expected.to have_many(:todo_items) }

end
