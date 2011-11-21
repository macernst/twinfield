module Twinfield
  class Session

    attr_accessor :session_id, :cluster

    # sets up a new savon client which will be used for current Session
    def initialize
      @client = Savon::Client.new do
        wsdl.document = Twinfield::WSDLS[:session]
      end
    end

    # retrieve a session_id and cluster from twinfield
    # relog is by default set to false so when logon is called on your
    # current session, you wont lose your session_id
    def logon(relog = false)
      if connected? && (relog == false)
        "already connected"
      else
        response = @client.request :logon do
          soap.input = ["Logon", {"xmlns" => "http://www.twinfield.com/"}]
          soap.body = Twinfield.configuration.to_hash
        end
        if response.body[:logon_response][:logon_result] == "Ok"
          @session_id = response.header[:header][:session_id]
          @cluster = response.body[:logon_response][:cluster]
        end
        @message = response.body[:logon_response][:logon_result]
      end
    end

    # call logon method with relog set to true
    # this wil destroy the current session and cluster
    def relog
      logon(relog = true)
    end

    # after a logon try you can ask the current status
    def status
      @message
    end

    # Returns true or false if current session has a session_id
    # and cluster from twinfield
    def connected?
      !!@session_id && !!@cluster
    end

    # Abandons the session.
    def abandon
      if session_id
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
      else
        "no session found"
      end
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