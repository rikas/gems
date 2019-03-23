# config valid only for current version of Capistrano
lock '3.11.0'

set :application, 'gems'
set :repo_url, 'git@github.com:rikas/gems.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/ubuntu'

set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.4.2'

set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} " \
  "#{fetch(:rbenv_path)}/bin/rbenv exec"

set :rbenv_roles, :all # default value

# Sidekiq configuration has no default values
set :sidekiq_config, "#{current_path}/config/sidekiq.yml"
set :sidekiq_require, "#{current_path}/config/sidekiq.rb"

# Required for Unicorn to start with the right environment
set :unicorn_rack_env, fetch(:stage)

# Default value is for rails environments
set :unicorn_config_path, "#{current_path}/config/unicorn.rb"

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w[.env]

# Default value for linked_dirs is []
set :linked_dirs, %w[log gems tmp/pids tmp/cache tmp/sockets]

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do
  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  task :restart do
    invoke 'unicorn:legacy_restart'
  end
end
