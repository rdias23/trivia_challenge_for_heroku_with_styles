class CreateSessionCounters < ActiveRecord::Migration
  def change
    create_table :session_counters do |t|
      t.string :used_session_id

      t.timestamps
    end
  end
end
