class Branches
  include ActiveModel::Model

  attr_accessor :branches

  def initialize(path)
    @path = path
    @git = Git.open(path, :log => Logger.new(STDOUT))
    @git.fetch
    @branches = @git.branches.remote
  end

  def branch_names
    branches.collect { |b| b.name }
  end

  def branch_select
    branches.collect { |b| [b.name, b.name] }
  end

  def checkout(br)
    puts "Checkout #{br}"
    puts Dir.entries @path
    @git.checkout(br)
  end
end
