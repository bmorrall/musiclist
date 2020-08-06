# frozen_string_literal: true

require "digest/md5"

# Configuration for rack_attack
class Rack::Attack # rubocop:disable Style/ClassAndModuleChildren
  ### Configure Cache ###

  # If you don't want to use Rails.cache (Rack::Attack's default), then
  # configure it here.
  #
  # Note: The store is only used for throttling (not blocklisting and
  # safelisting). It must implement .increment and .write like
  # ActiveSupport::Cache::Store

  # Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  ### Throttle Spammy Clients ###

  # If any single client IP is making tons of requests, then they're
  # probably malicious or a poorly-configured scraper. Either way, they
  # don't deserve to hog all of the app server's CPU. Cut them off!
  #
  # Note: If you're serving assets through rack, those requests may be
  # counted by rack-attack and this throttle may be activated too
  # quickly. If so, enable the condition to exclude them from tracking.

  # Throttle all requests by IP (60rpm)
  #
  # Key: "rack::attack:#{Time.now.to_i/:period}:req/ip:#{req.ip}"
  throttle("req/ip", limit: 300, period: 5.minutes, &:ip)

  def self.pentesting_request?(path, query_string)
    CGI.unescape(query_string) =~ %r{/etc/passwd} ||
      path.include?("/etc/passwd") ||
      path.include?("wp-admin") ||
      path.include?("wp-login") ||
      /\.php$/.match?(path)
  end

  # Block suspicious requests for '/etc/passwd' or wordpress specific paths.
  # After 3 blocked requests in 10 minutes, block all requests from that IP for 5 minutes.
  blocklist("fail2ban/pentesters") do |req|
    # `filter` returns truthy value if request fails, or if it's from a previously banned IP
    # so the request is blocked
    Rack::Attack::Fail2Ban.filter("pentesters-#{req.ip}", maxretry: 3, findtime: 10.minutes, bantime: 5.minutes) do
      # The count for the IP is incremented if the return value is truthy
      pentesting_request?(req.path, req.query_string)
    end
  end

  ### Custom Blocklist Response ###

  self.blocklisted_response = lambda do |request|
    if pentesting_request?(request.fetch("PATH_INFO"), request.fetch("QUERY_STRING"))
      [301, { "Location" => "/" }, []]
    else
      [302, { "Location" => "https://www.youtube.com/watch?v=dQw4w9WgXcQ" }, []]
    end
  end

  ### Custom Throttle Response ###

  # By default, Rack::Attack returns an HTTP 429 for throttled responses,
  # which is just fine.
  #
  # If you want to return 503 so that the attacker might be fooled into
  # believing that they've successfully broken your app (or you just want to
  # customize the response), then uncomment these lines.
  # self.throttled_response = lambda do |env|
  #  [ 503,  # status
  #    {},   # headers
  #    ['']] # body
  # end
end
