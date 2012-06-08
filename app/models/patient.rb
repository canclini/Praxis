class Patient < ActiveRecord::Base
  attr_accessible :birthdate, :city, :firstname, :gender, :insurance,
                  :insurantnumber, :lastname, :mco, :plz, :street, :be_href

  validates_presence_of :lastname, :firstname, :birthdate, :gender

  def is_mc?
    if last_mc_check_at.nil?
      mc_check
    elsif last_mc_check_at < Time.now - 1.week
      mc_check
    end
    managed_care
  end

  def be_url
    "http://test.blueevidence.hin.ch/MPSI/mcinsurants/" + be_uuid
  end

  def be_referral_url(zsr="")
    url = be_url + "/referral"
    url = url + "/" + zsr if zsr.length == 7
    url
  end

  private
  def mc_check
   mcinsurant = MPSI.search(lastname,firstname,gender,birthdate.strftime("%d.%m.%Y"))
   #mcinsurant = MPSI.show(id)
   unless mcinsurant.id.nil? or mcinsurant.id.empty?
     self.managed_care = true
     self.last_mc_check_at = Time.now
     self.be_uuid = mcinsurant.id
     #self.street = mcinsurant.street unless street == mcinsurant.street
     self.insurance = mcinsurant.insurance unless insurance == mcinsurant.insurance
     self.insurantnumber = mcinsurant.insurantnumber unless insurantnumber == mcinsurant.insurantnumber
     self.mco = mcinsurant.mco unless mco == mcinsurant.mco
     self.save
   end
  end
end
