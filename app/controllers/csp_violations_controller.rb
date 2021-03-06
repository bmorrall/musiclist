# frozen_string_literal: true

# Handle violations from the Content Security Policy
class CspViolationsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    report_base = JSON.parse(request.body.read)
    if report_base.key? "csp-report"
      report = report_base["csp-report"]
      message = build_content_security_message(report)

      log_csp_report_violation(message)
      Rollbar.warning("csp-violation", message) unless ENV["ROLLBAR_ACCESS_TOKEN"].blank?
    end
    head :ok
  end

  private

  def log_csp_report_violation(message)
    # Post message using Lograge format
    Rails.logger.warn message.merge(
      "@timestamp" => ::Time.now.utc,
      type: "csp-report",
      request_id: request.request_id,
      user_agent: request.headers["User-Agent"]
    ).to_json
  end

  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
  def build_content_security_message(report)
    {
      blocked_uri: report["blocked-uri"].try(:downcase),
      disposition: report["disposition"].try(:downcase),
      document_uri: report["document-uri"],
      effective_directive: report["effective-directive"].try(:downcase),
      violated_directive: report["violated-directive"].try(:downcase),
      referrer: report["referrer"].try(:downcase),
      status_code: (report["status-code"].presence || 0).to_i,
      raw_report: report
    }
  end
  # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
end
