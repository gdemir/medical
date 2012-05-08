class CreateTrialRequests < ActiveRecord::Migration
  def change
    create_table :trial_requests do |t|
      t.integer :consult_id
      t.integer :trial_type_id
      t.boolean :state

      t.timestamps
    end
  end
end
