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
    self.root = './tmp'
  end
end
