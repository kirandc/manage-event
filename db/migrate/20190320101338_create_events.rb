class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string      :title
      t.datetime    :start_time
      t.datetime    :end_time
      t.string      :description
      t.boolean     :is_all_day,     default: false
      t.boolean     :is_completed,   default: false
      t.timestamps
    end
  end
end
