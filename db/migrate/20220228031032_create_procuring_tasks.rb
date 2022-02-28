class CreateProcuringTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :procuring_tasks do |t|
      t.string  :source_ref, null: false
      t.string  :source_type, null: false
      t.integer :state, null: false

      t.timestamps

      t.index [:source_type, :source_ref]
    end
  end
end
