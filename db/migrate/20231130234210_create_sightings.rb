class CreateSightings < ActiveRecord::Migration[7.0]
  def change
    create_table :sightings do |t|
      t.float :latitude
      t.float :longitude
      t.date :date
      t.integer :bird_id

      t.timestamps
    end
  end
end
