require 'imagery'
require 'open-uri'

class Imagery
  module Repropagate
    def original_file
      @original_file ||= begin
        fn = root(ext(@original))
        fn = url(:original)  unless File.exist?(fn)

        open(fn)
      end
    end

    # Returns a file path for an original file
    def original_file_path
      of = original_file
      fn = root(ext(@original))

      if File.exist?(fn)
        fn
      elsif of.respond_to?(:path)
        of.path
      else
        temp = Tempfile.new(['', ext('')])
        temp.write of.read
        temp.close
        temp.path
      end
    end

    # Repropagates a given size.
    #
    # == Example
    #
    #   i.repropagate(:small)
    #
    def repropagate(size_names)
      original = original_file_path

      sizes.each do |size, (resize, extent)|
        next  unless [*size_names].include?(size)

        GM.convert original, root(ext(size)), resize, extent
      end
    end
  end

  module S3Repropagate
    def repropagate(size_names)
      super
      [*size_names].each { |size| store size }
    end
  end

  module Png
    def initialize(*a)
      super
      @ext = :png
    end
  end
end
