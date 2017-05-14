class PagesController < ActionController::Base
  include ActionController::Rendering
  include AbstractController::Helpers

  @@resolver = SubtreeResolver.new

  helper PagesHelper
  prepend_view_path @@resolver


  def index
    @@resolver.request = request
    render template: params[:page]
  end

  def self.resolver

  end
end
