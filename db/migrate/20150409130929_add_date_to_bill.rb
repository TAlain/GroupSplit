class AddDateToBill < ActiveRecord::Migration
  def change
    add_column :bills, :date, :date
    execute "UPDATE bills SET date = '20150101' WHERE date IS NULL"
  end
end

