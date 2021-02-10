class CreateAcs < ActiveRecord::Migration[6.1]
  def change
    create_table :acs do |t|
      t.integer :temperature
      t.string :mode
      t.boolean :status
      t.string :name


      t.timestamps
    end
  end
end
