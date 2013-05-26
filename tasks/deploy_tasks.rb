require_relative 'deployer'

PREVIEW_AWS_BUCKET = "preview.testingwithfrank.com"
PRODUCTION_AWS_BUCKET = "preview.testingwithfrank.com"

def load_aws_creds
  {
    :access_key_id => ENV.fetch('AWS_ACCESS_KEY_ID'),
    :secret_access_key => ENV.fetch('AWS_SECRET_ACCESS_KEY')
  }
end

def deploy_to_bucket(bucket)
  deployer = S3Deployer.new( load_aws_creds, bucket )
  public_dir = File.expand_path("../../public",__FILE__)
  deployer.upload_dir( public_dir )
end

desc "deploy to production"
task :deploy do
  deploy_to_bucket(PRODUCTION_AWS_BUCKET)
end

