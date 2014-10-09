actions :add, :set

default_action :add

attribute :locales, kind_of: [String, Array], name_attribute: true
attribute :charmap, kind_of: String
attribute :lc_all, kind_of: [TrueClass, FalseClass], default: true

attr_accessor :exists

def initialize(*args)
  super
  @action = :add
end
