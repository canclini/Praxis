class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :firstname
      t.string :lastname
      t.string :gender
      t.date :birthdate
      t.string :street
      t.string :city
      t.string :plz
      t.string :insurance
      t.string :insurantnumber
      t.string :mco

      t.timestamps
    end
  end
end
