class AddHouseAllegianceToUser < ActiveRecord::Migration
  def change
	add_column :users, :house_allegiance, :string
  end
end
