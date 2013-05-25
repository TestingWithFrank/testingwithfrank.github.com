require 'aws/s3'
require 'yaml'

# All of this courtesy Giles Alexander (@gga)
class S3Deployer
  include Rake::DSL

  def initialize( access_key_id, secret_access_key )
    @access_key_id, @secret_access_key = access_key_id, secret_access_key
  end

  def upload_dir(dir, bucket)
    AWS::S3::Base.establish_connection!(:access_key_id => @access_key_id,
                                        :secret_access_key => @secret_access_key)
    cd dir do
      upload_sub_dir('.', bucket)
    end
  end

  def upload_sub_dir(dir, bucket)
    Dir["#{dir}/*"].each do |file|
      if File.directory? file
        upload_sub_dir(file, bucket)
      else
        file_name = file.gsub("./", '')
        puts "Uploading: '#{file_name}'"
        AWS::S3::S3Object.store(file_name, open(file), bucket)
      end
    end
  end
end
