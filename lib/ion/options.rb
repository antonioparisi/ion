class Ion::Options
  attr_reader :model

  def initialize(model)
    @model = model
    @indices = Hash.new { |h, k| h[k] = Hash.new }
  end

  def search(&blk)
    Ion::Search.new(self, &blk)
  end

  def key
    @key ||= Ion.key[model.name]  #=> 'Ion:Person'
  end

  # Returns a certain index.
  # @example
  #   @options.index(:text, :title) #=> <#Ion::Indices::Text>
  def index(type, name)
    @indices[type][name]
  end

  # Returns all indices.
  def indices
    @indices.values.map(&:values).flatten
  end

  def index_types
    indices.map(&:class).uniq
  end

protected
  # Creates the shortcuts `text :foo` => `field :text, :foo`
  Ion::Indices.names.each do |type|
    define_method(type) do |id, options={}, &blk|
      field type, id, options, &blk
    end
  end

  def field(type, id, options={}, &blk)
    index_type = Ion::Indices.get(type)
    @indices[type][id.to_sym] = index_type.new(id, self, options, &blk)
  end
end

