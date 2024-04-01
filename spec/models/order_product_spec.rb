require 'rails_helper'

RSpec.describe OrderProduct, type: :model do
  it { should belong_to(:order) }
  it { should belong_to(:product) }

  it { should validate_numericality_of(:count).is_greater_than_or_equal_to(1) }
end
