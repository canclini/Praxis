class AddManagedCareToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :managed_care, :boolean, :default => false
    add_column :patients, :last_mc_check_at, :datetime
    add_column :patients, :be_uuid, :string
  end
end
