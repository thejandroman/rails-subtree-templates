require 'yaml'

class PathResolver
  attr_accessor :content_path, :layout_path, :domain

  def initialize(request)
    @domain = request.domain
    @request = request
    get_content_path
    get_layout_path
  end

  def content_root
    File
      .expand_path("../../../content/", __FILE__)
  end

  def last_folder
    path = @request.params["page"].split('/')
    File.join(content_path, path[0..-2])
  end

  private

  def get_content_path
    uri = configs["domains"][@domain]["content_repo"]
    folder = URI(uri).path.split('/').last

    @content_path = File.join(content_root, folder)
  end

  def get_layout_path
    uri = configs["domains"][@domain]["layout_repo"]
    repo = URI(uri).path.split('/').last

    @layout_path = "#{@domain}/#{repo}/application.html.erb"
  end

  def configs
    @configs ||= YAML.load_file("domains.yml")
  end
end
