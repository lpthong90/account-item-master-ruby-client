# test_server.rb
require 'grpc'
require_relative './lib/account_item_master/service'
require 'logger'
require 'securerandom'

class TestAccountItemMasterServer < AccountItemMaster::Service
  def initialize
    @logger = Logger.new(STDOUT)
    @accounts = sample_accounts
    @items = sample_items
  end

  # Account operations
  def get_account(request, _call)
    @logger.info "Getting account with ID: #{request.account_id}"
    account = @accounts.find { |a| a[:id] == request.account_id }
    
    if account
      AccountItemMaster::Account.new(account)
    else
      raise GRPC::NotFound.new("Account not found with ID: #{request.account_id}")
    end
  end

  def list_accounts(request, _call)
    @logger.info "Listing accounts with page size: #{request.page_size}"
    
    page_size = [request.page_size, 100].min
    start_index = 0
    
    if request.page_token && !request.page_token.empty?
      start_index = request.page_token.to_i
    end
    
    paginated_accounts = @accounts[start_index, page_size]
    next_page_token = start_index + page_size < @accounts.length ? (start_index + page_size).to_s : ''
    
    AccountItemMaster::ListAccountsResponse.new(
      accounts: paginated_accounts.map { |a| AccountItemMaster::Account.new(a) },
      next_page_token: next_page_token
    )
  end

  def create_account(request, _call)
    @logger.info "Creating account with name: #{request.name}"
    
    new_account = {
      id: "acc_#{SecureRandom.hex(8)}",
      name: request.name,
      email: request.email,
      status: 'active',
      created_at: Time.now.strftime('%Y-%m-%dT%H:%M:%S.%LZ'),
      updated_at: Time.now.strftime('%Y-%m-%dT%H:%M:%S.%LZ')
    }
    
    @accounts.push(new_account)
    AccountItemMaster::Account.new(new_account)
  end

  def update_account(request, _call)
    @logger.info "Updating account with ID: #{request.account_id}"
    
    account_index = @accounts.find_index { |a| a[:id] == request.account_id }
    
    if account_index
      updated_account = @accounts[account_index].merge(
        name: request.account.name,
        email: request.account.email,
        updated_at: Time.now.strftime('%Y-%m-%dT%H:%M:%S.%LZ')
      )
      @accounts[account_index] = updated_account
      AccountItemMaster::Account.new(updated_account)
    else
      raise GRPC::NotFound.new("Account not found with ID: #{request.account_id}")
    end
  end

  def delete_account(request, _call)
    @logger.info "Deleting account with ID: #{request.account_id}"
    
    removed = @accounts.reject! { |a| a[:id] == request.account_id }
    
    if removed
      AccountItemMaster::DeleteAccountResponse.new(success: true)
    else
      raise GRPC::NotFound.new("Account not found with ID: #{request.account_id}")
    end
  end

  # Item operations
  def get_item(request, _call)
    @logger.info "Getting item with ID: #{request.item_id}"
    
    item = @items.find { |i| i[:id] == request.item_id }
    
    if item
      AccountItemMaster::Item.new(item)
    else
      raise GRPC::NotFound.new("Item not found with ID: #{request.item_id}")
    end
  end

  def list_items(request, _call)
    @logger.info "Listing items with page size: #{request.page_size}"
    
    page_size = [request.page_size, 100].min
    start_index = 0
    
    if request.page_token && !request.page_token.empty?
      start_index = request.page_token.to_i
    end
    
    paginated_items = @items[start_index, page_size]
    next_page_token = start_index + page_size < @items.length ? (start_index + page_size).to_s : ''
    
    AccountItemMaster::ListItemsResponse.new(
      items: paginated_items.map { |i| AccountItemMaster::Item.new(i) },
      next_page_token: next_page_token
    )
  end

  def create_item(request, _call)
    @logger.info "Creating item with name: #{request.item.name}"
    
    new_item = {
      id: "item_#{::SecureRandom.hex(8)}",
      name: request.item.name,
      description: request.item.description,
      category: request.item.category,
      price: request.item.price,
      created_at: Time.now.strftime('%Y-%m-%dT%H:%M:%S.%LZ'),
      updated_at: Time.now.strftime('%Y-%m-%dT%H:%M:%S.%LZ')
    }
    
    @items.push(new_item)
    AccountItemMaster::Item.new(new_item)
  end

  def update_item(request, _call)
    @logger.info "Updating item with ID: #{request.item_id}"
    
    item_index = @items.find_index { |i| i[:id] == request.item_id }
    
    if item_index
      updated_item = @items[item_index].merge(
        name: request.item.name,
        description: request.item.description,
        category: request.item.category,
        price: request.item.price,
        updated_at: Time.now.strftime('%Y-%m-%dT%H:%M:%S.%LZ')
      )
      @items[item_index] = updated_item
      AccountItemMaster::Item.new(updated_item)
    else
      raise GRPC::NotFound.new("Item not found with ID: #{request.item_id}")
    end
  end

  def delete_item(request, _call)
    @logger.info "Deleting item with ID: #{request.item_id}"
    
    removed = @items.reject! { |i| i[:id] == request.item_id }
    
    if removed
      AccountItemMaster::DeleteItemResponse.new(success: true)
    else
      raise GRPC::NotFound.new("Item not found with ID: #{request.item_id}")
    end
  end

  private

  def sample_accounts
    [
      {
        id: 'acc_sample1',
        name: 'Test Account 1',
        email: 'test1@example.com',
        status: 'active',
        created_at: Time.now.strftime('%Y-%m-%dT%H:%M:%S.%LZ'),
        updated_at: Time.now.strftime('%Y-%m-%dT%H:%M:%S.%LZ')
      },
      {
        id: 'acc_sample2',
        name: 'Test Account 2',
        email: 'test2@example.com',
        status: 'active',
        created_at: Time.now.strftime('%Y-%m-%dT%H:%M:%S.%LZ'),
        updated_at: Time.now.strftime('%Y-%m-%dT%H:%M:%S.%LZ')
      }
    ]
  end

  def sample_items
    [
      {
        id: 'item_sample1',
        name: 'Test Item 1',
        description: 'This is a test item 1',
        category: 'electronics',
        price: 99.99,
        created_at: Time.now.strftime('%Y-%m-%dT%H:%M:%S.%LZ'),
        updated_at: Time.now.strftime('%Y-%m-%dT%H:%M:%S.%LZ')
      },
      {
        id: 'item_sample2',
        name: 'Test Item 2',
        description: 'This is a test item 2',
        category: 'books',
        price: 19.99,
        created_at: Time.now.strftime('%Y-%m-%dT%H:%M:%S.%LZ'),
        updated_at: Time.now.strftime('%Y-%m-%dT%H:%M:%S.%LZ')
      }
    ]
  end
end

# Server runner script
if __FILE__ == $0
  logger = Logger.new(STDOUT)
  host = '0.0.0.0'
  port = ENV['PORT'] || '50051'
  
  server = GRPC::RpcServer.new
  server.add_http2_port("#{host}:#{port}", :this_port_is_insecure)
  server.handle(TestAccountItemMasterServer.new)
  
  logger.info "Starting test server on #{host}:#{port}"
  server.run
end
