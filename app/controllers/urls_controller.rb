class UrlsController < ApplicationController
  before_action :set_url, only: [:show, :stats]

  def create
    service = CreateUrlService.new
    if service.perform(params[:original_url])
      render json: { short_url: service.url.short_url }, status: :ok
    else
      render json: { errors: service.errors }, status: :unprocessable_entity
    end
  end

  def show
    @url.with_lock do
      @url.increment!(:stats)
    end
    render json: { original_url: @url.original_url }, status: :ok
  end

  def stats
    render json: { stats: @url.stats }, status: :ok
  end

  private

  def set_url
    @url = Url.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'not found' }, status: :not_found
  end
end
