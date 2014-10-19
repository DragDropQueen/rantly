AWS.config(access_key_id:     ENV['AWS-ACCESS-KEY-ID'],
           secret_access_key: ENV['AWS-SECRET-ACCESS-KEY'] )

S3_BUCKET = AWS::S3.new.buckets[ENV['S3-BUCKET']]