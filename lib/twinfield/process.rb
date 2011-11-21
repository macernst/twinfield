module Twinfield
  module Process
    extend self

    def session
      @session ||= Twinfield::Session.new
      @session.logon
      return @session
    end

    def client
      @client ||= Savon::Client.new do
        wsdl.document = "#{session.cluster}#{Twinfield::WSDLS[:process]}"
      end
    end

    def request(action, &block)
      if actions.include?(action)

        client.request(action, :xmlns => "http://www.twinfield.com/") do
          soap.header = {
            "Header" => {"SessionID" => session.session_id},
            :attributes! => {
              "Header" => {:xmlns => "http://www.twinfield.com/"}
            }
          }
          soap.body = "<xmlRequest><![CDATA[#{block.call}]]></xmlRequest>"
        end
      else
        "action not found"
      end
    end

    def self.actions
      @actions ||= client.wsdl.soap_actions.map{|k| k.to_s}
    end
  end
end