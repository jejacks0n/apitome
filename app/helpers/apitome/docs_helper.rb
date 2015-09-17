module Apitome::DocsHelper
  def format_scope(scope)
    Array(scope).each_with_index.map do |scope, index|
      if index == 0
        scope
      else
        "[#{scope}]"
      end
    end.join
  end
end
