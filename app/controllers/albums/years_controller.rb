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
      @previous_year = all_years.first != @year && all_years[all_years.index(@year) - 1]
      @next_year = all_years.last != @year && all_years[all_years.index(@year) + 1]
      @albums = policy_scope(Album).where(year: @year).order(:year, :title)
      @albums = present(@albums, AlbumDecorator)
    end

    private

    def all_years
      @all_years ||= policy_scope(Album).where.not(year: [nil, ""]).pluck(:year).sort
    end
  end
end
