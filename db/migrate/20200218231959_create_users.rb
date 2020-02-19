class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, unique: true, null: true
      t.string :password_digest, null: true

      t.timestamps
    end
  end
end
