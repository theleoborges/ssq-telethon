class Symbol
  def <=>(other)
    self.to_s <=> other.to_s
  end
end