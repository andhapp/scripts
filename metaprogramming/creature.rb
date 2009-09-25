# require "metaid"
# 
# class Creature
#   def self.traits( *arr )
#     return @traits if arr.empty?
#     attr_accessor *arr
#     arr.each do |trait|
#       meta_def trait do |val|
#         @traits ||= {}
#         @traits[trait] = val
#       end
#     end
#     class_def :initialize do
#       self.class.traits.each do |k,v|
#         instance_variable_set( "@#{k}", v )
#       end
#     end
#   end
# end

# This defines an instance and a class method with the same name
# Absolutely !!!!!!!
class Creature
  def self.metaclass; class << self; self; end; end

  def self.traits( *arr )
    return @@traits if arr.empty?

    attr_accessor(*arr)

    arr.each do |a|
      metaclass.instance_eval do
        define_method( a ) do |val|
          @@traits ||= {}
          @@traits[a] = val
        end
      end
    end

    class_eval do
      define_method( :initialize ) do
        self.class.traits.each do |k,v|
          instance_variable_set("@#{k}", v)
        end
      end
    end
  end
end

class Rabbit < Creature
  traits :bombs, :hello
  bombs 3
  hello 6
end

puts Rabbit.new.bombs # => 3

rab = Rabbit.new
#rab.hello = 6
puts rab.hello

