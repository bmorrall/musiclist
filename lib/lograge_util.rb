# frozen_string_literal: true

# Utility functions used with Lograge generated by rockstart:security:lograge
module LogrageUtil
  class << self
    # format a throttle.rack_attack message from rack:attack
    def format_rack_attack_throttle(name, start, finish, request_id, payload)
      format_rack_attack_event(name, start, finish, request_id, payload, status: 429)
    end

    # format a blocklist.rack_attack message from rack:attack
    def format_rack_attack_blocklist(name, start, finish, request_id, payload)
      format_rack_attack_event(name, start, finish, request_id, payload, status: 403)
    end

    # rubocop:disable Metrics/AbcSize, Metrics/ParameterLists
    def format_rack_attack_event(name, start, finish, request_id, payload, status:)
      req = payload[:request]
      matched_rule = req.env["rack.attack.matched"]

      filter_parameters = Rails.application.config.filter_parameters
      params = ActiveSupport::ParameterFilter.new(filter_parameters).filter(req.params)
      remote_ip = IpAnonymizer.mask_ip(req.ip) if req.ip.present?

      message_payload = {
        method: req.request_method,
        path: req.path,
        format: params[:format] || "html",
        controller: Rack::Attack.name,
        action: "#{name}[#{matched_rule}]",
        status: status,
        duration: (finish - start).to_f.round(2),
        params: params.except("controller", "action", "format", "id"),
        host: req.host,
        remote_ip: remote_ip,
        request_id: request_id
      }
      Lograge.lograge_config.formatter.call(message_payload)
    end
    # rubocop:enable Metrics/AbcSize, Metrics/ParameterLists
  end
end
