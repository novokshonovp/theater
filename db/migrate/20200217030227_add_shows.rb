class AddShows < ActiveRecord::Migration[6.0]
  def change
    create_table :shows do |t|
      t.string :name, null: false
      t.daterange :schedule, null: false
      t.timestamps
    end
  end
end
