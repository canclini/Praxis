class Patient < ActiveRecord::Base
  attr_accessible :birthdate, :city, :firstname, :gender, :insurance, :insurantnumber, :lastname, :mco, :plz, :street

  validates_presence_of :lastname, :firstname, :birthdate, :gender
end
