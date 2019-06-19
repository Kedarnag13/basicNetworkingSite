class AddSignUpFieldsToMember < ActiveRecord::Migration[5.0]
  def change
    add_column :members, :email, :string
    add_column :members, :password, :string
  end
end
