module  Effects

  def self.reverse = -> (words) {
    words.split(' ').map(&:reverse).join(' ')
  }
  def self.echo(rate) = -> (words) {
    words.chars.map{|s| s== ' '? ' ': s * rate}.join
  }
  def self.loud(rate) = -> (words) {
    words.upcase.split(' ').map{|s| s + '!' * rate}.join(' ')
  }

end
