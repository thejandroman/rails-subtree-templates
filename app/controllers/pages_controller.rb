class PagesController < ActionController::Base
  include ActionController::Rendering
  include AbstractController::Helpers

  @@resolver = SubtreeResolver.new

  helper PagesHelper
  prepend_view_path @@resolver

  def index
    @var1 = 'hello'
    @@resolver.request = request
    render template: params[:page]
  end
end
