require 'pry'
# require_relative 'lib/bank_account.rb'
class Transfer

  attr_accessor :status, :sender, :receiver, :amount

    def initialize(sender, receiver, amount)
      @sender = sender
      @receiver = receiver
      @status = "pending"
      @amount = amount
    end

    def valid?
      if BankAccount.all.select {|account| account.name == sender} && 
      BankAccount.all.select {|account| account.name == receiver}
        true
      end
      self.sender.valid?
      self.receiver.valid?
    end

    def execute_transaction
      return "Transaction already completed" if @status != "pending"
      if self.sender.balance > @amount && self.valid?
        self.sender.balance -= @amount
        self.receiver.balance += @amount
        @status = "complete"
      else
        @status = "rejected"
        return "Transaction rejected. Please check your account balance."
      end
      # binding.pry
      
    end

    def reverse_transfer
      if @status == "complete"
        self.receiver.balance -= @amount
        self.sender.balance += @amount
        @status = "reversed"
      end
    end

end