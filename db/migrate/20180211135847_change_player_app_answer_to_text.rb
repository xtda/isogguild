class ChangePlayerAppAnswerToText < ActiveRecord::Migration[5.1]
  def change
    change_column :playerappanswers, :answer, :text
  end
end
