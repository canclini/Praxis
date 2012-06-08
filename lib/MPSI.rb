require 'httparty'

class MCInsurant
  attr_reader :id, :lastname, :firstname, :gender, :birthdate, :street, :insurance, :insurantnumber, :mco, :href

  def initialize(args)
    unless args.nil?
    args.each do |k,v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
    end
  end
end

class MPSI
  include HTTParty
  #http_proxy 'http://localhost', '5016' #does not work
  base_uri 'http://test.blueevidence.hin.ch/MPSI'
  headers 'Accept' => 'application/xml'

  def self.show(id,options={})
    options = {:http_proxyaddr => 'localhost', :http_proxyport => '5016'}
    response = get("/mcinsurants/#{id}", options)
    puts response.parsed_response["mcinsurant"]
    MCInsurant.new(response.parsed_response["mcinsurant"])
  end

  def self.search(lastname, firstname, gender, birthdate)
    options = {:query => {:lastname=>lastname, :firstname => firstname, :gender=>gender, :birthdate=>birthdate}, :http_proxyaddr => 'localhost', :http_proxyport => '5016'}
    response = get("/mcinsurants/", options )
    puts response.parsed_response.inspect
    MCInsurant.new(response.parsed_response["mcinsurants"]["mcinsurant"])
    #mcinsurants = []
    #response.parsed_response["mcinsurants"].each do |mcins|
      ##mcinsurants.push MCInsurant.new(mcins["mcinsurant"])
    #end
    #mcinsurants
  end
end
