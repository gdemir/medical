class CreateTrialResults < ActiveRecord::Migration
  def change
    create_table :trial_results do |t|
      t.integer :trial_request_id
      t.integer :trial_id
      t.integer :min_range
      t.integer :max_range
      t.integer :result

      t.timestamps
    end
  end
end
