require "byebug"

class TreeNode
  attr_accessor :children, :name

  def initialize(tree_structure)
    @tree_structure = tree_structure
    @children = []

    if tree_structure.kind_of?(String)
      @name = tree_structure
    else
      @name = tree_structure.first[0]
      files = [tree_structure.values].flatten.map do |file|
        TreeNode.new(file)
      end
      @children = files
    end
  end

  def as_array
    Array(@name) + @children&.map(&:as_array)
  end

  def as_ordered_list
    (Array(@name) + @children&.map(&:as_array)).flatten
  end

  def as_paths(prefix="")
    if prefix.empty?
      name = @name
    else
      name = prefix + "/" + @name
    end
    Array(name) + @children.map { |child| child.as_paths(name) }.flatten
  end

  def select_files
    # If there are no children, return the name
    # If there are children then iterate
    return @name if @children.empty?
    @children.map { |child| child.select_files }.flatten
  end

  def as_ordered_list_with_depth
  end
end
