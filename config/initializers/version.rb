# Load version from the file that semantic-release updates
require Rails.root.join("config", "version")

# Define the application version module
module Domus
  VERSION = ::VERSION
end
