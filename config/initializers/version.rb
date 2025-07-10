# Define the application version
module Domus
  VERSION = "0.1.0"
end

# Also define a global VERSION constant for compatibility
VERSION = Domus::VERSION unless defined?(VERSION)
