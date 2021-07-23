class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.references :user, foreign_key: true
      t.references :review, foreign_key: true
      t.boolean :is_vote

      t.timestamps
    end
  end
end
