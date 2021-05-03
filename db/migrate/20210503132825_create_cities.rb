class CreateCities < ActiveRecord::Migration[6.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :country
      # https://stackoverflow.com/questions/1196174/correct-datatype-for-latitude-and-longitude-in-activerecord/1203327
      t.decimal :latitude, precision: 10, scale: 6
      t.decimal :longitude, precision: 10, scale: 6

      t.timestamps
    end
    add_index :cities, [:name, :country], unique: true
  end
end
