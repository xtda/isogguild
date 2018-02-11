class CreateSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :settings do |t|
      t.string :name, null: false
      t.jsonb :settings, null: false, default: '{}'

      t.timestamps
    end
    add_index :settings, :name, unique: true
  end
end
