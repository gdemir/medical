class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :first_name
      t.string :last_name
      t.string :password
      t.integer :status
      t.string :image_url

      t.timestamps
    end
  end
end
