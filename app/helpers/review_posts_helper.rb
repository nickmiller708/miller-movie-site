module ReviewPostsHelper
  def convert_watch_url(relevant_url)
    YouTubeAddy.youtube_embed_url(relevant_url, '100%', '5%')
  end 
end
