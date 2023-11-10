module Rainbowable
  def rainbow
    to_s.chars.map.with_index { |s, i|
      "\e[3#{i%6+1}m#{s}"
  }.push("\e[0m").join
  end
end

