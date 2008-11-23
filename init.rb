controller_path = File.join(File.dirname(__FILE__), 'ui', 'controllers')
helper_path = File.join(File.dirname(__FILE__), 'ui', 'helpers')
$LOAD_PATH << controller_path
$LOAD_PATH << helper_path

# Rails Edge
if defined? ActiveSupport::Dependencies
  ActiveSupport::Dependencies.load_paths << controller_path
  ActiveSupport::Dependencies.load_paths << helper_path
else
  Dependencies.load_paths << controller_path
  Dependencies.load_paths << helper_path
end    
config.controller_paths << controller_path
