# lib/account_item_master.rb
require 'grpc'
require_relative 'account_item_master/version'
require_relative 'account_item_master/service'
require_relative 'protos/account_item_master_services_pb'

module AccountItemMaster
  class Error < StandardError; end

  class Client
    attr_reader :stub

    def initialize(host: 'localhost', port: '50051')
      @stub = AccountItemMasterService::Stub.new(
        "#{host}:#{port}",
        :this_channel_is_insecure
      )
    end

    def get_account(account_id)
      request = GetAccountRequest.new(account_id: account_id)
      @stub.get_account(request)
    end

    def list_accounts(page_size: 10, page_token: nil)
      request = ListAccountsRequest.new(
        page_size: page_size,
        page_token: page_token
      )
      @stub.list_accounts(request)
    end

    def create_account(name:, email:)
      request = CreateAccountRequest.new(
        name: name,
        email: email
      )
      @stub.create_account(request)
    end

    # Add similar methods for other operations
  end

  class Server
    class << self
      def start(host: '0.0.0.0', port: '50051')
        addr = "#{host}:#{port}"
        s = GRPC::RpcServer.new
        s.add_http2_port(addr, :this_port_is_insecure)
        s.handle(Service.new)
        s.run_till_terminated
      end
    end
  end
end
