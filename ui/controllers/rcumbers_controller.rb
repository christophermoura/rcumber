require File.expand_path(File.dirname(__FILE__) + '/../helpers/rcumbers_helper')

class RcumbersController < ApplicationController

  before_filter :get_rcumber
  
  layout 'rcumbers'
  include RcumbersHelper
  
  def index
    if params[:demos] == "true"
      @rcumbers = Rcumber.demos
    else
      @rcumbers = Rcumber.all
    end
  end

  def get_rcumber
    id = params[:rcumber_id] ? params[:rcumber_id] : params[:id]
    if params[:demos] == "true"
      @rcumber = Rcumber.find_demo(id)
    else
      @rcumber = Rcumber.find(id)
    end
  end
    
  def show
    get_rcumber
    raise "Could not find cucumber file for #{params[:id]}" if @rcumber.nil?
    render :action => 'show'
  end
  
  def run
    get_rcumber
    @rcumber.run
    flash.now[:notice] = "Cucumber test just completed."
    render :action => 'show'
  end
  
  def edit
    get_rcumber
    raise "Could not find cucumber file for #{params[:id]}" if @rcumber.nil?
  end
  
  def update
    get_rcumber
    if params[:rcumber][:raw_content].empty?
      flash.now[:error] = "Please don't try to pickle an empty cuke!."
      render :action => 'edit'
    else
      @rcumber.raw_content = params[:rcumber][:raw_content]
      @rcumber.save
      flash.now[:notice] = "Cucumber was pickled!"
      render :action => 'show'
    end
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
