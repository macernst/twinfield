module Twinfield
  class Session

    attr_accessor :session_id, :cluster

    def initialize
      @client = Savon::Client.new do
        wsdl.document = Twinfield::WSDLS[:session]
      end
    end

    # Retrieve a SessionID
    def logon
      response = @client.request :logon do
        soap.input = ["Logon", {"xmlns" => "http://www.twinfield.com/"}]
        soap.body = Twinfield::Config.to_hash
      end

      if response.body[:logon_response][:logon_result] == "Ok"
        @session_id = response.header[:header][:session_id]
        @cluster = response.body[:logon_response][:cluster]
      end

      @message = case response.body[:logon_response][:logon_result]
        when "Ok" then "Log-on successful."
        when "Blocked" then "Log-on is blocked, because of system maintenance."
        when "Untrusted" then "Log-on is not trusted."
        when "Invalid" then "Log-on is invalid."
        when "Deleted" then "Log-on is disabled."
        when "OrganisationInactive" then "Organization is inactive."
        else "Unknown status"
      end

      return @message
    end

    def session_id
      raise "No active session_id found." if @session_id.nil?
      return @session_id
    end

    def cluster
      raise "No active cluster found." if @cluster.nil?
      return @cluster
    end

    # Abandons the session.
    def abandon
      response = @client.request :abandon do
        soap.header = {
          "Header" => {
            "SessionID" => session_id
          },
          :attributes! => {
            "Header" => {:xmlns => "http://www.twinfield.com/"}
          }
        }
        soap.body = "<Abandon xmlns='http://www.twinfield.com/' />"
      end
      # TODO: Return real status
      # There is no message from twinfield if the action succeeded
      return "Ok"
    end

    # Keep the session alive, to prevent session time out. A session time out will occur after 20 minutes.
    def keep_alive
      response = @client.request :keep_alive do
        soap.header = {
          "Header" => {
            "SessionID" => session_id
          },
          :attributes! => {
            "Header" => {:xmlns => "http://www.twinfield.com/"}
          }
        }
        soap.body = "<KeepAliveResponse xmlns='http://www.twinfield.com/' />"
      end
      # TODO: Return real status
      # There is no message from twinfield if the action succeeded
      return "Ok"
    end

    # Gets the session's user role.
    def get_role
      # <?xml version="1.0" encoding="utf-8"?>
      # <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      #   <soap:Header>
      #     <Header xmlns="http://www.twinfield.com/">
      #       <SessionID>string</SessionID>
      #     </Header>
      #   </soap:Header>
      #   <soap:Body>
      #     <GetRole xmlns="http://www.twinfield.com/" />
      #   </soap:Body>
      # </soap:Envelope>
      raise NotImplementedError
    end

    # Sends the sms code.
    def sms_send_code
      # <?xml version="1.0" encoding="utf-8"?>
      # <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      #   <soap:Header>
      #     <Header xmlns="http://www.twinfield.com/">
      #       <SessionID>string</SessionID>
      #     </Header>
      #   </soap:Header>
      #   <soap:Body>
      #     <SmsSendCode xmlns="http://www.twinfield.com/" />
      #   </soap:Body>
      # </soap:Envelope>
      raise NotImplementedError
    end

    # Logs on with the sms code.
    def sms_logon
      # <?xml version="1.0" encoding="utf-8"?>
      # <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      #   <soap:Header>
      #     <Header xmlns="http://www.twinfield.com/">
      #       <SessionID>string</SessionID>
      #     </Header>
      #   </soap:Header>
      #   <soap:Body>
      #     <SmsLogon xmlns="http://www.twinfield.com/">
      #       <smsCode>string</smsCode>
      #     </SmsLogon>
      #   </soap:Body>
      # </soap:Envelope>
      raise NotImplementedError
    end

    # Changes the password.
    def change_password
      # <?xml version="1.0" encoding="utf-8"?>
      # <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      #   <soap:Header>
      #     <Header xmlns="http://www.twinfield.com/">
      #       <SessionID>string</SessionID>
      #     </Header>
      #   </soap:Header>
      #   <soap:Body>
      #     <ChangePassword xmlns="http://www.twinfield.com/">
      #       <currentPassword>string</currentPassword>
      #       <newPassword>string</newPassword>
      #     </ChangePassword>
      #   </soap:Body>
      # </soap:Envelope>
      raise NotImplementedError
    end

    # Selects a company.
    def select_company
      # <?xml version="1.0" encoding="utf-8"?>
      # <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      #   <soap:Header>
      #     <Header xmlns="http://www.twinfield.com/">
      #       <SessionID>string</SessionID>
      #     </Header>
      #   </soap:Header>
      #   <soap:Body>
      #     <SelectCompany xmlns="http://www.twinfield.com/">
      #       <company>string</company>
      #     </SelectCompany>
      #   </soap:Body>
      # </soap:Envelope>
      raise NotImplementedError
    end
  end
end