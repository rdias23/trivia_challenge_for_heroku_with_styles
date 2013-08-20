class AddFavoriteQuoteToUsers < ActiveRecord::Migration
  def change
    add_column :users, :favorite_quote, :text
  end
end
