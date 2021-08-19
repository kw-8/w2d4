require "byebug"

# Write a method, least_common_multiple, that takes in two numbers and returns the smallest number that is a mutiple
# of both of the given numbers
def least_common_multiple(num_1, num_2)
    return [num_1, num_2].max if num_1 % num_2 == 0 || num_2 % num_1 == 0
    m = num_1
    while true
        return m if m % num_1 == 0 && m % num_2 == 0
        m += num_1
    end
end


# Write a method, most_frequent_bigram, that takes in a string and returns the two adjacent letters that appear the
# most in the string.
def most_frequent_bigram(str)
    bigrams = Hash.new{|h,k| h[k] = 0}
    (0...str.length-1).each{|i| bigrams[ str[i..i+1] ] += 1}
    max = bigrams.first[0] # Hash#first returns first key value pair in an array
    bigrams.each {|key,val| max = key if val > bigrams[max]}
    max
end


class Hash
    # Write a method, Hash#inverse, that returns a new hash where the key-value pairs are swapped
    def inverse
        inv = {}
        self.each{|k,v| inv[v] = k}
        inv
    end
end


class Array
    # Write a method, Array#pair_sum_count, that takes in a target number returns the number of pairs of elements that sum to the given target
    def pair_sum_count(num)
        count = 0
        len = self.length
        (0...len-1).each{|i| (i+1...len).each{|j| count += 1 if self[i] + self[j] == num} }
        count
    end

    # Write a method, Array#bubble_sort, that takes in an optional proc argument.
    # When given a proc, the method should sort the array according to the proc.
    # When no proc is given, the method should sort the array in increasing order.
    #
    # Sorting algorithms like bubble_sort, commonly accept a block. That block accepts
    # two parameters, which represents the two elements in the array being compared.
    # If the block returns 1, it means that the second element passed to the block
    # should go before the first (i.e. switch the elements). If the block returns -1,
    # it means the first element passed to the block should go before the second
    # (i.e. do not switch them). If the block returns 0 it implies that
    # it does not matter which element goes first (i.e. do nothing).
    #
    # This should remind you of the spaceship operator! Convenient :)
    def bubble_sort(&prc)
        prc ||= Proc.new{|a,b| a <=> b }

        sorted = false
        while !sorted
            sorted = true

            (0...self.length - 1).each do |i|
                # debugger
                if prc.call(self[i], self[i + 1]) == 1 # REMEBER: spaceship operator returns a number! only 0 is falsey
                    self[i], self[i + 1] = self[i + 1], self[i]
                    sorted = false
                end
            end
        end

        self
    end
end
