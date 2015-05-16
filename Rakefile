require "bundler/gem_tasks"

def set_remote_url(url)
	`git remote set-url origin #{url}`
	puts "Set remote url to #{url}"
end

task :ssh do
   set_remote_url('git@github.com:tpadjen/mixed_number.git')
end

task :http do
   set_remote_url('https://github.com/tpadjen/mixed_number.git')
end

