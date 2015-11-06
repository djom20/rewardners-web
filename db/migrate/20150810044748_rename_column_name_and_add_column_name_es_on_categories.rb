class RenameColumnNameAndAddColumnNameEsOnCategories < ActiveRecord::Migration
  def change
    add_column :categories, :name_es, :string
    rename_column :categories, :name, :name_en
  end
end
