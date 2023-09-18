class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.text :reason, null: false
      t.integer :user_id, null: false
      t.integer :reported_item_id, null: false
      t.string :reported_item_type, null: false
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
