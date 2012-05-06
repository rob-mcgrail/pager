# Helpers added to String

class String
  def self.random
    (0...8).map{65.+(rand(25)).chr}.join
  end

  def parameterize(delimeter = '-')
    self.gsub(/[^a-z0-9\-_!?]+/i, delimeter).downcase
  end

  def encrypt
    BCrypt::Password.create(self)
  end

  def make_matchable
    BCrypt::Password.new(self)
  end
end
