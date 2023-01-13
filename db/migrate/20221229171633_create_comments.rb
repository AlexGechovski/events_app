class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :text
      t.references :user 
      t.references :event

      t.timestamps
    end
  end
end
