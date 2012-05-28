class CreateDrugs < ActiveRecord::Migration
  def change
    create_table :drugs do |t|
      t.string :name
      t.text :content
      t.date :expiry_date
      t.integer :price

      t.timestamps
    end
  end
end
