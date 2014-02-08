use_inline_resources

# Support whyrun
def whyrun_supported?
  true
end

include Chef::DSL::IncludeRecipe

action :add do
  Array(new_resource.locales).each do |locale|
    execute "locale-gen #{high_locale(locale)}" do
      not_if { locale_available?(locale) }
    end
  end
end

action :set do
  if new_resource.locales.kind_of?(String)
    locales new_resource.locales do
      action :add
    end
    execute "update-locale LANG=#{high_locale}" do
      only_if { ENV['LANG'] != high_locale }
    end
  else
    Log.error('locales must be a String')
  end
end

def load_current_resource
  include_recipe "locales"
end

def locale_available?(locale)
  Mixlib::ShellOut.new("locale -a").run_command.stdout.split.include?(low_locale(locale))
end

def high_locale(locale = new_resource.locales)
  return new_resource.utf8 ? "#{locale.split('.')[0]}.UTF-8" : locale
end

def low_locale(locale = new_resource.locales)
  return new_resource.utf8 ? "#{locale.split('.')[0]}.utf8" : locale
end
