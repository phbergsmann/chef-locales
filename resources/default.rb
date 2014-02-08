actions :add, :set

default_action :add

attribute :locales, :kind_of => [String, Array], :name_attribute => true
attribute :utf8, :kind_of => [TrueClass, FalseClass], :default => true

def initialize(*args)
  super
  @action = :add
end
