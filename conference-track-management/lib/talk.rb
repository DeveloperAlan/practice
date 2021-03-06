# Talk
class Talk
  attr_reader :description
  attr_reader :length

  LIGHTNING_TALK = 5

  def initialize(talk)
    words = talk.split

    if words.last == 'lightning'
      @length = LIGHTNING_TALK
    elsif /(\d+)min/.match(words.last)
      @length = words.last.gsub('min', '').to_i
    else
      fail 'incorrect format'
    end

    @description = talk
  end

  def ==(other)
    return true if @length == other.length && @description == other.description

    false
  end

  def <=>(other)
    other.length <=> @length
  end
end
