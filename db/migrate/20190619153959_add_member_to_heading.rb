class AddMemberToHeading < ActiveRecord::Migration[5.0]
  def change
    add_reference :headings, :member, foreign_key: true
  end
end
