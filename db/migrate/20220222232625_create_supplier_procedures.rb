class CreateSupplierProcedures < ActiveRecord::Migration[6.0]
  def change
    create_table :supplier_procedures do |t|
      t.string  :type, null: false
      t.string  :source_id, null: false
      t.string  :supplier_ref, null: false
      t.text    :value, null: false
      t.integer :state, null: false, default: 0

      t.timestamps

      t.index [:type, :source_id, :supplier_ref], unique: true, name: "index_unique_supplier_procedures"
    end
  end
end
