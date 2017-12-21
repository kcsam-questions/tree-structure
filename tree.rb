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
    list = []
    as_paths.each_with_index do |full_path, index|
      file_name = as_ordered_list[index]
      depth = full_path.split("/").index(file_name) + 1
      list << [file_name, depth]
    end
    list
  end

  def as_depth_first_paths
    list = []
    as_paths.each_with_index do |full_path, index|
      file_name = as_ordered_list[index]
      depth = full_path.split("/").index(file_name) + 1
      list << [full_path, depth]
    end
    list.sort! { |x,y| y[1] <=> x[1] }
    list.map { |elem| elem[0] }
  end
end
