chef_server_url   "http://10.33.33.100"
node_name         'chefzero_sandbox'
client_key        File.expand_path('../dummy.pem' , __FILE__)

validation_client_name 'chef-validator'
validation_key File.expand_path('./dummy.pem' ,__FILE__)

## Chef-Repo

cookbook_path [File.expand_path('../../cookbooks', __FILE__), File.expand_path('../../site-cookbooks', __FILE__)]
cache_path [File.expand_path('../../tmp/cache', __FILE__)]

