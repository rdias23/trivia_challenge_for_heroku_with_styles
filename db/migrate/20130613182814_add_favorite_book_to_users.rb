class AddFavoriteBookToUsers < ActiveRecord::Migration
  def change
    add_column :users, :favorite_book, :string
  end
end
