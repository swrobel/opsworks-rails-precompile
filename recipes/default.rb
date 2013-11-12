node[:deploy].each do |application, deploy|
  Chef::Log.info("Symlinking #{release_path}/public/assets to #{new_resource.deploy_to}/shared/assets")

  link "#{release_path}/public/assets" do
    to "#{new_resource.deploy_to}/shared/assets"
  end

  rails_env = new_resource.environment['RAILS_ENV']

  Chef::Log.info('Precompiling rails assets')

  execute 'rake assets:precompile' do
    cwd release_path
    command 'bundle exec rake assets:precompile'
    environment 'RAILS_ENV ' => rails_env
  end
end
