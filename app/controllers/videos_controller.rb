class VideosController < ApplicationController
  # load_and_authorize_resource

  before_filter :set_categories_and_colors

  def show
    @video = Video.friendly.find(params[:id])
    @og_title = "#{@video.title} - DraperTV"
    @series = @video.series
    @og_description = @series.first_video.description
    
    @og_image = @series.first_video.vthumbnail_url
    @featured = @video.suggested(@series.category_list)[0..5]

    @featured[2] = Chapter.all.sample
    @featured[5] = Chapter.all.sample


    if @video.url
      @video_yt_embed = ActiveSupport::SafeBuffer.new(%Q{<iframe id="ytplayer" type="text/html" width="662" height="494" src="https://www.youtube.com/embed/#{@video.url}?autoplay=1&rel=0&showinfo=0&color=red&theme=dark&modestbranding=1" frameborder="0" allowfullscreen> </iframe>})
    end
    @video.increment_view_count
  end

  private

  def video_params
    params.require(:video).permit(:view_count, :title, :author_id, :speaker, :description, :url, :value,:vthumbnail, :name,:category_list, :demand_array)
  end

    def set_categories_and_colors
      @categories = ["Attitude", "Starting Up", "Product", "Sales", "Marketing", "Fundraising", "Hiring", "Biz & Finance", "Legal", "Auxiliary"]
      @colors = ["blue", "cyan", "teal", "green", "yellow", "orange", "red", "purple", "black", "grey"]
    end
end
