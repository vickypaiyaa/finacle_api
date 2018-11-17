module FinacleApi
  class Configuration
    attr_accessor :user_id, :password, :endpoint

    def to_hash
      {user_id: user_id, password: password, endpoint: endpoint}
    end

  end
end