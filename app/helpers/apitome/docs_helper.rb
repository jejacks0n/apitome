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

  def resource_link(resource)
    "#{Apitome.configuration.mount_at}/#{resource['examples'].first['link'].gsub(/\.json$/, '')}"
  end

  def example_link(example)
    "#{Apitome.configuration.mount_at}/#{example['link'].gsub(/\.json$/, '')}"
  end

  def link_active?(link)
    current_page?(url_for(link))
  end
end
