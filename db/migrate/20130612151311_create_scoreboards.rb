class CreateScoreboards < ActiveRecord::Migration
  def change
    create_table :scoreboards do |t|
      t.string :score_type
      t.integer :score
      t.references :user, index: true

      t.timestamps
    end
  end
end
