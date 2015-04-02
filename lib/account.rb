class Account < ActiveRecord::Base
  has_many :transactions, dependent: :destroy

  def clear
    system ("clear")
  end

   def to_s

     return "            |#{id}.|  Account Holder's Name:  #{name.capitalize} | Account Type: #{account_type.capitalize}|

     "
   end
end
