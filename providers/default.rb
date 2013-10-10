use_inline_resources

# Support whyrun
def whyrun_supported?
  true
end

include Chef::DSL::IncludeRecipe

action :add do
  Array(new_resource.locales).each do |local|
    execute "locale-gen #{local}" do
      not_if { locale_available?(local) }
    end
  end
end

action :set do
  if new_resource.locales.kind_of?(String)
    locales new_resource.locales do
      action :add
    end
    execute "update-locale LANG=#{new_resource.locales}" do
      only_if { ENV['LANG'] != new_resource.locales }
    end
  else
    Log.error('locales must be a String')
  end
end

def load_current_resource
  include_recipe "locales"
end

def locale_available?(locale)
  Mixlib::ShellOut.new("locale -a").run_command.stdout.split.include?(locale)
end
