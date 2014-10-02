execute 'locale-gen' do

  # locale-archive is buggy with setlocale()
  # using --no-archive option
  case node['platform_family']
  when 'ubuntu'
    command <<-EOS
      rm /usr/lib/locale/locale-archive
      locale-gen --no-archive
    EOS
  end
end
