# frozen_string_literal: true

# Custom Audit model provided by rockstart
class Audit < Audited::Audit
  # Anonymize IP Addresses
  def remote_address=(unsafe_address)
    addr = unsafe_address.presence && IPAddr.new(unsafe_address)
    if addr&.ipv4?
      # set last octet to 0
      super addr.mask(24).to_s
    elsif addr&.ipv6?
      # set last 80 bits to zeros
      super addr.mask(48).to_s
    else
      super nil
    end
  end

  def user=(user)
    if user.is_a?(::User)
      # Handle PORO User Object for Auth0
      self.user_uid = user.id
      super nil
    else
      self.user_uid = nil
      super
    end
  end

  def user
    super || user_uid
  end
end
