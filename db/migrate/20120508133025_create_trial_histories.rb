class CreateTrialHistories < ActiveRecord::Migration
  def change
    create_table :trial_histories do |t|
      t.integer :trial_request_id
      t.integer :request_admin_id
      t.integer :reply_admin_id

      t.timestamps
    end
  end
end
