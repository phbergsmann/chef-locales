default['locales']['available'] = ['en_US.UTF-8 UTF-8']
default['locales']['default'] = 'en_US.UTF-8'
default['locales']['locale-gen-conf-path'] = case platform
                                             when "ubuntu"
                                              "/var/lib/locales/supported.d/mylocales"
                                             else
                                               "/etc/locale.gen"
                                             end
