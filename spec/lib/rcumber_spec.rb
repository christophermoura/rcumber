require File.dirname(__FILE__) + '/../spec_helper'

describe Rcumber do
 
  before(:each) do
    @all_rcumbers = Dir.glob("#{Rcumber::PATH_PREFIX}**/*.feature").collect{|x| Rcumber.new(x)}
    Rcumber.all.first.name == @all_rcumbers.first.name
 
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
       @full_path = File.dirname(__FILE__) + '/../fixtures/feature_x.feature'
       (@file_content.to_s =~ /Feature: (.*)/).should == 0
       File.should_receive(:exist?).with(@full_path).and_return(true)
       File.should_receive(:read).with(@full_path).and_return(@file_content)
       @rcumber = Rcumber.new(@full_path)
    end
 
    it "should strip everything up to 'features' in the path" do
      @rcumber.path.should == @full_path
    end
      
    it "should have the content of the file" do
      @rcumber.raw_content.should == @file_content
    end
    
    it "should have parsed the name" do
      @rcumber.name.should == "A User Story"
    end
    
    it "should return the base filename without an extension as it's test_id" do
      @rcumber.uid.should == "feature_x"
    end
    
    describe "save" do
    
      it "should write the contents to the file" do
        File.should_receive(:open).with(@full_path, 'w')
        @rcumber.save
      end
      
  
    end

    ## TODO: FEATURE: User should be able to disable deleting as a plugin option
    describe "destroy" do
      it "should tell the filesystem to remove the cucumber test file" do
        File.should_receive(:delete).with(@full_path)
        @rcumber.destroy
      end
    end
    
    describe "Rcumber.find" do
      it "should return an Rcumber object if it exists" do
        Rcumber.stub!(:all).and_return([@rcumber])
        Rcumber.all.should_receive(:detect).and_return(@rcumber)
        Rcumber.find(@rcumber.uid).uid.should == @rcumber.uid
      end
    end
  
  end
  
  
end