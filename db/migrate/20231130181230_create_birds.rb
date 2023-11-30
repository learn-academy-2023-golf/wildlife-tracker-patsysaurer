class CreateBirds < ActiveRecord::Migration[7.0]
  def change
    create_table :birds do |t|
      t.string :common_name
      t.string :scientific_name

      t.timestamps
    end
  end
end
