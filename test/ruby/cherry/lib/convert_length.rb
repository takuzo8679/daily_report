UNITS = {m: 1.00,ft: 3.28,in: 39.37}

def convert_length(length, from: :m, to: :m) =
  (length / UNITS[from] * UNITS[to]).round(2)

# def convert_length(value, src, dst)
#   (value / TABLE[src] * TABLE[dst]).round(2)
#   # # mに換算
#   # metol = value / TABLE[src] 
#   # # 単位に変換
#   # (metol * TABLE[dst]).round(2)
# end