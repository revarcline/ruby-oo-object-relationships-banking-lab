# things between bank accounts
class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if valid? && sender.balance > amount && status == 'pending'
      receiver.balance += amount
      sender.balance -= amount
      self.status = 'complete'
    else
      reject
    end
  end

  def reverse_transfer
    if status == 'complete'
      receiver.balance -= amount
      sender.balance += amount
      self.status = 'reversed'
    else
      reject
    end
  end

  def reject
    self.status = 'rejected'
    'Transaction rejected. Please check your account balance.'
  end
end
