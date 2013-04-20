require 'spec_helper'

describe 'layouts/application.html.erb' do

  before(:each) do
    flamengo = FactoryGirl.create(:flamengo)
    vasco = FactoryGirl.create(:vasco)

    @teams = assign(:teams, [flamengo, vasco])
  end

  it 'should render the title' do
    render
    assert_select 'title',  text: 'Futwitter | Plataforma social do futebol'
  end

  it 'should render the header' do
    render
    assert_select 'div#header' do
      assert_select 'a[href="/"]' do
        assert_select 'img[src="/assets/logo.png"]'
      end
      assert_select 'h1.title',
                    text: 'Futwitter | Plataforma social do futebol'
    end
  end

  it 'should show link to all team with names' do
    render
    @teams.each do |team|
      assert_select "a[href='#{team_path(team)}']", count: 1 do
        assert_select "img[src='#{team.badge_url(:thumb)}']"
      end
    end
  end

end