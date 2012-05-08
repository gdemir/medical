class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :consult_id
      t.integer :product_id
      t.boolean :product_type
      t.integer :price

      t.timestamps
    end
  end
end
