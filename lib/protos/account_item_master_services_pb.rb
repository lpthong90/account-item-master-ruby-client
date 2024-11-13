# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: account_item_master.proto for package 'account_item_master'

require 'grpc'
require_relative 'account_item_master_pb'

module AccountItemMaster
  module AccountItemMasterService
    class Service

      include ::GRPC::GenericService

      self.marshal_class_method = :encode
      self.unmarshal_class_method = :decode
      self.service_name = 'account_item_master.AccountItemMasterService'

      # Account related operations
      rpc :GetAccount, ::AccountItemMaster::GetAccountRequest, ::AccountItemMaster::Account
      rpc :ListAccounts, ::AccountItemMaster::ListAccountsRequest, ::AccountItemMaster::ListAccountsResponse
      rpc :CreateAccount, ::AccountItemMaster::CreateAccountRequest, ::AccountItemMaster::Account
      rpc :UpdateAccount, ::AccountItemMaster::UpdateAccountRequest, ::AccountItemMaster::Account
      rpc :DeleteAccount, ::AccountItemMaster::DeleteAccountRequest, ::AccountItemMaster::DeleteAccountResponse
      # Item related operations
      rpc :GetItem, ::AccountItemMaster::GetItemRequest, ::AccountItemMaster::Item
      rpc :ListItems, ::AccountItemMaster::ListItemsRequest, ::AccountItemMaster::ListItemsResponse
      rpc :CreateItem, ::AccountItemMaster::CreateItemRequest, ::AccountItemMaster::Item
      rpc :UpdateItem, ::AccountItemMaster::UpdateItemRequest, ::AccountItemMaster::Item
      rpc :DeleteItem, ::AccountItemMaster::DeleteItemRequest, ::AccountItemMaster::DeleteItemResponse
    end

    Stub = Service.rpc_stub_class
  end
end