class AddImageLinkToCocktails < ActiveRecord::Migration[6.0]
  def change
    add_column :cocktails, :image_url, :string
  end
end
