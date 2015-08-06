class Apitome::DocsController < ActionController::Base
  layout Apitome.configuration.layout

  helper_method *[
    :resources,
    :example,
    :formatted_body,
    :param_headers,
    :param_extras,
    :formatted_readme,
    :set_example,
    :id_for,
    :rendered_markdown
  ]

  def index
  end

  def show
  end

  def simulate
    request = example["requests"][0]
    if request
      request["response_headers"].each { |k, v| headers[k] = v }
      render text: request["response_body"], status: request["response_status"]
    else
      render text: "No simulation for this endpoint", status: 404
    end
  end

  private

  def file_for(file)
    file = Apitome.configuration.root.join(Apitome.configuration.doc_path, file)
    raise Apitome::FileNotFoundError.new("Unable to find #{file}") unless File.exists?(file)
    File.read(file)
  end

  def resources
    @resources ||= JSON.parse(file_for("index.json"))["resources"]
  end

  def example
    @example ||= JSON.parse(file_for("#{params[:path]}.json"))
  end

  def set_example(resource)
    @example = JSON.parse(file_for("#{resource}.json"))
  end

  def formatted_readme
    return unless Apitome.configuration.readme
    file = Apitome.configuration.root.join(Apitome.configuration.doc_path, Apitome.configuration.readme)
    rendered_markdown(file_for(file))
  end

  def rendered_markdown(string)
    if defined?(GitHub::Markdown)
      GitHub::Markdown.render(string)
    else
      Kramdown::Document.new(string).to_html
    end
  end

  def formatted_body(body, type)
    if type =~ /json/ && body.present?
      JSON.pretty_generate(JSON.parse(body))
    else
      body
    end
  rescue JSON::ParserError
    return body if body == " "
    raise JSON::ParserError
  end

  def param_headers(params)
    titles = %w{Name Description}
    titles += param_extras(params)
    titles
  end

  def param_extras(params)
    params.map do |param|
      param.reject { |k, _v| %w{name description required scope unique}.include?(k) }.keys
    end.flatten.uniq
  end

  def id_for(str)
    Apitome.configuration.url_formatter.call(str)
  end
end
