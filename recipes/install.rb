execute 'locale-gen' do
  action :nothing
end

file node['locales']['locale_file'] do
  owner 'root'
  group 'root'
end
