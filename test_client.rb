require_relative './lib/account_item_master'

# Test client usage
client = AccountItemMaster::Client.new(host: 'localhost', port: '50051')

# List accounts
response = client.list_accounts(page_size: 10)
puts "Found #{response.accounts.length} accounts"

# Get specific account
account = client.get_account('acc_sample1')
puts "Got account: #{account.name}"

# Create new account
new_account = client.create_account(
  name: "New Test Account",
  email: "new@test.com"
)
puts "Created account with ID: #{new_account.id}"
