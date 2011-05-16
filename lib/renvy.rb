require 'test/unit'

# Rspec-like matching for Test::Unit.
#
# == Usage
#
#   obj.should == 2
#   obj.should ~= /regex/
#   obj.should != 3
#   obj.should.be.true!
#   obj.should.be.false!
#   obj.should.be.nil?
#   
#   # You can also use shouldnt:
#   obj.shouldnt == 3
#   obj.shouldnt.be.nil?
#   
#   should.raise(Error) { lol }
#   shouldnt.raise { puts "hi" }
#
class Test::Unit::TestCase
  alias old_setup setup
  def setup(&blk)
    old_setup &blk
    REnvy::Matcher.init self
  end
end

module REnvy
  class Matcher
    attr_reader :left

    def self.init(test)
      @@test = test
    end

    def initialize(left, neg=false)
      @left = left
      @neg  = neg
    end

    def ==(right)
      unless @neg
        @@test.send :assert_equal, right, left
      else
        @@test.send :assert_not_equal, right, left
      end
    end

    def !=(right)
      unless @neg
        @@test.send :assert_not_equal, right, left
      else
        @@test.send :assert_equal, right, left
      end
    end

    def =~(right)
      unless @neg
        @@test.send :assert_match, right, left
      else
        @@test.send :assert, ! (left =~ right)
      end
    end

    def be
      Be.new(left, @neg)
    end

    def raise(ex=StandardError, &blk)
      unless @neg
        @@test.send :assert_raises, ex, &blk
      else
        @@test.send :assert_nothing_raised, &blk
      end
    end

    def method_missing(meth, *args, &blk)
      result = left.send(meth, *args, &blk)
      unless @neg
        @test.send :assert, result
      else
        @test.send :assert, ! result
      end
    end
  end

  class Matcher::Be < Matcher
    def true!
      unless @neg
        @@test.send :assert, left
      else
        @@test.send :assert, ! left
      end
    end

    def false!
      unless @neg
        @@test.send :assert, ! left
      else
        @@test.send :assert, left
      end
    end
  end
end

class Object
  def should
    REnvy::Matcher.new(self)
  end

  def shouldnt
    REnvy::Matcher.new(self, true)
  end
end

if __FILE__ == $0
  class REnvyTest < Test::Unit::TestCase
    def test_should
      2.should   == 2
      2.shouldnt == 3

      2.should   != 3
      2.shouldnt != 2

      "hi".should =~ /hi/
      "hi".shouldnt =~ /HI/

      true.should.be.true!
      "ye".should.be.true!
      true.shouldnt.be.false!

      false.should.be.false!
      false.shouldnt.be.true!

      @foo.should.be.nil?
      1000.shouldnt.be.nil?

      "".should.respond_to?(:empty?)
      "".shouldnt.respond_to?(:lolwhat)

      shouldnt.raise { 2 + 2 }
      should.raise(ZeroDivisionError) { 2 / 0 }
    end
  end
end
