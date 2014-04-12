class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :name
      t.string  :location
      t.string  :bio
      t.string  :user_role

      t.timestamps
    end
  end
end
