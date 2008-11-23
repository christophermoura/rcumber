require File.dirname(__FILE__) + '/../../spec_helper'

describe Rcumber do

  before(:each) do
    @all_rcumbers = Dir.glob("#{Rcumber::PATH_PREFIX}**/*.feature").collect{|x| Rcumber.new(x)}


    @content_feature =<<ENDL
Feature: A User Story
ENDL

    @content_preamble =<<ENDL
  As a user,
  I want to xyz,
  So that I can abc

ENDL

    @content_scenario_one =<<ENDL
  
    Given something cool
    And something else
    
    When something happens
    And soemthing else happens
    
    Then this must be the case
    And this must also be the case
ENDL

    @file_content = [@content_feature.to_a, @content_preamble.to_a, @content_scenario_one.to_a].flatten
  end
  
  describe "all" do
    it "should return all '.feature' files in the /features directory" do
      Rcumber.all.should_not be_empty
    end
  end
  
  describe "after construction" do

    before(:each) do
       @full_path = "#{Rcumber::PATH_PREFIX}folder/feature_x.feature"
       (@file_content.to_s =~ /Feature: (.*)/).should be_true
       File.should_receive(:read).with(@full_path).and_return(@file_content)
       @test = Rcumber.new(@full_path)
    end

    it "should strip everything up to 'features' in the path" do
      @test.path.should == @full_path
    end
      
    it "should have the content of the file" do
      @test.raw_content.should == @file_content
    end
    
    it "should have parsed the name" do
      @test.name.should == "A User Story"
    end
    
    it "should return the base filename without an extension as it's test_id" do
      @test.uid.should == "feature_x"
    end
    
    # describe "preamble" do
    #   it "should return the lines between 'Feature:' and the first Scenario:" do
    #     @test.preamble.should == @content_preamble.to_a
    #   end
    # end
  
    describe "Rcumber.find" do
      it "should return an Rcumber object if it exists" do
        Rcumber.stub!(:all).and_return([@test])
        Rcumber.all.should_receive(:detect).and_return(@test)
        Rcumber.find(@test.uid).uid.should == @test.uid
      end
    end
  
  end
  
  
end
