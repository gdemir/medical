class CreateConsults < ActiveRecord::Migration
  def change
    create_table :consults do |t|
      t.integer :patient_id
      t.integer :doctor_id
      t.datetime :date
      t.boolean :payment

      t.timestamps
    end
  end
end
