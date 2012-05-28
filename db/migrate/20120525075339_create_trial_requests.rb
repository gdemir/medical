class CreateTrialRequests < ActiveRecord::Migration
  def change
    create_table :trial_requests do |t|
      t.integer :consult_id
      t.integer :trial_type_id
      t.integer :request_admin_id
      t.integer :reply_admin_id
      t.integer :sequence
      t.boolean :state

      t.timestamps
    end
  end
end
