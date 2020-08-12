# frozen_string_literal: true

module Artists
  class RefreshesController < ::ApplicationController
    include PunditErrorHandling

    before_action :authenticate_user!
    before_action :assign_artist
    before_action :authorize_refresh!
    after_action :verify_policy_scoped

    def create
      info = ArtistLookup.get_info(@artist.name)
      @artist.update!(
        name: info.name,
        profile_image: info.image.default,
        lastfm_url: info.url,
        description: info.bio.content
      )
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
      @artist = policy_scope(Artist).find(params[:artist_id])
    end
  end
end
