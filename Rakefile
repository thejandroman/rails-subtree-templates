# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

require 'pathname'
require 'yaml'

Rails.application.load_tasks

DOMAINS_CONFIG_FILE = './domains.yml'
CONTENT_FOLDER      = './content'
LAYOUT_FOLDER       = './app/views/layouts'

desc 'Creates or updates domains configured in domains.yml'
task :create_update_domains do
  domains = YAML.load_file(DOMAINS_CONFIG_FILE)['domains']
  content = Pathname.new(CONTENT_FOLDER)
  layout  = Pathname.new(LAYOUT_FOLDER)

  domains.each do |domain, repos|
    content_domain_dir = content + domain
    content_dir        = content_domain_dir + URI.parse(repos['content_repo']).path.split('/').last
    content_domain_dir.mkpath
    create_update_dir(content_dir, repos['content_repo'])

    layout_domain_dir = layout + domain
    layout_dir        = layout_domain_dir + URI.parse(repos['layout_repo']).path.split('/').last
    layout_domain_dir.mkpath
    create_update_dir(layout_dir, repos['layout_repo'])
  end
end

def create_update_dir(dir, repo)
  if dir.exist?
    Dir.chdir(dir.realdirpath) do
      system 'git pull'
    end
  else
    `git clone #{repo} #{dir}` unless dir.exist?
  end
end
