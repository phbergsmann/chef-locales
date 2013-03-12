action :add do
  available = node['locales']['available'] + [ new_resource.name ]
  node.set['locales']['available'] = available.uniq!

  template node['locales']['locale-gen-conf-path'] do
    source "locale.gen.erb"
    cookbook "locales"
    owner "root"
    group "root"
    mode 00755
  end

  execute "dpkg-reconfigure" do
    command "dpkg-reconfigure --frontend=noninteractive locales"
    action :run
  end

  new_resource.updated_by_last_action(true)
end
