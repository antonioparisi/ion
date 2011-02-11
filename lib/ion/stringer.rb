module Ion::Stringer
  def self.sanitize(str)
    return ''  unless str.is_a?(String)
    str.downcase.force_encoding('UTF-8')
  end

  # "Hey,  yes you." => %w(hey yes you)
  def self.keywords(str)
    return Array.new  unless str.is_a?(String)
    self.sanitize(str).scan(/\w+/)
  end

  def self.classify(name)
    str = name.to_s
    str.scan(/\b(\w)(\w*)/).map { |(w, ord)| w.upcase + ord.downcase }.join('')
  end
end
