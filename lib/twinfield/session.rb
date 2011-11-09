module Twinfield
  class Session

    attr_accessor :session_id

    def initialize
      @client = Savon::Client.new do
        wsdl.document = Twinfield::DOCUMENT_URLS[:login]
      end
    end

    # Retrieve a SessionID
    def logon
      response = @client.request :logon do
        soap.input = ["Logon", {"xmlns" => "http://www.twinfield.com/"}]
        soap.body = Twinfield::Config.to_hash
      end

      logon_result = case response.body[:logon_response][:logon_result]
         when "Ok" then @session_id = response.header[:header][:session_id]
         else "Invalid"
      end
      return logon_result
    end

    def session_id(auto_logon = true)
      @session_id || (logon if auto_logon)
    end

    # Keep the session alive, to prevent session time out. A session time out will occur after 20 minutes.
    def keep_alive
    end

    # Abandons the session.
    def abandon
    end

    # Gets the session's user role.
    def get_role
      raise NotImplementedError
    end

    # Sends the sms code.
    def sms_send_code
      raise NotImplementedError
    end

    # Logs on with the sms code.
    def sms_logon
      raise NotImplementedError
    end

    # Changes the password.
    def change_password
      raise NotImplementedError
    end

    def change_password
      raise NotImplementedError
    end

    # Selects a company.
    def select_company
      raise NotImplementedError
    end
  end
end