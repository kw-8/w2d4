require "byebug"

# Write a method no_dupes?(arr) that accepts an array as an arg
# and returns an new array containing the elements that were
# not repeated in the array.
def no_dupes?(arr)
    new_hash = Hash.new{|h,k| h[k] = 0}
    arr.each{|el| new_hash[el] += 1}
    new_hash.select{|k,v| v == 1}.keys
end

def no_consecutive_repeats?(arr)
    (0...arr.length-1).none?{|i| arr[i] == arr[i+1]}
end

def char_indices(str)
    hash = Hash.new{|h,k| h[k] = []}
    (0...str.length).each{|i| hash[str[i]] << i}
    hash
end

def longest_streak(str)
    return str if str.length < 2
    len = 1
    char = str[0]
    
    #current values
    c_len = len
    c_char = char
    (1..str.length).each do |i|
        if str[i] == c_char
            c_len += 1
        else
            if c_len >= len
                len = c_len
                char = c_char
            end
            c_char = str[i]
            c_len = 1
        end
    end
    char * len
end

def bi_prime?(num)
    prime?(num / first_factor(num))
end
def first_factor(n)
    (2..n).each{|f| return f if n % f == 0}
end
def prime?(pr)
    return false if pr < 2
    (2...pr).none?{|f| pr % f == 0}
end

def vigenere_cipher(message, keys)
    az = "abcdefghijklmnopqrstuvwxyz"
    (0...message.length).each{|i| message[i] = az[ (az.index(message[i]) + keys[i%keys.length]) % az.length ] }
    message
end

def vowel_rotate(str)
    vowel, index = [], []
    (0...str.length).each do |i|
        if "aeiou".include?(str[i])
            vowel << str[i]
            index << i
        end
    end
    index.each_with_index{|vowel_index, i| str[vowel_index] = vowel[ (i+vowel.length-1)%vowel.length ]}
    str
end

p "NO DUPES"
p no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
p no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
p no_dupes?([true, true, true])            # => []

p "NO CONSECUTIVE REPEATS"
p no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true
p no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
p no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
p no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
p no_consecutive_repeats?(['x'])                              # => true

p "CHAR INDICES"
p char_indices('mississippi')
# => {"m"=>[0], "i"=>[1, 4, 7, 10], "s"=>[2, 3, 5, 6], "p"=>[8, 9]}
p char_indices('classroom')
# => {"c"=>[0], "l"=>[1], "a"=>[2], "s"=>[3, 4], "r"=>[5], "o"=>[6, 7], "m"=>[8]}

p "LONGEST STREAK"
p longest_streak('a')           # => 'a'
p longest_streak('accccbbb')    # => 'cccc'
p longest_streak('aaaxyyyyyzz') # => 'yyyyy
p longest_streak('aaabbb')      # => 'bbb'
p longest_streak('abc')         # => 'c'

p "BI PRIME?"
p bi_prime?(14)   # => true
p bi_prime?(22)   # => true
p bi_prime?(25)   # => true
p bi_prime?(94)   # => true
p bi_prime?(24)   # => false
p bi_prime?(64)   # => false

p "VIGNERE CIPHER"
p vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
p vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
p vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
p vigenere_cipher("zebra", [3, 0])            # => "ceerd"
p vigenere_cipher("yawn", [5, 1])             # => "dbbo"

p "VOWEL ROTATE"
p vowel_rotate('computer')      # => "cempotur"
p vowel_rotate('oranges')       # => "erongas"
p vowel_rotate('headphones')    # => "heedphanos"
p vowel_rotate('bootcamp')      # => "baotcomp"
p vowel_rotate('awesome')       # => "ewasemo"

class String
    def select(&prc)
        prc ||= Proc.new{|c| false}
        passed = ""
        self.each_char{|c| passed+=c if prc.call(c)}
        passed
    end

    def map!(&prc)
        (0...self.length).each{|i| self[i] = prc.call(self[i], i)}
        self
    end
end

puts "STRING #SELECT, #MAP"
puts "app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
puts "HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
puts "HELLOworld".select          # => ""

word_1 = "Lovelace"
word_1.map! do |ch| 
    if ch == 'e'
        '3'
    elsif ch == 'a'
        '4'
    else
        ch
    end
end
p word_1        # => "Lov3l4c3"

word_2 = "Dijkstra"
word_2.map! do |ch, i|
    if i.even?
        ch.upcase
    else
        ch.downcase
    end
end
p word_2        # => "DiJkStRa"

def multiply(a, b)
    return 0 if b == 0
    return a if b == 1 or b == -1
    return a + multiply(a, b-1) if b > 1
    return a + multiply(a, b+1) if b < 1
end

def lucas_sequence(length)
    return [] if length == 0
    return [2] if length == 1
    return [2, 1] if length == 2
    return lucas_sequence(length-1) + [lucas_sequence(length-1)[-2..-1].sum]
end

def prime_factorization(num)
    primes = []
    factor = 2

    while num != 1
        if num % factor == 0 && prime?(factor)
            num = num / factor
            primes << factor
        else factor += 1
        end
    end
    primes
end

p multiply(3, 5)        # => 15
p multiply(5, 3)        # => 15
p multiply(2, 4)        # => 8
p multiply(0, 10)       # => 0
p multiply(-3, -6)      # => 18
p multiply(3, -6)       # => -18
p multiply(-3, 6)       # => -18

p lucas_sequence(0)   # => []
p lucas_sequence(1)   # => [2]    
p lucas_sequence(2)   # => [2, 1]
p lucas_sequence(3)   # => [2, 1, 3]
p lucas_sequence(6)   # => [2, 1, 3, 4, 7, 11]
p lucas_sequence(8)   # => [2, 1, 3, 4, 7, 11, 18, 29]

p prime_factorization(12)     # => [2, 2, 3]
p prime_factorization(24)     # => [2, 2, 2, 3]
p prime_factorization(25)     # => [5, 5]
p prime_factorization(60)     # => [2, 2, 3, 5]
p prime_factorization(7)      # => [7]
p prime_factorization(11)     # => [11]
p prime_factorization(2017)   # => [2017]