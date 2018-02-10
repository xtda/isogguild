class CreatePlayerapps < ActiveRecord::Migration[5.1]
  def change
    create_table :playerapps do |t|
      t.string :player_name, null: false
      t.string :player_realm, null: false
      t.string :player_bnettag
      t.string :player_class, null: false
      t.string :player_spec, null: false
      t.string :player_links
      t.string :viewkey

      t.timestamps
    end
  end
end
