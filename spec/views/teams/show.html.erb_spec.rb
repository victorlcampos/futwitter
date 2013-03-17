require 'spec_helper'

describe "teams/show.html.erb" do
  before(:each) do
    @match = FactoryGirl.create(:flamengo_vs_vasco)
    @news = [FactoryGirl.create(:news)]
  end

  it "should show the match score" do
    render
    assert_template partial: "matches/match_score", locals: { match: @match }, count: 1
  end

  it "should show the news" do
    render
    assert_select "div.news" do
      @news.each do |news|
        assert_select "div.news#news_#{news.id}" do
          assert_select "div.image > img[src='#{news.image_url}']"
          assert_select "div.data" do
            assert_select "span.title", text: news.title
            assert_select "a.url[href='#{news.url}']"
            assert_select "span.description", text: news.description
          end
        end
      end
    end
  end
end