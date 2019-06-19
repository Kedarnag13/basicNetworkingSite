class CreateHeadings < ActiveRecord::Migration[5.0]
  def change
    create_table :headings do |t|
      t.string :tag_name
      t.string :heading

      t.timestamps
    end
  end
end
