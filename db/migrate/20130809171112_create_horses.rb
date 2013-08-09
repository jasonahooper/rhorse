class CreateHorses < ActiveRecord::Migration
  def change
    create_table :horses do |t|
      t.string :name
      t.string :sex
      t.integer :year
      t.references :sire, index: true
      t.references :dam, index: true

      t.timestamps
    end
    add_index :horses, :name, unique: true
  end
end
