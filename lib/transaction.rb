class Transaction < ActiveRecord::Base
  belongs_to :account

  def to_s
    return " #{id}. | Payee: #{payee} |  Category: #{category} | Credit: #{credit} | Debit: #{debit} | Created: #{time_added}
    "
end
end
