class CreateFlowers < ActiveRecord::Migration[5.0]
  def change
    create_table :flowers do |t|
      t.string :name
      t.datetime :date_planted  
      t.string :perennial_or_annual
      t.string :sun
      t.string :water
      t.text :memo

      t.timestamps
    end
  end
end
