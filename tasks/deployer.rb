require 'aws/s3'
require 'digest/md5'

require 'pry'

# The following is based on code generously 
# shared by Giles Alexander (@gga)
class S3Deployer
  include Rake::DSL

  def initialize( aws_creds, bucket )
    @aws_creds = aws_creds
    @bucket = bucket
  end

  def upload_dir(dir)
    AWS::S3::Base.establish_connection!(@aws_creds)

    cd dir do
      upload_sub_dir('.')
    end
  end

  def upload_sub_dir(dir)
    Dir["#{dir}/*"].each do |file|
      if File.directory? file
        upload_sub_dir(file)
      else
        upload_file(file)
      end
    end
  end

  def upload_file( file )
    file_name = file.gsub("./", '')
    local_file = open(file)

    begin
      s3_object = AWS::S3::S3Object.find(file_name, @bucket)
    rescue AWS::S3::NoSuchKey
      s3_object = false
    end


    if !s3_object
      puts "* #{file_name}"
      AWS::S3::S3Object.store(file_name, local_file, @bucket)
    else
      s3_md5 = s3_object.about['etag'].sub(/"(.*)"/,'\1')
      local_md5 = Digest::MD5.hexdigest( local_file.read )

      if( s3_md5 == local_md5 )
        puts "~ #{file_name}"
      else
        puts "> #{file_name}"
        AWS::S3::S3Object.store(file_name, local_file, @bucket)
      end
    end
  end
end
