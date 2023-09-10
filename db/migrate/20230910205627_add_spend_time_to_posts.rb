class AddSpendTimeToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :spend_time, :integer, null: false, default: 0
  end
end
