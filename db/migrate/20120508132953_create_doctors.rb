class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.integer :department_id
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
