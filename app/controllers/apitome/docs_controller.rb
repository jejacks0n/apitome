require "open-uri"

class Apitome::DocsController < Object.const_get(Apitome.configuration.parent_controller)
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
      request["response_headers"].delete("Content-Length")
      request["response_headers"].each { |k, v| headers[k] = v }
      render body: request["response_body"], status: request["response_status"]
    else
      render body: "No simulation for this endpoint", status: 404
    end
  end

  private

    def file_for(file, readme: false)
      if Apitome.configuration.remote_url
        file = readme ? file : "#{Apitome.configuration.doc_path}/#{file}"
        file = CGI.escape("#{Apitome.configuration.remote_url}/#{file}")
      else
        file = Apitome.configuration.root.join(Apitome.configuration.doc_path, file)
        raise Apitome::FileNotFoundError.new("Unable to find #{file}") unless File.exist?(file)
      end

      open(file, file_opts).read
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

    def file_opts
      if Apitome.configuration.remote_url && Apitome.configuration.http_basic_authentication
        { http_basic_authentication: Apitome.configuration.http_basic_authentication }
      else
        {}
      end
    end

    def formatted_readme
      return unless Apitome.configuration.readme
      rendered_markdown(file_for(Apitome.configuration.readme, readme: true))
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
        param.reject { |k, _v| %w{name description required scope}.include?(k) }.keys
      end.flatten.uniq
    end

    def id_for(str)
      Apitome.configuration.url_formatter.call(str)
    end
end
