class RegexPattern

  REGEX_LATITUDE = Regexp.new(%r{^(-?(90\.0{4,6})|([0-8]\d{0,1})\.\d{4,6})$})
  REGEX_LONGITUDE = Regexp.new(%r{^(-?((180)\.0{4,6})|((1[0-7][0-9])|([0-9]\d{0,1}))\.\d{4,6})$})

end