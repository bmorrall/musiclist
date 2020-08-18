# frozen_string_literal: true

# Common Helpers for slug generation
module SlugHelper
  def self.filter_slug(slug)
    return unless slug.present?

    slug.gsub("&", "and")
        .gsub("'", "")
        .gsub(".", "")
        .gsub("/", "")
  end
end
