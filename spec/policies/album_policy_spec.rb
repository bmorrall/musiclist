# frozen_string_literal: true

require "rails_helper"

RSpec.describe AlbumPolicy, type: :policy do
  subject { described_class.new(user, album_record) }

  let(:resolved_scope) { described_class::Scope.new(user, Album.all).resolve }

  let(:album_record) { Album.new }

  context "with a guest" do
    let(:user) { nil }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_actions(%i[new create]) }
    it { is_expected.to forbid_actions(%i[edit update]) }
    it { is_expected.to forbid_action(:destroy) }

    it { is_expected.to forbid_action(:refresh) }

    it "returns all items in scope" do
      expect(resolved_scope.to_sql).to eq(Album.all.to_sql)
    end
  end

  context "with a user" do
    let(:user) { build_stubbed(:user) }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_actions(%i[new create]) }
    it { is_expected.to forbid_actions(%i[edit update]) }
    it { is_expected.to forbid_action(:destroy) }

    it { is_expected.to forbid_action(:refresh) }

    it "returns all items in scope" do
      expect(resolved_scope.to_sql).to eq(Album.all.to_sql)
    end
  end

  context "with an admin" do
    let(:user) { build_stubbed(:user, :admin) }

    it { is_expected.to permit_action(:index) }
    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_actions(%i[new create]) }
    it { is_expected.to permit_actions(%i[edit update]) }
    it { is_expected.to forbid_action(:destroy) }

    it { is_expected.to permit_action(:refresh) }

    # it { is_expected.to permit_mass_assignment_of(:name).for_action(:create) }

    it { is_expected.to permit_mass_assignment_of(:title).for_action(:update) }
    it { is_expected.to permit_mass_assignment_of(:year).for_action(:update) }
    it { is_expected.to permit_mass_assignment_of(:description).for_action(:update) }

    # it { is_expected.to forbid_mass_assignment_of(:birthdate).for_action(:update) }

    it "returns all items in scope" do
      expect(resolved_scope.to_sql).to eq(Album.all.to_sql)
    end
  end
end
