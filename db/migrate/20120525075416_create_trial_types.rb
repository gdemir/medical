class CreateTrialTypes < ActiveRecord::Migration
  def change
    create_table :trial_types do |t|
      t.string :name
      t.integer :price

      t.timestamps
    end
  end
end
