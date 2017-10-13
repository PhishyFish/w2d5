require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if @count >= num_buckets
    unless include?(key)
      @count += 1
      self[key] << key
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if include?(key)
      @count -= 1
      self[key].delete(key)
    end
  end

  private

  def [](num)
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    flattened_store = @store.flatten
    @count = 0
    @store = Array.new(num_buckets * 2) { Array.new }
    flattened_store.each do |el|
      insert(el)
    end
  end
end
