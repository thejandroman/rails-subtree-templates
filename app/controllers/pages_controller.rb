<<<<<<< HEAD
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

=======
class PagesController < ApplicationController
  prepend_view_path SubtreeResolver.new

  def index
    render template: params[:page]
>>>>>>> 89c7499... customer template resolver
  end
end
