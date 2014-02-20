class AddWikiToPages < ActiveRecord::Migration
  def change
    add_column :pages, :wiki_id, :integer
    add_index :pages, :wiki_id
  end
end
