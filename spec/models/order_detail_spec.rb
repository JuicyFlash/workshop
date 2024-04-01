require 'rails_helper'

RSpec.describe OrderDetail, type: :model do
  it { should belong_to(:order) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:street) }
  it { should validate_presence_of(:house) }
  it { should validate_presence_of(:phone) }

end
