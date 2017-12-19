class AddKindValidationToAssets < ActiveRecord::Migration[5.0]
  def change
    change_column_null :assets, :kind, false
  end
end
