class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :title
      t.string :text
      t.string :author

      t.timestamps
    end
  end
end
