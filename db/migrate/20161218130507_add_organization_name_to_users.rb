class AddOrganizationNameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :org_name, :string
  end
end
