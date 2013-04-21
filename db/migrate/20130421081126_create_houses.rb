class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.text :address
      t.text :description

      t.timestamps
    end
  end
end
