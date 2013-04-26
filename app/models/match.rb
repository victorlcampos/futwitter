class Match < ActiveRecord::Base
  LANCENET_URL = 'http://temporeal.lancenet.com.br/'

  has_many :moves

  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'
  belongs_to :championship

  delegate :name, to: :championship, prefix: true
  delegate :name, :badge_url, to: :home_team, prefix: true
  delegate :name, :badge_url, to: :away_team, prefix: true

  attr_accessible :home_team, :away_team, :home_team_score,
                  :away_team_score, :championship

  def self.update_matches_from_internet
    doc = Nokogiri::HTML(open(LANCENET_URL))

    doc.css('#listaJogos tr').each do |match|
      datas = match.css('td')

      parents = {
        home_team:    find_or_create_home_team(datas),
        away_team:    find_or_create_away_team(datas),
        championship: find_or_create_championship(datas)
      }

      match_data = {
        home_team_score: datas[1].text,
        away_team_score: datas[3].text
      }

      update_or_create_match(match_data, parents)
    end
  end

  private
  def self.update_or_create_match(match_data, parents)
    home_team    =    parents[:home_team]
    away_team    =    parents[:away_team]
    championship =    parents[:championship]

    search_data = {
      home_team_id: home_team,
      away_team_id: away_team,
      championship_id: championship
    }

    if match = Match.where(search_data).first
      match.update_attributes!(match_data)
    else
      match_data.merge!(parents)
      Match.create!(match_data)
    end
  end

  def self.find_or_create_home_team(datas)
    home_team_name = datas[0].text
    Team.find_or_create_by_name(home_team_name.downcase)
  end

  def self.find_or_create_away_team(datas)
    away_team_name = datas[4].text
    Team.find_or_create_by_name(away_team_name.downcase)
  end

  def self.find_or_create_championship(datas)
    championship_name = datas[6].text
    Championship.find_or_create_by_name(championship_name.downcase)
  end
end
