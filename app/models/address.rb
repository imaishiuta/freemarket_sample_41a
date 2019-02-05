class Address < ApplicationRecord
  belongs_to :user
  with_options presence: true do
    validates :first_name
    validates :last_name
    validates :first_name_kana
    validates :last_name_kana
    validates :zip_code
    validates :prefecture
    validates :city
    validates :address1
  end
end
