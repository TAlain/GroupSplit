class AddBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.integer :amount, null: false
      t.belongs_to :group, index: true, null: false
      t.belongs_to :user, index: true, null: false
      t.timestamp
    end
  end
end
