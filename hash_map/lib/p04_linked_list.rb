class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    @sentinel_head = Node.new
    @sentinel_tail = Node.new

    @sentinel_head.next = @sentinel_tail
    @sentinel_tail.prev = @sentinel_head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @sentinel_head.next
  end

  def last
    @sentinel_tail.prev
  end

  def empty?
    @sentinel_head.next == @sentinel_tail
  end

  def get(key)
    return nil unless include?(key)
    find(key).val
  end

  def include?(key)
    each { |node| return true if node.key == key }

    false
  end

  def append(key, val)
    update(key, val)

    new_node = Node.new(key, val)
    new_node.prev = last
    last.next = new_node
    new_node.next = @sentinel_tail
    @sentinel_tail.prev = new_node
  end

  def update(key, val)
    if include?(key)
      node = find(key)
      node.val = val
    end
  end

  def remove(key)
    if include?(key)
      current_node = find(key)
      prev_node = current_node.prev
      next_node = current_node.next

      prev_node.next = next_node
      next_node.prev = prev_node
    end
  end

  def each
    i = first

    until i == @sentinel_tail
      yield(i)
      i = i.next
    end

    self
  end

  private

  def find(key)
    select { |node| node.key == key }.first
  end
  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
