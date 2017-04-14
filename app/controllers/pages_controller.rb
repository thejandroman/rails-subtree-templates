class PagesController < ApplicationController
  append_view_path SubtreeResolver.new

  def index

  end
end
