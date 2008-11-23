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
    
  describe 'show' do
    
    before(:each) do
      @mock_test = mock Rcumber
      Rcumber.should_receive(:find).with("name").and_return(@mock_test)
      get :show, :id => "name"
    end
    
    it "should render the show template" do
      response.should render_template(:show)
    end
  end
  
end
