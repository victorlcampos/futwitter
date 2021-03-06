require 'spec_helper'

describe 'teams/show.html.erb' do
  before(:each) do
    @match = FactoryGirl.create(:flamengo_vs_vasco)
    @team = @match.home_team
    @photos = []
    @photos << FactoryGirl.create(:photo, team: @team)
    @photos << FactoryGirl.create(:photo, team: @team)
    @photos << FactoryGirl.create(:photo, team: @team)

    news_flamengo_1 = FactoryGirl.create(:news_flamengo_1)
    news_flamengo_2 = FactoryGirl.create(:news_flamengo_2)

    @news = [news_flamengo_1, news_flamengo_2]
    @trusted_domains = ['glo.bo']
    @matches = []
  end

  it 'should show the team name' do
    render
    assert_select "img[src='#{@team.badge_url}']"
    assert_select ".name", text: @team.name
  end

  it "should show match photos" do
    render
    assert_select 'ul#gallery' do
      @photos.each do |photo|
        src_attribute = "src='#{photo.url}'"
        assert_select "img[#{src_attribute}]"
      end
    end
  end

  it 'should show the news' do
    render
    assert_select 'div.main_news' do
      @news.each do |news|
        domain = news.domain_name
        assert_select "div.news#news_#{news.id}[data-domain='#{domain}']" do
          assert_select "div.image > img[src='#{news.image_url}']"
          assert_select 'div.data' do
            assert_select "a.title[href='#{news.url}']", text: news.title
            assert_select 'span', text: news.url
            assert_select 'span.description', text: news.description
          end
        end
      end
    end
  end
end