class AddCoverToPost < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :cover, :string
  end
end
