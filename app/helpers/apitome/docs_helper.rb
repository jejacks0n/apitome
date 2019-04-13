module Apitome::DocsHelper
  def format_scope(scopes)
    Array(scopes).each_with_index.map do |scope, index|
      index == 0 ? scope : "[#{scope}]"
    end.join
  end

  def resource_link(resource)
    "#{Apitome.configuration.mount_at}/#{CGI.escape(resource['examples'].first['link'].gsub(/\.json$/, ''))}"
  end

  def example_link(example)
    "#{Apitome.configuration.mount_at}/#{CGI.escape(example['link'].gsub(/\.json$/, ''))}"
  end

  def link_active?(link)
    current_page?(url_for(link))
  end
end
