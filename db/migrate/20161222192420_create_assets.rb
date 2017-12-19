class CreateAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :assets do |t|
      t.references :session, foreign_key: true
      t.string :name
      t.string :label
      t.text :value
      t.integer :kind

      t.timestamps
    end
  end
end
