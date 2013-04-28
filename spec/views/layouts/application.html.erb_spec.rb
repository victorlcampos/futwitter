require 'spec_helper'

describe 'layouts/application.html.erb' do
  helper(ApplicationHelper, TeamsHelper)

  before(:each) do
    flamengo = FactoryGirl.create(:flamengo)
    vasco = FactoryGirl.create(:vasco)

    @teams = assign(:teams, [flamengo, vasco])

    campeonato_carioca = FactoryGirl.create(:campeonato_carioca)
    @championships = assign(:championship, [campeonato_carioca])
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

  it 'should show link to all team with images' do
    render
    assert_select 'div#teams' do
      @teams.each do |team|
        team_class = team_classes(team).gsub(' ', '.')

        assert_select "a.#{team_class}[href='#{team_path(team)}']", count: 1 do
          assert_select "img[src='#{team.badge_url(:thumb)}']"
        end
      end
    end
  end

  it 'should show select to championships' do
    render
    assert_select 'select#championship' do
      @championships.each do |championship|
        assert_select "option[value=#{championship.id}]",
                                              count: 1, text: championship.name
      end
    end
  end

end