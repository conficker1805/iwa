class AddNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string

    create_table :tests do |t|
      t.string :name
      t.text :desctiption

      t.timestamps null: false
    end

    create_table :test_questions do |t|
      t.string :label
      t.references :test, null: false, index: true

      t.timestamps null: false
    end

    create_table :test_options do |t|
      t.references :question, null: false, index: true
      t.string :label
      t.boolean :correctness, default: false, null: false

      t.timestamps null: false
    end
  end
end
