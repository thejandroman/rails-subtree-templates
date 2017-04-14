class SubtreeResolver < ActionView::Resolver
  def find_templates(name, prefix, partial, details, outside_app_allowed = false)
    puts name
    puts prefix
    puts partial
    puts details
  end
end
