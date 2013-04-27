require "kjorskra/version"
require "httparty"
require "nokogiri"

module Kjorskra
  class Kjorskra
    include HTTParty
    class InvalidParameterError < StandardError; end

    def initialize(kts)
      @kennitala = handle_kt(kts)
      raise InvalidParameterError, "Input must be a string" unless kts.kind_of?(String)
    end

    def get_registeration()
      resp = self.class.post("http://kjorskra.island.is",
                             :body => {
                               "__VIEWSTATE" => "",
                               "txtKennitala_Raw" => @kennitala,
                               "txtKennitala" => @kennitala,
                               "btnLeit" => ""
                             })
      if resp.code == 200
        tblfragment = Nokogiri::HTML(resp.body).css("#ASPxGridView1_DXDataRow0 td")
        if tblfragment
          { :name => tblfragment[1].content.strip,
            :address => tblfragment[2].content.strip,
            :district => tblfragment[3].content.strip,
            :municipality => tblfragment[4].content.strip,
            :polling_place => tblfragment[5].content.strip,
            :devision => tblfragment[6].content.strip }
        else
          :no_registeration
        end
      end
    end

    private
    def handle_kt(kennitala)
      kennitala = kennitala.sub("-", "")
      check = 11 - (((kennitala[0].to_i * 3) +
                    (kennitala[1].to_i * 2) +
                    (kennitala[2].to_i * 7) +
                    (kennitala[3].to_i * 6) +
                    (kennitala[4].to_i * 5) +
                    (kennitala[5].to_i * 4) +
                    (kennitala[6].to_i * 3) +
                    (kennitala[7].to_i * 2)) % 11)
      if kennitala[8].to_i == check
        p = kennitala.scan(/.{1,6}/)
        "#{p[0]}-#{p[1]}"
      else
        raise InvalidParameterError, "Not a valid kennitala"
      end
    end
  end
end
