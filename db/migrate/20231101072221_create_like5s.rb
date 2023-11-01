class CreateLike5s < ActiveRecord::Migration[7.0]
  def change
    create_table :like5s do |t|
      t.integer :user5_id
      t.integer :tweet5_id

      t.timestamps
    end
  end
end
