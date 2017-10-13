class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = 0
    each_with_index do |el, i|
      result = result ^ (el.hash + i.hash)
    end

    result.hash
  end
end

class String
  def hash
    result = ""
    each_char do |ch|
      if ch.ord / 100 == 0
        result << "9" + ch.ord.to_s
      else
        result << ch.ord.to_s
      end
    end

    result.to_i.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    result = 0
    sorted_arr = self.to_a.sort.flatten
    sorted_arr.each_with_index do |el, i|
      if el.is_a?(Integer)
        result = result ^ (el.hash + i.hash)
      elsif el.is_a?(Symbol) || el.is_a?(String)
        result = result ^ (el.to_s.hash + i.hash)
      end
    end

    result
  end
end

#{}"hello".hash => 996.hash => ____
