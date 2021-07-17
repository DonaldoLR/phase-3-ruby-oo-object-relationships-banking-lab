class Transfer
  # your code here
  attr_accessor :sender, :receiver, :amount, :status
  @@all = []
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def self.all 
    @@all
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    
    if @sender.balance > @amount && !Transfer.all.include?(self) && self.valid?
      puts "Approving"
      puts @sender.name
      puts @receiver.name
      @@all << self
      @sender.balance -= @amount
      @receiver.deposit(@amount)
      @status = 'complete'
    else
      @@all << self
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer 
    if valid? && receiver.balance > amount && self.status == "complete"
      receiver.balance -= amount
      sender.balance += amount
      self.status = "reversed"
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end
end
