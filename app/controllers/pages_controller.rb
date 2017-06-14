require 'YAML'

class PagesController < ActionController::Base
  include ActionController::Rendering
  include AbstractController::Helpers

  @@resolver = SubtreeResolver.new

  helper PagesHelper
  prepend_view_path @@resolver


  def index
    # setup the needed path settings for content
    paths = PathResolver.new(request)
    @@resolver.request = request
    @@resolver.paths_object = paths

    # Set local vars
    @vars = ScopedVarsResolver.new(request, paths, paths.last_folder)

    # Setup the git branch tools
    @branches = Branches.new(paths.content_path)
    if params["branches"] && params["branches"]["branch_select"]
      @branches.checkout params["branches"]["branch_select"]
    end

    render template: params[:page], layout: paths.layout_path
  end
end
