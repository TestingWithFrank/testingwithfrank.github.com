require 'microstatic/rake'

PREVIEW_AWS_BUCKET = "preview.testingwithfrank.com"
PRODUCTION_AWS_BUCKET = "www.testingwithfrank.com"

def aws_creds
  {
    :access_key_id => ENV.fetch('AWS_ACCESS_KEY_ID'),
    :secret_access_key => ENV.fetch('AWS_SECRET_ACCESS_KEY')
  }
end

def deploy_to_bucket(bucket)
  public_dir = File.expand_path("../../public",__FILE__)
  deployer = Microstatic::S3Deployer.new( public_dir, bucket, aws_creds )
  deployer.upload
end

namespace :deploy do
  source_dir = File.expand_path("../../public",__FILE__)


  desc "deploy to production"
  Microstatic::Rake.s3_deploy_task( :prod ) do |task|
    task.source_dir = source_dir
    task.bucket_name = PRODUCTION_AWS_BUCKET
  end

  desc "deploy to preview"
  Microstatic::Rake.s3_deploy_task( :preview ) do |task|
    task.source_dir = source_dir
    task.bucket_name = PREVIEW_AWS_BUCKET
  end
end
