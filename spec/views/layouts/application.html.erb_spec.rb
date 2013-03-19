require 'spec_helper'

describe "layouts/application.html.erb" do

  before(:each) do
    @teams = assign(:teams, [FactoryGirl.create(:flamengo), FactoryGirl.create(:vasco)])
  end

  it "should render the title" do
    render
    assert_select "title",  text: "Futwitter | Plataforma social do futebol"
  end

  it "should render the header" do
    render
    assert_select "div#header" do
      assert_select 'a[href="/"]' do
        assert_select "img[src='/assets/logo.png']"
      end
      assert_select "h1.title", text: "Futwitter | Plataforma social do futebol"
    end
  end

  it "should show link to all team with names" do
    render
    @teams.each do |team|
      assert_select "a[href='#{team_path(team)}']", text: team.name, count: 1
    end
  end

end