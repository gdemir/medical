class CreateDrugUses < ActiveRecord::Migration
  def change
    create_table :drug_uses do |t|
      t.integer :consult_id
      t.integer :drug_id
      t.integer :sequence
      t.text :content
      t.date :start_time
      t.date :end_time

      t.timestamps
    end
  end
end
