require 'grpc'
require_relative '../protos/account_item_master_services_pb'

module AccountItemMaster
  class Service < AccountItemMasterService::Service
    def get_account(request, _unused_call)
      # Implement the actual logic here
      Account.new(
        id: request.account_id,
        name: "Example Account",
        email: "example@example.com",
        status: "active",
        created_at: Time.now.to_s,
        updated_at: Time.now.to_s
      )
    end

    # Implement other service methods similarly
  end
end
