class CreatePresenters < ActiveRecord::Migration[5.0]
  def change
    create_table :presenters do |t|
      t.references :communicator, foreign_key: true
      t.references :session, foreign_key: true
      t.integer :position

      t.timestamps
    end

    add_index :presenters, [:communicator_id, :session_id]
  end
end
