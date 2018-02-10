class CreateAppquestions < ActiveRecord::Migration[5.1]
  def change
    create_table :appquestions do |t|
      t.string :name, null: false
      t.string :text, null: false
      t.string :field_type, null: false
      t.string :field_options
      t.boolean :enabled, null: false, default: true
      t.integer :position, null: false, default: 0

      t.timestamps
    end
    add_index :appquestions, :name, unique: true
  end
end
