class CreatePlayerappanswers < ActiveRecord::Migration[5.1]
  def change
    create_table :playerappanswers do |t|
      t.string :name, null: false
      t.string :question, null: false
      t.string :answer, null: false
      t.string :position, null: false, default: 0
      t.references :playerapp, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
