# frozen_string_literal: true

module Rails
  # Returns the currently loaded version of \Rails as a +Gem::Version+.
  def self.gem_version
    Gem::Version.new VERSION::STRING
  end

  module VERSION
    MAJOR = 7
    MINOR = 1
    TINY  = 4
    PRE   = "2"

    STRING = [MAJOR, MINOR, TINY, PRE].compact.join(".")
  end
end