class Apitome::DocsController < ActionController::Base

  layout Apitome.configuration.layout

  helper_method :resources, :example, :formatted_body, :param_headers, :param_extras, :formatted_readme, :set_example, :id_for

  def index
  end

  def show
  end

  private

  def file_for(file)
    file = Apitome.configuration.root.join(Apitome.configuration.doc_path, file)
    raise Apitome::FileNotFound.new, "Unable to find #{file}" unless File.exists?(file)
    File.read(file)
  end

  def resources
    @resources ||= JSON.parse(file_for('index.json'))['resources']
  end

  def example
    @example ||= JSON.parse(file_for("#{params[:path]}.json"))
  end

  def set_example(resource)
    @example = JSON.parse(file_for("#{resource}.json"))
  end

  def formatted_readme
    file = Apitome.configuration.root.join(Apitome.configuration.doc_path, Apitome.configuration.readme)
    Kramdown::Document.new(file_for(file)).to_html
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
  end

  def param_extras(params)
    extras = []
    for param in params
      extras += param.reject{ |k,v| %w{name description required scope}.include?(k) }.keys
    end
    extras.uniq
  end

  def id_for(str)
    str.gsub(/\.json$/, '').underscore.gsub(/[^0-9a-z]+/i, '-')
  end

end
