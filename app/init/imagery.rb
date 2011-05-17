class Imagery # :nodoc:
  module Ext
    def initialize(*a)
      super
      @ext = :png
    end
  end

  module GM
    CONVERT = "convert -size '%s' '%s' -resize '%s' %s '%s'"
  end

  include Ext

  if Main.s3?
    include Imagery::S3

    s3_bucket Main.s3.bucket
    s3_host   Main.s3.host
    s3_distribution_domain Main.s3.distribution_domain

    self.root = './tmp'
  end
end
