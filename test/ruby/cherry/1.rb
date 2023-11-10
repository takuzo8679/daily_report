require 'debug'
[
  {name: 'Alice', age: 11, gender: 'female'},
  {name: 'Bob',   age: 12, gender: 'male'},
  {name: 'Carol', age: 13, gender: 'female'},
].select{|p| p in {gender: 'afemale'}
  } => females # femaleのハッシュのみ取得
  binding.break
puts females