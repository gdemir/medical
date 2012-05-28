class CreateDrugStorages < ActiveRecord::Migration
  def change
    create_table :drug_storages do |t|
      t.integer :drug_id
      t.integer :sequence

      t.timestamps
    end
  end
end
