class AddAccessLevelTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :access_level, :integer, default: 0
    add_column :users, :token, :string
  end
end
