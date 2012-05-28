class CreateTrialStorages < ActiveRecord::Migration
  def change
    create_table :trial_storages do |t|
      t.integer :trial_type_id
      t.integer :sequence

      t.timestamps
    end
  end
end
