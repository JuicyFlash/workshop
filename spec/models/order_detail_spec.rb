require 'rails_helper'

RSpec.describe OrderDetail, type: :model do
  it { should belong_to(:order).optional }
  it { should validate_presence_of(:first_name).with_message(/Поле имя не заполнено/) }
  it { should validate_presence_of(:last_name).with_message(/Поле фамилия не заполнено/) }
  it { should validate_presence_of(:city).with_message(/Поле город не заполнено/) }
  it { should validate_presence_of(:street).with_message(/Поле улица не заполнено/) }
  it { should validate_presence_of(:house).with_message(/Поле дом не заполнено/) }
  it { should validate_presence_of(:phone).with_message(/Поле телефон не заполнено/) }

end
