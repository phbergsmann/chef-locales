# Support whyrun
def whyrun_supported?
  true
end

action :add do
  Array(new_resource.locales).each do |locale|
    unless locale_available?(locale)
      case node['platform']
        when "debian"
          file_append_line('/etc/locale.gen', "#{high_locale(locale)} UTF-8")
          execute "dpkg-reconfigure" do
            command "dpkg-reconfigure --frontend=noninteractive locales"
            action :run
          end
        else
          execute "locale-gen #{high_locale(locale)}" do
            not_if { locale_available?(locale) }
          end
      end
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

def locale_available?(locale)
  Mixlib::ShellOut.new("locale -a").run_command.stdout.split.include?(low_locale(locale))
end

def high_locale(locale = new_resource.locales)
  return new_resource.utf8 ? "#{locale.split('.')[0]}.UTF-8" : locale
end

def low_locale(locale = new_resource.locales)
  return new_resource.utf8 ? "#{locale.split('.')[0]}.utf8" : locale
end

def file_append_line(path, line_to_append)
  string = escape_string line_to_append
  regex = /^#{string}$/


  if ::File.exists?(path)
    begin
      f = ::File.open(path, "w+")

      found = false
      f.lines.each { |line| found = true if line =~ regex }

      unless found
        f.puts line_to_append
      end
    ensure
      f.close
    end
  else
    begin
      f = ::File.open(path, "w")
      f.puts line_to_append
    ensure
      f.close
    end
  end
end

def escape_string(string)
  pattern = /(\+|\'|\"|\.|\*|\/|\-|\\|\(|\)|\{|\})/
  string.gsub(pattern){|match|"\\" + match}
end