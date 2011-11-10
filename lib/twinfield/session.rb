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
      return @session_id
    end

    def cluster
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
            "Header" => { :xmlns => 'http://www.twinfield.com/' }
          }
        }
        soap.body = "<Abandon xmlns='http://www.twinfield.com/' />"
      end
      # TODO: Return real status
      # There is no message from twinfield to know if the session
      # is abandoned. Should be looked at in the future
      return "Ok"
    end

    # Keep the session alive, to prevent session time out. A session time out will occur after 20 minutes.
    def keep_alive
      raise NotImplementedError
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