##
## This class is designd to wrap around a particular implementation of a cucumber story test.
## It provides a full API to 
##
require 'pathname'
class Rcumber

  attr_accessor :new_filename
  
  ## This class is used to hold the resulting log of a test run
  ## and eventually provide an api around the results of a test run.
  ## for now, I'm just extending an Array
  class RcumberResults < Array
  end
      
  attr_accessor :path, :filename, :raw_content, :name, :preamble, :last_results
  
  # For now, the UID is the basename w/o extension of the file:  e.g. "../foo.feature" has uid =>"foo"
  # TODO: FIXME: This has the limitation that you need unique cucumber filenames down the entire directory tree...
  attr_reader :uid 

  PATH_PREFIX = RAILS_ROOT + "/features/"
  FEATURE_SUFFIX = ".feature"

  def initialize(path=nil)
    load_from_path(path) unless path.nil?
  end

  ## Use this to 
  def self.create_with_relative_path(path)
    Rcumber.new("#{RAILS_ROOT}/features/#{path}.feature")
  end
  
  def to_s
    uid
  end
  
  def run
    self.last_results = RcumberResults.new(`cucumber #{@path}`.to_a)
  end

  def save
   File.open(@path, 'w') {|f| f.write(@raw_content) }
  end
  
  def destroy
    File.delete(@path)
  end
  
  ## Might as well make a few available from rcumber if you don't have any cucumber story tests in the project
  def self.demos
    Dir.glob("#{RAILS_ROOT}/vendor/plugins/rcumber/features/**/*#{FEATURE_SUFFIX}").collect { |x| new(x) }
  end
  
  def self.find_demo(the_uid)
    return demos.first
    x = demos.detect {|x| x.uid == the_uid }
    raise "Could not detect cucumber with uid: #{the_uid} in #{demos.inspect}"
  end
  
  def self.all
    Dir.glob("#{PATH_PREFIX}**/*#{FEATURE_SUFFIX}").collect { |x| new(x) }
  end
  
  def self.find(the_id)
    all.detect {|x| x.uid == the_id }
  end

  
  private
  
    def load_from_path(path)
      @path = path
      @uid = File.basename(@path, FEATURE_SUFFIX)
      @raw_content = File.exist?(path) ? File.read(path) : ''
      @preamble = []
      
      next_field = 'name'
      @raw_content.each do |line|
        
        case next_field
        
          when 'name' 
            if @name = (line =~ /Feature: (.*)/ ? $1 : nil)
              next_field = 'preamble'
              break
            end
            
          when 'preamble'
            if line =~ /Scenario:(.*)/
              # next_field = 'scenarios'
              # break
            else
              puts "adding #{line}"
              @preamble << line
            end
            
          else
            raise "unknown next_field #{next_field}"

            
        end
        
      end
    end
    
    def get_feature_name(content)
      content =~ /Feature: (.*)/ ? $1 : nil
    end

    
end
