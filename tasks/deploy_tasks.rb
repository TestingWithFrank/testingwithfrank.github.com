require_relative 'deployer'

PRODUCTION_AWS_BUCKET = "preview.testingwithfrank.com"

desc "deploy to production"
task :deploy do
  aws_access_key_id = ENV.fetch('AWS_ACCESS_KEY_ID')
  aws_secret_access_key = ENV.fetch('AWS_SECRET_ACCESS_KEY')

  deployer = S3Deployer.new( aws_access_key_id, aws_secret_access_key )
  deployer.upload_dir( File.expand_path("../../public",__FILE__), PRODUCTION_AWS_BUCKET )
end

