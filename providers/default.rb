use_inline_resources

# Support whyrun
def whyrun_supported?
  true
end

include Chef::DSL::IncludeRecipe

action :add do
  include_recipe "locales"
  
  Array(new_resource.locales).each do |local|
    execute "locale-gen #{local}" do
      not_if { locale_available?(local) }
    end
  end
end

def locale_available?(locale)
  Mixlib::ShellOut.new("locale -a").run_command.stdout.split.include?(locale)
end
