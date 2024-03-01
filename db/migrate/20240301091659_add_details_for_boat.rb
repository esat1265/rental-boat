class AddDetailsForBoat < ActiveRecord::Migration[7.1]
  def change
    add_column :boats, :details, :text
  end
end
