class Injector
  
  BASE_XML = "<title></title>"
  
  attr_accessor :value, :proc
  
  def inject(value = "")  
    self.value = value
    self
  end
  
  def between(value = "")
    # proc = Proc.new{ between(value) }
    proc = Proc.new{ puts "anuj" }
    self.proc = proc
    self
    # once
  end
  
  def twice
    proc.call
  end
  
  def thrice
    proc.call
    proc.call
  end
  
  def once
    proc.call
    # self
  end
  
end

injector = Injector.new
puts "=========== Once ========== "
puts injector.inject("hello").between
puts "=========== Once With Twist ========== "
puts injector.inject("hello").between.once
puts "=========== Twice ========== "
puts injector.inject("hello").between.twice
puts "=========== Thrice ========== "
puts injector.inject("hello").between.thrice