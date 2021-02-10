class CreateTvs < ActiveRecord::Migration[6.1]
  def change
    create_table :tvs do |t|
      t.integer :channel
      t.integer :volume
      t.boolean :status
      t.string :name


      t.timestamps
    end
  end
end
