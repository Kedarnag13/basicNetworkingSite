class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
      t.string :name
      t.string :original_url
      t.string :shortened_url

      t.timestamps
    end
  end
end
