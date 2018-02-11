class ChangePlayerAppPlayerLinksToText < ActiveRecord::Migration[5.1]
  def change
    change_column :playerapps, :player_links, :text
  end
end
