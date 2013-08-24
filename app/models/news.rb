class News < ActiveRecord::Base
  default_scope order('time DESC')

  attr_accessible :shorted_url, :team, :retweets, :time, :url, :domain_name,
                  :title, :description, :image_url

  belongs_to :team

  def self.create_by_tweet(tweet, team)
    if url = tweet.urls[0]
      shorted_url = shorted_url(url)
      unshorted_url = unshorted_url(shorted_url)
      unless News.where(url: unshorted_url).first
        create_news(tweet, team, shorted_url, unshorted_url)
      end
    end
  end

  private
  def self.shorted_url(tweeter_url)
    tweeter_url.expanded_url
  end

  def self.unshorted_url(shorted_url)
    my_url = shorted_url
    tmp_url = my_url

    while true
      tmp_url = Unshortme.unshort(tmp_url)
      if my_url == tmp_url
        break
      else
        my_url = tmp_url
      end
    end

    URI.remove_params(my_url, analytics_params)
  end

  def self.analytics_params
    ['utm_term', 'utm_content', 'utm_source', 'utm_medium', 'utm_campaign']
  end

  def self.create_news(tweet, team, shorted_url, unshorted_url)
      params = url_params(shorted_url, unshorted_url).merge({
        team: team,
        retweets: tweet.retweet_count,
        time: tweet.created_at
      }).merge(SummaryUrl.fetch(unshorted_url))

      News.create!(params)
    begin

    rescue
    end
  end

  def self.url_params(shorted_url, unshorted_url)
    domain_name = URI.parse(unshorted_url).host
    {
      url: unshorted_url,
      shorted_url: shorted_url,
      domain_name: domain_name
    }
  end
end
