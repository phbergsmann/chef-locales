actions :add

default_action :add

attribute :locales, :kind_of => [String, Array], :name_attribute => true

def initialize(*args)
  super
  @action = :add
end
