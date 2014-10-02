module Locales
  module Helper
    def current_locale
      cmd = Mixlib::ShellOut.new('locale').run_command
      Hash[cmd.stdout.split.map { |c| c.chomp.gsub('"', '').split('=') }]
    end

    def locales_available
      Mixlib::ShellOut.new('locale -a').run_command.stdout.split
    end

    def locale_available?(locale)
      locales_available.include?(low_locale(locale))
    end

    def locale_pattern
      /(C|[a-z]*)(_[A-Z]*)?/
    end

    def parsed_locale(locale)
      # produce an Array of Hash like
      # 'fr_FR.UTF-8' give
      # {"locale"=>"fr_FR", "charmap"=>"UTF-8"}
      m = /^(?<locale>[\w@]*)\.?(?<charmap>.*)$/.match(locale)
      Hash[m.names.zip(m.captures)]
    end

    def high_locale(locale)
      p = parsed_locale(locale)
      ret = p['locale']
      ret += '.' + p['charmap'].upcase unless p['charmap'].empty?
      ret
    end

    def low_locale(locale)
      p = parsed_locale(locale)
      ret = p['locale']
      ret += '.' + p['charmap'].downcase unless p['charmap'].empty?
      ret
    end


  end
end
