require 'spec_helper'

describe 'teams/show.html.erb' do
  before(:each) do
    @match = FactoryGirl.create(:flamengo_vs_vasco)

    news_flamengo_1 = FactoryGirl.create(:news_flamengo_1)
    news_flamengo_2 = FactoryGirl.create(:news_flamengo_2)

    @news = [news_flamengo_1, news_flamengo_2]
  end

  it 'should show the match score' do
    render
    assert_template partial: 'matches/match_score',
                    locals: { match: @match }, count: 1
  end

  it 'should show the news' do
    render
    assert_select 'div.main_news' do
      @news.each do |news|
        assert_select "div.news#news_#{news.id}" do
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