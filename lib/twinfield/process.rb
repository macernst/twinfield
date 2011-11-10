module Twinfield
  class Process
    Savon.env_namespace = :soap

    def initialize(session_id, cluster_url)
      @session_id = session_id
      @client = Savon::Client.new do
        wsdl.document = "#{cluster_url}#{Twinfield::WSDLS[:process]}"
      end
    end

    def actions
      @client.wsdl.soap_actions
    end

    def request(method, &block)
      method = method.to_sym
      if actions.include?(method)
        session_id = @session_id
        @client.request(method) do
          soap.header = {
            "Header" => {"SessionID" => session_id},
            :attributes! => {
              "Header" => {:xmlns => "http://www.twinfield.com/"}
            }
          }
          soap.body = block.call
        end
      else
        raise "Method not found"
      end
    end
  end
end