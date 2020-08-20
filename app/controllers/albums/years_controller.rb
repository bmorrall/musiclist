module Albums
  class YearsController < ApplicationController
    include PunditErrorHandling

    after_action :verify_authorized
    after_action :verify_policy_scoped

    # GET /albums/years
    def index
      authorize Album
      @years = policy_scope(Album).where.not(year: [nil, ""]).group(:year).count.sort
    end

    # GET /albums/years/1996
    def show
      authorize Album
      @year = params[:id]
      @albums = policy_scope(Album).where(year: @year).order(:year, :title)
      @albums = present(@albums, AlbumDecorator)
    end
  end
end
