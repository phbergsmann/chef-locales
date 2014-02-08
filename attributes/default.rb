case node['platform_family']
when "debian"
  default['locales']['packages'] = ["locales"]
else
  default['locales']['packages'] = []
end

default['locales']['default'] = "en_US.utf8"
