class AddGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :owner_id
    end

    create_table :groups_users, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :group, index: true
    end

  end
end
