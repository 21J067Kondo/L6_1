class CreateUser5s < ActiveRecord::Migration[7.0]
  def change
    create_table :user5s do |t|
      t.string :uid
      t.string :pass

      t.timestamps
    end
  end
end
