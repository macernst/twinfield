module Twinfield
  module Config

    extend self

    def setup
      yield self
    end

    def username
      @@username
    end

    def username=(username)
      @@username = username
    end

    def password
      @@password
    end

    def password=(password)
      @@password = password
    end

    def organisation
      @@organisation
    end

    def organisation=(organisation)
      @@organisation = organisation
    end

    def to_hash
      {
        "user" => @@username,
        "password" => @@password,
        "organisation" => @@organisation
      }
    end
  end
end