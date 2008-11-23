
class RcumbersController < ApplicationController

  layout 'rcumbers'
  
  def index
    @rcumbers = Rcumber.all
  end
  
  def show
    @test = Rcumber.find(params[:id])
  end
  
  def run
    @test = Rcumber.find(params[:rcumber_id])
    @test.run
    render :action => 'show'
  end
  
  def update
    @test = Rcumber.find(params[:id])
    @test.raw_content = params[:raw_content]
    @test.save
  end
  
  
  
  
  
  # don't want to include any filters inside the application chain - might create errors
  if respond_to? :filter_chain
    filters = filter_chain.collect do |f|
      if f.respond_to? :filter
        # rails 2.0
        f.filter
      elsif f.respond_to? :method
        # rails 2.1
        f.method
      else
        fail "Unknown filter class."
      end
    end
    skip_filter filters
  end
  
  view_path = File.join(File.dirname(__FILE__), '..', 'views')
  if public_methods.include? 'append_view_path' # rails 2.1+
    self.append_view_path view_path
  elsif public_methods.include? "view_paths"   # rails 2.0+
    self.view_paths << view_path
  else                                      # rails <2.0
    self.template_root = view_path
  end


end
