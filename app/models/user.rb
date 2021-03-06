# frozen_string_literal: true

# PORO Representaiton of an Authenticated Auth0 User
class User
  EMAIL_REGEX = /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i.freeze

  def initialize(userinfo = nil)
    @userinfo = userinfo.presence || {}
  end

  def id
    if auth0?
      @userinfo["uid"]
    elsif @userinfo["uid"].present?
      "#{@userinfo['provider']}|#{@userinfo['uid']}"
    end
  end

  def image
    @userinfo.dig("info", "image")
  end

  def name
    name_or_email = @userinfo.dig("info", "name")
    if name_or_email =~ EMAIL_REGEX
      nickname
    else
      name_or_email
    end
  end

  def nickname
    @userinfo.dig("info", "nickname")
  end

  def first_name
    namae.given
  end

  def admin?
    roles.include? "admin"
  end

  def persisted?
    @userinfo.present?
  end

  def to_h
    @userinfo.to_h
  end

  def to_s
    name
  end

  def ==(other)
    if other.nil? || !other.instance_of?(User)
      false
    else
      to_h == other.to_h
    end
  end
  alias eql? ==

  def hash
    @userinfo.hash
  end

  private

  def auth0?
    @userinfo["provider"] == "auth0"
  end

  def namae
    @namae ||= Namae::Name.parse(name)
  end

  def roles
    @roles ||= (@userinfo.dig("extra", "raw_info", "http://musiclist/roles") || [])
  end
end
