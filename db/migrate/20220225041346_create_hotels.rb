class CreateHotels < ActiveRecord::Migration[6.0]
  def change
    create_table :hotels do |t|
      t.string :hotel_id, null: false
      t.string :destination_id, null: false
      # NOTES: In the real project, we can add more columns or tables to maintains hotel info.
      # However, for this situation. I choose the simple way maintains all data of hotels in columns details
      t.text :details

      t.timestamps

      t.index [:hotel_id, :destination_id], unique: true
    end
  end
end
