class CreateMatchers < ActiveRecord::Migration[5.1]
  def change
    create_table :matchers do |t|
      t.string :uri_pattern,             null: false
      t.string :url_replacement_pattern, null: false
      t.string :name,                    null: false
      t.integer :priority,               null: false

      t.timestamps null: false
    end
  end
end
