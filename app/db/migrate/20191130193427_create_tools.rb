class CreateTools < ActiveRecord::Migration[5.1]
  def change
    create_table :tools do |t|
      t.string :title
      t.string :link
      t.text :description

      t.timestamps
    end
  end
end
