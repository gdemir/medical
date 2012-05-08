class CreateTrials < ActiveRecord::Migration
  def change
    create_table :trials do |t|
      t.integer :trial_type_id
      t.string :name
      t.integer :min_range
      t.integer :max_range
      t.string :units

      t.timestamps
    end
  end
end
