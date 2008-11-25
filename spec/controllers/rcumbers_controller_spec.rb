require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../../ui/controllers/rcumbers_controller')

describe RcumbersController do

  describe 'index' do
    
    it 'should render the index view' do
      get :index
      response.should render_template(:index)
    end
    
    it 'build the list of cucumber tests' do
      tests = Dir.glob(RAILS_ROOT + '/features/**/*.feature')
      Rcumber.should_receive(:all).and_return(tests)
      get :index
      assigns[:rcumbers].should == tests
    end
    
  end

  describe 'an existing rcumber object responding to ' do
    
    before(:each) do
      @mock_rcumber = mock Rcumber
      Rcumber.should_receive(:find).with("name").and_return(@mock_rcumber)
    end

    describe 'show' do  
      it "should render the show template" do
        get :show, :id => "name"
        response.should render_template(:show)
      end
    end
  
    describe 'update' do
    
      it "should save the new contents of the file" do
        @mock_rcumber.should_receive(:raw_content=).with("some raw content")
        @mock_rcumber.should_receive(:save).and_return(true)
        put :update, :id => "name", :rcumber => {:raw_content => "some raw content"}
        flash.now[:notice].should_not be_nil
        response.should render_template(:show)
      
      end

      it "should reject a save with no content" do
        put :update, :id => "name", :rcumber => {:raw_content => ""}
        response.should render_template(:edit)
        flash.now[:error].should_not be_nil
      end
    
    end
  
    describe 'edit' do
      it 'should render a form with the object in it' do
        put :edit, :id => "name"
        assigns[:rcumber].should == @mock_rcumber
        response.should render_template(:edit)
      end
    end
  
    describe 'destroy' do
     it 'should remove the file from the file system' do
       @mock_rcumber.should_receive(:destroy)
       put :destroy, :id => "name"
       response.should render_template(:index)
     end
   end

  end
  
  describe 'new' do
    it "should render a form asking for the filename (w/o) the .feature extension" do
      get :new
      response.should render_template(:new)
    end
  end
  
end
