class Imagery # :nodoc:
  module Ext
    def initialize(*a)
      super
      @ext = :png
    end
  end

  include Ext

  # include Imagery::S3
  # s3_bucket xxx
  # self.root = './tmp'
end
