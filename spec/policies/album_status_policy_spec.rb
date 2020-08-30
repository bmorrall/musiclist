# frozen_string_literal: true

require "rails_helper"

RSpec.describe AlbumStatusPolicy, type: :policy do
  subject { described_class.new(user, album_record) }

  let(:resolved_scope) { described_class::Scope.new(user, Album.all).resolve }

  let(:album_record) { Album.new }

  context "with a guest" do
    let(:user) { nil }

    it { is_expected.to forbid_action(:index) }
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_actions(%i[new create]) }
    it { is_expected.to forbid_actions(%i[edit update]) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context "with a user" do
    let(:user) { build_stubbed(:user) }

    it { is_expected.to forbid_action(:index) }
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_actions(%i[new create]) }
    it { is_expected.to forbid_actions(%i[edit update]) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context "with an admin" do
    let(:user) { build_stubbed(:user, :admin) }

    it { is_expected.to forbid_action(:index) }
    it { is_expected.to forbid_action(:show) }
    it { is_expected.to forbid_actions(%i[new create]) }
    it { is_expected.to permit_actions(%i[edit update]) }
    it { is_expected.to forbid_action(:destroy) }
  end
end
