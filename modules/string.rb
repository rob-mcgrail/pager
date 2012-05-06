# Helpers added to String

class String
  def self.random
    (0...15).map{65.+(rand(25)).chr}.join.downcase
  end

  def parameterize(delimeter = '-')
    self.gsub(/[^a-z0-9\-_!?]+/i, delimeter).downcase
  end

#  def make_matchable
#    BCrypt::Password.new(self)
#  end
end
