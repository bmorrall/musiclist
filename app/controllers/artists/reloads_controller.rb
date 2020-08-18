# frozen_string_literal: true

module Artists
  class ReloadsController < ::ApplicationController
    include PunditErrorHandling

    before_action :authenticate_user!
    before_action :assign_artist
    before_action :authorize_refresh!
    after_action :verify_policy_scoped

    def create
      info = ArtistLookup.get_info(@artist.name)
      UpdateArtistInfo.call(@artist, info)
      redirect_to @artist, notice: "Artist updated successfully."
    end

    protected

    def authorize_refresh!
      authorize @artist, :refresh?
    end

    def authentication_failed_redirect_path_for(resource)
      artist_url(resource)
    end

    private

    def assign_artist
      @artist = policy_scope(Artist).friendly.find(params[:artist_id])
    end
  end
end
