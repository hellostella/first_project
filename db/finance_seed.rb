require 'active_record'
require 'pry'
require_relative 'connection'
require_relative '../lib/account'
require_relative '../lib/transaction'
# require_relative '../app'


Account.destroy_all
Transaction.destroy_all

Account.create([
  {name: "kevin", account_type: "savings"},
  {name: "kevin", account_type: "checking"},
  {name: "alif", account_type: "savings"},
  {name: "alif", account_type: "checking"}
])

kevin = Account.find_by(name: "kevin")
kevins_debits = kevin.transactions.create([
  {payee: "Starbucks", category: "Food", debit: 10},
  {payee: "Chopt", category: "Food", debit: 15},
  {payee: "MicroCenter", category: "Food", debit: 1200},
  {payee: "Staples", category: "Work", debit: 500},
  ])
kevins_credits = kevin.transactions.create([
  {category: "Deposit", credit: 3000.00},
  {category: "Deposit", credit: 150.00},
  {category: "Deposit", credit: 1500.00},
  {category: "Deposit", credit: 250.00}
  ])

alif = Account.find_by(name: "alif")
alifs_debits = alif.transactions.create([
  {payee: "Mcdonalds", category: "Deposit", debit: 30},
  {payee: "BestBuy",   category: "Deposit",  debit: 105},
  {payee: "Staples",   category: "Deposit",  debit: 45},
  {payee: "Modells",   category: "Deposit",  debit: 15}
  ])

alifs_credits =  alif.transactions.create([
  {category: "Deposit", credit: 150},
  {category: "Deposit", credit: 200},
  {category: "Deposit", credit: 300},
  {category: "Deposit", credit: 400}
  ])

binding.pry
