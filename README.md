# Account Item Master Ruby Client

A Ruby gRPC client for interacting with the Account Item Master Service. This client provides a simple interface to manage accounts and items through gRPC calls.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'account-item-master-ruby-client'
```

And then execute:

```bash
$ bundle install
```

Or install it directly using:

```bash
$ gem install account-item-master-ruby-client
```

## Prerequisites

- Ruby 2.0 or higher
- gRPC (~> 1.50)

## Usage

### Initialize the Client

```ruby
require 'account_item_master'

client = AccountItemMaster::Client.new(
  host: 'localhost',  # default
  port: '50051'      # default
)
```

### Account Operations

#### List Accounts
```ruby
# Fetch accounts with pagination
response = client.list_accounts(page_size: 10)
puts "Found #{response.accounts.length} accounts"

# Access account details
response.accounts.each do |account|
  puts "Account ID: #{account.id}"
  puts "Name: #{account.name}"
  puts "Email: #{account.email}"
  puts "Status: #{account.status}"
end
```

#### Get Account
```ruby
account = client.get_account('acc_sample1')
puts "Got account: #{account.name}"
```

#### Create Account
```ruby
new_account = client.create_account(
  name: "New Test Account",
  email: "new@test.com"
)
puts "Created account with ID: #{new_account.id}"
```

#### Update Account
```ruby
updated_account = client.update_account(
  account_id: 'acc_sample1',
  name: "Updated Account Name",
  email: "updated@test.com"
)
```

#### Delete Account
```ruby
response = client.delete_account('acc_sample1')
puts "Account deleted successfully" if response.success
```

### Item Operations

#### List Items
```ruby
response = client.list_items(page_size: 10)
puts "Found #{response.items.length} items"
```

#### Get Item
```ruby
item = client.get_item('item_sample1')
puts "Got item: #{item.name}"
```

#### Create Item
```ruby
new_item = client.create_item(
  name: "New Item",
  description: "Item description",
  category: "electronics",
  price: 99.99
)
puts "Created item with ID: #{new_item.id}"
```

#### Update Item
```ruby
updated_item = client.update_item(
  item_id: 'item_sample1',
  name: "Updated Item Name",
  description: "Updated description",
  category: "electronics",
  price: 149.99
)
```

#### Delete Item
```ruby
response = client.delete_item('item_sample1')
puts "Item deleted successfully" if response.success
```

## Error Handling

The client will raise gRPC-specific errors that you can rescue:

```ruby
begin
  client.get_account('non_existent_id')
rescue GRPC::NotFound => e
  puts "Account not found: #{e.message}"
rescue GRPC::BadStatus => e
  puts "Error occurred: #{e.message}"
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b feature/my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin feature/my-new-feature`)
5. Create a new Pull Request

## License

This gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Author

Thong Le Phi (lpthong90@gmail.com)
