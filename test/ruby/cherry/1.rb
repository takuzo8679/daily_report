# frozen_string_literal: true

require 'debug'
# femaleのハッシュのみ取得
[
  { name: 'Alice', age: 11, gender: 'female' },
  { name: 'Bob', age: 12, gender: 'male' },
  { name: 'Carol', age: 13, gender: 'female' }
].select do |p|
  p in { gender: 'female' }
end => females

puts females
