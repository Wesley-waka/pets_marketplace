class AddProfileImageToProfile < ActiveRecord::Migration[7.0]
  def up
    add_column :profiles, :profile_image, :string
  end

  def down
    remove_column :profiles, :profile_image, :string
  end
end
