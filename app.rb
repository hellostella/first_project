require 'active_record'
require 'pg'
require 'pry'

require_relative 'db/connection'
require_relative 'lib/account'
require_relative 'lib/transaction'

  def clear
   system ("clear")
  end

  def choose_account
    puts "               What account are you looking for?
          (Please Note: You must create an account if no account listed )"

    puts Account.all
    account_location = gets.chomp
    return Account.find_by(id: account_location)
  end

  def user_create_account
    user_account = {}
    puts "Please enter a name for the account"
    user_account[:name] = gets.chomp
    puts "What is your initial deposit going to be"
    user_account[:balance] = gets.chomp.to_i
   return user_account
  end

 def user_add_transaction
    user_transaction_add = {}
    puts "Please Specify a Payee"
    user_transaction_add[:payee] = gets.chomp
    puts "Please Specify a Category"
    user_transaction_add[:category] = gets.chomp
    puts "If making a Payment Please enter Amount, otherwise Enter 0"
    user_transaction_add[:credit] = gets.chomp.to_i
    puts "If Making a Deposit, Please enter Amount, otherwise enter 0"
    user_transaction_add[:debit] = gets.chomp.to_i
    user_transaction_add[:time_added] = Time.now
    return user_transaction_add
  end

  def user_select_transaction(account)
    puts account.transactions
    puts "Please Enter Payee"
    payee_id = gets.chomp
    return account.transactions.find_by(payee: payee_id)
  end

  def user_balance
    account = choose_account
    puts "  You have selected: #{account.name.capitalize}'s #{account.account_type.capitalize} account \n   Account Balance: $ #{account.transactions.sum(:credit) - account.transactions.sum(:debit)}"
  end

  def account_current_balance
    account_debits = account.transactions.sum(:debit)
    account_credits = account.transactions.sum(:credit)
    user_account_balance = account_credits - account_debits
    return user_account_balance
  end


  def start_menu
    puts "   ******Welcome to Personal Finance Manager********
    *             Please Make a Selection Below      *
    *                1. List all Accounts            *
    *                2. Select an Account            *
    *                3. Add an Account               *
    *                4. Remove an Account            *
    *                5. View all Transactions        *
    *                6. Add a Transaction            *
    *                7. Remove a Transaction         *
    *                8. Update a Transaction         *
    *                9. View Account Balance         *
    *               10. Quit                         *
    **************************************************"
    return gets.chomp
  end

loop do

  account_options = start_menu
  case account_options

  when "1"
    #Show all accounts
    clear
    puts Account.all

  when "2"
    #Choose Account & Show Balance
    clear
    account_and_balance = user_balance

  when "3"
    clear
    #create account
    Account.create(user_create_account)
  when "4"
    clear
    #remove account
    account = choose_account
    account.destroy

  when "5"
    clear
    #view all transactions
    transactions_for_account = choose_account
    puts transactions_for_account.transactions

  when "6"
    clear
    #create transaction
    account = choose_account
    add_user_transaction = Transaction.create(user_add_transaction)
    add_user_transaction.account = account
    add_user_transaction.save

  when "7"
    clear
    #remove transaction
    account = choose_account
    transaction = user_select_transaction(account)
    transaction.destory

  when "8"
    clear
    #update transaction
    account = choose_account
    transaction = user_select_transaction(account)
    puts " What is the new payee name"
    new_payee = gets.chomp
    transaction.payee = new_payee
    transaction.save

  when "9"
    clear
    #get user balance
    account = choose_account
    puts (account.transactions.sum(:credit) - account.transactions.sum(:debit))

  when "10"
    #quit
    break
  end
end
 # binding.pry
