class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :country
      t.string :state
      t.string :city
      t.integer :pincode
      t.string :street
      t.string :flat_no

      t.timestamps
    end
  end
end
