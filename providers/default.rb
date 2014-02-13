include ::Locales::Helper

use_inline_resources if defined?(use_inline_resources)

# Support whyrun
def whyrun_supported?
  true
end

action :add do
  new_resource.locales.each do |locale|
    if locale_available?(locale) || locale == 'C'
      Chef::Log.debug "#{ locale } already available - nothing to do."
    else
      converge_by("Add #{ locale }") do
        add_locale(locale)
      end
    end
  end
end

action :set do
  Chef::Log.error('Only set 1 locale') if new_resource.locales.count != 1

  locale = new_resource.locales[0]
  Chef::Log.debug "Set locale #{ new_resource.locales }"

  locales locale do
    action :add
  end

  env_variables = %w(LANG LANGUAGE)
  env_variables << 'LC_ALL' if new_resource.lc_all

  env_variables.each do |env_var|
    ruby_block "update-locale #{env_var} #{locale}" do
      block { update_locale(env_var, locale) }
      only_if { ENV[env_var] != high_locale(locale) }
    end
  end
end

def initialize(name, run_context = nil)
  super
  new_locales = Array(new_resource.locales).map { |l| l[locale_pattern] }
  @new_resource.locales(new_locales)
end

def locale_available?(locale)
  locales_available.include?(low_locale(locale))
end

def high_locale(locale)
  new_resource.utf8 ? "#{locale}.UTF-8" : locale
end

def low_locale(locale)
  new_resource.utf8 ? "#{locale}.utf8" : locale
end

def add_locale(locale)
  execute "locale-gen #{high_locale(locale)}"
end

def update_locale(variable, locale)
  cmd = "update-locale #{variable}=#{high_locale(locale)}"
  Mixlib::ShellOut.new(cmd).run_command
  ENV[variable] = locale
end
