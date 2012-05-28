class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.integer :blood_group_id
      t.string :tc
      t.integer :file_no
      t.string :first_name
      t.string :last_name
      t.boolean :gender
      t.integer :phone
      t.string :email
      t.text :adress
      t.string :image_url
      t.date :birthday
      t.string :birthplace
      t.string :mother_name
      t.string :father_name

      t.timestamps
    end
  end
end
