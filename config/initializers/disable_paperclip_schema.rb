if defined?(Paperclip)
  module Paperclip
    module Schema
      def attachment(*); end
    end
  end
end
