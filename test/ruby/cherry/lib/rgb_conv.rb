# def to_hex(r, g, b)
#   # "##{sprintf('%02x', r)}#{sprintf('%02x', g)}#{sprintf('%02x', b)}"
#   # '#'+
#   #   r.to_s(16).rjust(2,'0') +
#   #   g.to_s(16).rjust(2,'0') +
#   #   b.to_s(16).rjust(2,'0')
#   # [r,g,b].map{ |n| n.to_s(16).rjust(2, '0')}.sum('#')
#   [r,g,b].sum('#'){ |n| n.to_s(16).rjust(2,'0')}
# end
def to_hex(r,g,b) = [r,g,b].sum('#'){|n| n.to_s(16).rjust(2,'0')}

def to_ints(hex) = hex.scan(/\w\w/).map(&:hex)
# def to_ints(hex_str)
#   # 最初の文字の#を削除
#   # hex_str.slice!(0)
#   # hex_str.delete!('#')

#   # # 2文字ずつ配列へ代入
#   # hex_ary = hex_str.scan(/.{1,2}/)
#   # # 10進数に変換
#   # hex_ary.map do |n|
#   #   # n.to_i(16)
#   #   n.hex
#   # end
#   hex_str.scan(/\w\w/).map(&:hex)
# end