class CreateQuestionCounters < ActiveRecord::Migration
  def change
    create_table :question_counters do |t|
      t.string :used_session_id
      t.text :question_text

      t.timestamps
    end
  end
end
