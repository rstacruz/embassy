if ENV['AMAZON_ACCESS_KEY_ID'] &&
   ENV['AMAZON_SECRET_ACCESS_KEY'] &&
   ENV['AMAZON_S3_BUCKET']

  Main.set :s3, Hashie::Mash.new(bucket: { ENV['AMAZON_S3_BUCKET'] })

else

  Main.set :s3, nil

end
