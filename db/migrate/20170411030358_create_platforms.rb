class CreatePlatforms < ActiveRecord::Migration[5.0]
  def change
    create_table :platforms do |t|
      t.string :name
      t.string :bording_number

      t.timestamps
    end
  end
end
