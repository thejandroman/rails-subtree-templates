require 'yaml'

class ScopedVarsResolver
  attr_accessor :vars, :parent, :hash, :current_path,
    :request, :paths

  def initialize(request, paths, current_path)
    @request = request
    @paths = paths
    @current_path = current_path
    get_current_scope
    get_parent_scope
  end

  private

  def get_current_scope
    @vars = YAML.load_file(File.join(current_path, 'configs.yml'))
  end

  def get_parent_scope
    return unless parent?

    puts 'recurse'
    @parent = ScopedVarsResolver.new(request, paths, parent_path)
  end

  def parent?
    puts 'parent path'
    puts parent_path
    puts 'root'
    puts @paths.content_root
    puts parent_path.match? @paths.content_root
    parent_path.match? @paths.content_root
  end

  def parent_path
    File.join(current_path, '..')
  end
end
