class CreateLights < ActiveRecord::Migration[6.1]
  def change
    create_table :lights do |t|
      t.integer :brightness
      t.string :color
      t.string :name

      t.timestamps
    end
  end
end
