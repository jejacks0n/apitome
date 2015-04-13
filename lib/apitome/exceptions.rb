module Apitome
  class Error < StandardError
  end

  class FileNotFoundError < Apitome::Error
  end
end
