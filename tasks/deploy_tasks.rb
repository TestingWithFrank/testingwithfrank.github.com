require 'microstatic'

PREVIEW_AWS_BUCKET = "preview.testingwithfrank.com"
PRODUCTION_AWS_BUCKET = "preview.testingwithfrank.com" # NOT CONFIDENT QUITE YET

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

desc "deploy to production"
task :deploy do
  deploy_to_bucket(PRODUCTION_AWS_BUCKET)
end

