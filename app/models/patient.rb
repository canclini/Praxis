class Patient < ActiveRecord::Base
  attr_accessible :birthdate, :city, :firstname, :gender, :insurance,
                  :insurantnumber, :lastname, :mco, :plz, :street

  validates_presence_of :lastname, :firstname, :birthdate, :gender

  def is_mc?
    if last_mc_check_at < Time.now - 1.week
      mc_check
    end
    managed_care
  end

  private
  def mc_check
   #mcinsurants = MPSI.search(lastname,firstname,gender,birthdate)
   mcinsurant = MPSI.show(id)
   unless mcinsurant.id.nil? or mcinsurant.id.empty?
     self.managed_care = true
     self.last_mc_check_at = Time.now
     self.street = mcinsurant.street unless street == mcinsurant.street
     self.save
   end
  end
end
