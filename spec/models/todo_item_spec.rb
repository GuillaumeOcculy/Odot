require 'rails_helper'

RSpec.describe TodoItem, type: :model do

  it { is_expected.to belong_to(:todo_list) }

end
