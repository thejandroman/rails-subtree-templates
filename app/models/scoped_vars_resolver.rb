require 'yaml'

#
# This class recursively crawls the content path
# starting the the current template paths folder and
# traversing each parent folder. Along the way it collects
# the configs specified in each folder and applies then to the
# vars instance variable, then recursively
# calls itself with the parent folders path creating a
# tree of scoped var resolvers along the way by loading
# the config.yml file from the current folder.
#
# Method missing is used to recursively call the parent objects
# looking for a var attribute containing the desired variable
# until the request variable is found on the tree or we hit the bottom
# of the tree.
#
class ScopedVarsResolver
  attr_accessor :vars, :parent, :hash, :current_path,
    :request, :paths, :child

  def initialize(request, paths, current_path)
    @request = request
    @paths = paths
    @current_path = current_path
    @child = false
    get_current_scope
    get_parent_scope
  end

  private

  def method_missing(method_name, include_private = false)
    if @vars.has_key?(method_name.to_s)
      @vars[method_name.to_s]
    elsif parent
      parent.send(method_name)
    else
      super
    end
  end

  def get_current_scope
    @vars = YAML.load_file(File.join(current_path, 'configs.yml'))
    puts @vars
  end

  def get_parent_scope
    return unless parent?

    puts 'recurse'
    @parent = ScopedVarsResolver.new(request, paths, parent_path)
  end

  def parent?
    !File.identical?(parent_path, @paths.content_root)
  end

  def parent_path
    File.join(current_path, '..')
  end
end
