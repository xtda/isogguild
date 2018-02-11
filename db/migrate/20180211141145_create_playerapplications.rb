class CreatePlayerapplications < ActiveRecord::Migration[5.1]
  def change
    create_table :playerapplications do |t|
      t.string :player_battlenettag
      t.string :player_name
      t.string :player_realm
      t.string :player_class
      t.string :player_mainspec
      t.integer :player_mainspec_awt
      t.string :player_offspec
      t.integer :player_offspec_awt
      t.text :player_offspec_confidence
      t.text :player_alts
      t.text :player_previousguilds
      t.string :link_wowprogress
      t.string :link_warcraftlogs
      t.text :question_theorycraft
      t.text :question_whyyou
      t.text :question_whyremorse
      t.text :question_anythingelse
      t.string :viewkey

      t.timestamps
    end
  end
end
