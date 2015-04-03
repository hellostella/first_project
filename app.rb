require 'active_record'
require 'pg'
require 'pry'
require 'table_print'


require_relative 'db/connection'
require_relative 'lib/account'
require_relative 'lib/transaction'

  def clear
   system ("clear")
  end

  def choose_account
    puts "
                            What account are you looking for?
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

  def user_delete_transaction(account)
    puts account.transactions
    puts "Please Enter Transaction Number to Delete"
    trans_id = gets.chomp.to_i
    return account.transactions.find(transaction_id: trans_id)
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

  # def user_filter_transaction(account)
  #   tp account.transactions
  #   puts " Please select category to view (Food,Work,Deposit,Leisure)"
  #   user_category_choice = gets.chomp
  #   return account.transactions.where(category: user_category_choice).sum(:debit)
  # end



  def start_menu
    puts "
  ******Welcome to Personal Finance Manager********
    *             Please Make a Selection Below      *
    *                1. View Accounts Menu           *
    *                3. Add an Account               *
    *                4. Remove an Account            *
    *                5. Type 5 to Quit               *
    **************************************************"
    return gets.chomp
  end

 def account_menu
   puts "
     ******Welcome to Account Options ********
   *             Please Make a Selection Below      *
   *          1. View Account Details & Balance     *
   *                2. View All Transactions        *
   *                3. Add a Transaction            *
   *                4. Remove a Transactio          *
   *                5. Update Transaction           *
   *                6. Transactions by Payee        *
   *                7. Transactions by Category     *
   *                8. Type 7 to Quit               *
   **************************************************"
   return gets.chomp
 end

clear
loop do

  account_options = start_menu
  case account_options

  when "1"
      clear
  # show account menu
    loop do

      user_account_menu = account_menu
      case user_account_menu


    when "1"
      clear
      account_and_balance = user_balance

    when "2"
      clear
      #view all transactions
      transactions_for_account = choose_account
      tp transactions_for_account.transactions.order(:id)
    when "3"
      clear
      #create transaction
      account = choose_account
      add_user_transaction = Transaction.create(user_add_transaction)
      add_user_transaction.account = account
      add_user_transaction.save
    when "4"
      clear
      #remove transaction
      account = choose_account
      transaction = user_delete_transaction(account)
      transaction.destroy
    when "5"
      clear
      #update transaction
      account = choose_account
      transaction = user_select_transaction(account)
      puts " For Security Purposes: Only the Payee name can be updated"
      new_payee = gets.chomp
      transaction.payee = new_payee
      transaction.save

    when "6"
      transactions_for_account = choose_account
      tp transactions_for_account.transactions.order(:id)
      puts " Please select Payee to view "
      user_payee_choice = gets.chomp
      puts transactions_for_account.where(payee: user_category_choice)
      puts "You've spent $#{account.transactions.where(payee: user_payee_choice).sum(:debit)} with #{user_payee_choice}"

    when "7"
      account = choose_account
      puts " Please select category to view (Food,Work,Deposit,Leisure)"
      user_category_choice = gets.chomp
      puts account.transactions.where(category: user_category_choice)
      puts "You've spent $#{account.transactions.where(category: user_category_choice).sum(:debit)} on #{user_category_choice}"


    when " "
      return start_menu
    when "8"
      puts "You are now returning to the main menu"
      break
    end
  end

    when "3"
      clear
      #create account
      Account.create(user_create_account)
    when "4"
      clear
      #remove account
      account = choose_account
      account.destroy

    when "9"
      clear
      #get user balance
      account = choose_account
      puts (account.transactions.sum(:credit) - account.transactions.sum(:debit))

    when "5"
      #quit
      puts "Thank you for using Personal Finance!"
      break
  end
end
 # binding.pry
