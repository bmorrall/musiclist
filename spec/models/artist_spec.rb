require "rails_helper"

RSpec.describe Artist, type: :model do
  it { is_expected.to have_many(:albums) }

  it { is_expected.to have_db_column(:name) }
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to have_db_column(:lastfm_url) }

  it { is_expected.to have_db_column(:profile_image) }

  it { is_expected.to have_db_column(:description) }

  it { is_expected.to have_db_column(:sort_name) }
  it { is_expected.to validate_presence_of(:sort_name) }
end
