require "byebug"

# Write a method, all_vowel_pairs, that takes in an array of words and returns all pairs of words
# that contain every vowel. Vowels are the letters a, e, i, o, u. A pair should have its two words
# in the same order as the original array. 
#
# Example:
#
# all_vowel_pairs(["goat", "action", "tear", "impromptu", "tired", "europe"])   # => ["action europe", "tear impromptu"]
def all_vowel_pairs(words)
    w_vow = []
    words.map{|word| w_vow << word.split("").select{|ch| "aeiou".include?(ch)} }
    
    res = []
    (0...words.length).each do |i|
        (i+1...words.length).each do |j|
            combo = w_vow[i] + w_vow[j]
            res << words[i] +" "+ words[j] if "aeiou".split("").all?{|v| combo.include?(v)}
            # could just do same without map; no need to select vowels bc all? covers it
        end
    end
    res
end


# Write a method, composite?, that takes in a number and returns a boolean indicating if the number
# has factors besides 1 and itself
#
# Example:
#
# composite?(9)     # => true
# composite?(13)    # => false
def composite?(num)
    return false if num <= 2
    (2...num).any?{|f| num % f == 0}
end


# A bigram is a string containing two letters.
# Write a method, find_bigrams, that takes in a string and an array of bigrams.
# The method should return an array containing all bigrams found in the string.
# The found bigrams should be returned in the the order they appear in the original array.
#
# Examples:
#
# find_bigrams("the theater is empty", ["cy", "em", "ty", "ea", "oo"])  # => ["em", "ty", "ea"]
# find_bigrams("to the moon and back", ["ck", "oo", "ha", "at"])        # => ["ck", "oo"]
def find_bigrams(str, bigrams)
    found = (0...str.length-1).inject([]) {|acc, i| bigrams.include?(str[i..i+1]) ? acc + [str[i..i+1]] : acc + []}
    bigrams.select{|b| found.include?(b)}
end

class Hash
    # Write a method, Hash#my_select, that takes in an optional proc argument
    # The method should return a new hash containing the key-value pairs that return
    # true when passed into the proc.
    # If no proc is given, then return a new hash containing the pairs where the key is equal to the value.
    #
    # Examples:
    #
    # hash_1 = {x: 7, y: 1, z: 8}
    # hash_1.my_select { |k, v| v.odd? }          # => {x: 7, y: 1}
    #
    # hash_2 = {4=>4, 10=>11, 12=>3, 5=>6, 7=>8}
    # hash_2.my_select { |k, v| k + 1 == v }      # => {10=>11, 5=>6, 7=>8})
    # hash_2.my_select                            # => {4=>4}
    def my_select(&prc)
        return self.select{|k,v| k == v} if prc == nil
        # prc ||= Proc.new{|a,b| a == b}
        self.select{|k,v| prc.call(k,v)}
    end
end

class String
    # Write a method, String#substrings, that takes in a optional length argument
    # The method should return an array of the substrings that have the given length.
    # If no length is given, return all substrings.
    #
    # Examples:
    #
    # "cats".substrings     # => ["c", "ca", "cat", "cats", "a", "at", "ats", "t", "ts", "s"]
    # "cats".substrings(2)  # => ["ca", "at", "ts"]
    def substrings(length = nil)
        subs = []
        (0...self.length).each{|i| (i...self.length).each{|j| subs << self[i..j]} }
        return subs if length == nil
        subs.select{|slice| slice.length == length}
    end


    # Write a method, String#caesar_cipher, that takes in an a number.
    # The method should return a new string where each char of the original string is shifted
    # the given number of times in the alphabet.
    #
    # Examples:
    #
    # "apple".caesar_cipher(1)    #=> "bqqmf"
    # "bootcamp".caesar_cipher(2) #=> "dqqvecor"
    # "zebra".caesar_cipher(4)    #=> "difve"
    def caesar_cipher(num)
        az = "abcdefghijklmnopqrstuvwxyz"
        self.split("").map!{|ch| az[ (az.index(ch)+num) % az.length ]}.join("")
        # self      map!        char = az [ new index = old index + shift + % ]
    end
end
