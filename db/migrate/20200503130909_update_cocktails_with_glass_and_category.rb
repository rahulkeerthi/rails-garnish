class UpdateCocktailsWithGlassAndCategory < ActiveRecord::Migration[6.0]
  def change
    add_reference :cocktails, :glass, foreign_key: true
    add_reference :cocktails, :category, foreign_key: true
    add_reference :cocktails, :user, foreign_key: true
  end
end
