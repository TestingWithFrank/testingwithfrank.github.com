require 'aws/s3'
require_relative 'tasks/deploy_tasks.rb'


desc "use jekyll to generate the static site into the `public` dir"
task :generate do
  sh "jekyll public"
end
