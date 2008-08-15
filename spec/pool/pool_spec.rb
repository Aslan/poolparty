require File.dirname(__FILE__) + '/../spec_helper'

describe "Pool" do
  before(:each) do
    @obj = Object.new
  end
  it "should respond to the pool method" do
    @obj.respond_to?(:pool).should == true
  end
  it "should store the pool in the global array" do
    @p = pool :app do
    end
    @obj.pools[:app].should == @p
  end
  
  it "should have a container when instantiaed" do
    @p = pool :app do
    end
    @p.container.should_not be_nil
  end
  
  describe "block" do
    before(:each) do
      @pool = Pool.new(:test) do
        # Inside pool block
        Proc.new {puts "hello world"}
      end
    end
    
    it "should be able to define a cloud within the pool block" do
      @pool.respond_to?(:cloud).should == true
    end
    it "should evaluate the block when creating a new pool" do
      Proc.should_receive(:new).once
      Pool.new(:test) do
        Proc.new {puts "hi"}
      end
    end
    describe "configuration" do
      before(:each) do
        @pool = Pool.new :test do
          plugin_directory "nails"
        end
      end
      it "should set the plugin_directory to nails" do
        @pool.plugin_directory.should == "nails"
      end
      
    end
    
  end
end