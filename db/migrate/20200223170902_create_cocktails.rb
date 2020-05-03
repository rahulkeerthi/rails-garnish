class CreateCocktails < ActiveRecord::Migration[6.0]
  def change
    create_table :cocktails do |t|
      t.string :name
      t.string :description
      t.references :glass, foreign_key:true
      t.references :category, foreign_key:true
      t.timestamps
    end
  end
end
