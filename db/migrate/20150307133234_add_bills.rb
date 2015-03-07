class AddBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.integer :amount
      t.belongs_to :group, index: true
      t.belongs_to :user, index: true
      t.timestamp
    end
  end
end
