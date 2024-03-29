class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.text :location
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
