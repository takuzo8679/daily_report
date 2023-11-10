class WordSynth
  def initialize
    @effects = []
  end
  def add_effect(effect)
    @effects << effect
  end
  def play(original_words)
    # words = original_words
    # @effects.each do |effect|
    #   words = effect.call(words)
    # end
    # words
    @effects.inject(original_words){ |words, effect|
      words = effect.call(words)
    }
  end

end
