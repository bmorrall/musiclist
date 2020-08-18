module ContentUtils
  extend self

  YEAR_PATTERNS = [
    # is a 1975 album
    /is a (?<year>(19[5-9]|20[0-1])[0-9]) album/,
    # released as a double album in March 1987
    /released as a double album in \b\w+\b (?<year>(19[5-9]|20[0-1])[0-9])\b/,
    # released November 15, 1977 | released on November 30th, 1979
    /released (on )?\b\w+\b ([1-3]?[0-9])(st|nd|th)?, (?<year>(19[5-9]|20[0-1])[0-9])\b/,
    # released on 13 April 1973
    /released (on |in )?([1-3]?[0-9])(st|nd|th)? \b\w+\b (?<year>(19[5-9]|20[0-1])[0-9])\b/,
    # released in 1992 | released in July 1971
    /released in (\b\w+\b (of )?)?(?<year>(19[5-9]|20[0-1])[0-9])\b/,
    # released worldwide October 10, 1966
    /released worldwide \b\w+\b ([1-3]?[0-9])(st|nd|th)?, (?<year>(19[5-9]|20[0-1])[0-9])\b/,
    # released in the United States on October 10, 1966
    /released in the united states on \b\w+\b ([1-3]?[0-9])(st|nd|th)?, (?<year>(19[5-9]|20[0-1])[0-9])\b/,
    # released on Warner Bros. Records on 28 February 1970
    /released (on |by )(\s?[\w\/]+\.?){1,3} (in|on ([1-3]?[0-9])(st|nd|th)?) \b\w+\b (?<year>(19[5-9]|20[0-1])[0-9])\b/,
    # released by Elektra Records on March 3, 1986
    /released (on |by )(\s?[\w\/]+\.?){1,3} on \b\w+\b ([1-3]?[0-9])(st|nd|th)?, (?<year>(19[5-9]|20[0-1])[0-9])\b/,
    # released by Capitol Records in 2012
    /released (on |by )(\s?[\w\/]+\.?){1,3} in (?<year>(19[5-9]|20[0-1])[0-9])\b/
  ].freeze

  def extract_year(content)
    return if content.blank?

    content = content.downcase
    pattern = YEAR_PATTERNS.detect { |pattern| content =~ pattern }
    content.match(pattern)[:year] if pattern
  end
end
