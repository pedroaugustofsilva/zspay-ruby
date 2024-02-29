# Zspay Ruby Gem
The Zspay Ruby Gem provides an easy-to-use interface for integrating Zspay's payment processing features into Ruby applications. This includes handling clients, bank accounts, sales, transfers, and more.

## Installation
Add this line to your application's Gemfile:
```rb
gem 'zspay'
```

And then execute:
```shell
bundle install
```

Or install it yourself as:
```shell
gem install zspay
```

## Configuration

Before using the Zspay gem, you must configure it with your Zspay API credentials. This is typically done in an initializer in your Ruby application, such as config/initializers/zspay.rb.
```rb
Zspay.configure do |config|
  config.token = 'your_zspay_api_token'
end
```

## Usage

Here's how to use the Zspay gem to interact with different resources:

### Clients
```rb
# Create a new client
client = Zspay::Client.create({
  name: 'John Doe',
  email: 'john@example.com',
  document: '12345678900'
})

# Create a new card for a client
card = Zspay::Client.create_card(client_id, {
  number: '4111111111111111',
  expiry_month: '12',
  expiry_year: '2030',
  cvv: '123'
})
```

### Bank Accounts

```rb
# List bank accounts
accounts = Zspay::BankAccount.index

# Create a new bank account
account = Zspay::BankAccount.create({
  bank_code: '001',
  agency: '0001',
  account: '123456',
  account_digit: '7'
})

# Activate a bank account
Zspay::BankAccount.active(account_id)
```

### Sales
```rb
# Create a new sale
sale = Zspay::Sale.create({
  amount: 100,
  currency: 'BRL'
})

# Retrieve details of a sale
sale_details = Zspay::Sale.show(sale_id)

# Refund a sale
refund = Zspay::Sale.refund(sale_id)
```

### Transfers
```rb
# Create a new transfer
transfer = Zspay::Transfer.create({
  amount: 100,
  recipient_id: 'recipient_id'
})

# Schedule a transfer
scheduled_transfer = Zspay::Transfer.schedule_transfer(transfer_id)

# Remove a scheduled transfer
Zspay::Transfer.remove(transfer_id)
```

## Development
After checking out the repo, run bin/setup to install dependencies. Then, run rake spec to run the tests. You can also run bin/console for an interactive prompt that will allow you to experiment.

## Contributing
Bug reports and pull requests are welcome. This project is intended to be a safe, welcoming space for collaboration.

## License
The gem is available as open source under the terms of the MIT License.
