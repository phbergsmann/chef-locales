actions :add

attribute :name, :kind_of => String, :name_attribute => true
attribute :charset, :kind_of => String, :default=> 'UTF-8'

def initialize(*args)
  super
  @action = :add
end