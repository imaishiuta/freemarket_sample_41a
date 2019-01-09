class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.references   :user,           foreign_key: true
      t.string       :first_name,        null: false
      t.string       :last_name,         null: false
      t.string       :first_name_kana,   null: false
      t.string       :last_name_kana,    null: false
      t.integer      :zip_code,          null: false
      t.string       :prefecture,        null: false
      t.string       :city,              null: false
      t.string       :address1,          null: false
      t.string       :address2,          null: true
      t.integer      :telephone,         null: true
      t.timestamps
    end
  end
end
