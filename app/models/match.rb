class Match < ActiveRecord::Base
  LANCENET_URL = 'http://temporeal.lancenet.com.br/'

  has_many :moves

  belongs_to :home_team, class_name: 'Team'
  belongs_to :away_team, class_name: 'Team'
  belongs_to :championship

  delegate :name, to: :championship, prefix: true
  delegate :name, to: :home_team, prefix: true
  delegate :badge_url, to: :home_team, prefix: true
  delegate :name, to: :away_team, prefix: true
  delegate :badge_url, to: :away_team, prefix: true

  attr_accessible :home_team, :away_team, :home_team_score,
                  :away_team_score, :championship

  def self.update_matches_from_internet
    doc = Nokogiri::HTML(open(LANCENET_URL))

    doc.css('#listaJogos tr').each do |match|
      datas = match.css('td')
      home_team, away_team = create_teams(datas)

      championship = create_championship(datas)

      match_data = {
        home_team_score: datas[1].text,
        away_team_score: datas[3].text
      }

      if match = Match.where(home_team_id: home_team,
                             away_team_id: away_team,
                             championship_id: championship).first

        match.update_attributes!(match_data)
      else
        match_data.merge!({
          home_team: home_team,
          away_team: away_team,
          championship: championship
        })

        Match.create!(match_data)
      end
    end
  end

  private
  def self.create_teams(datas)
    home_team_name = datas[0].text
    home_team = Team.find_or_create_by_name(home_team_name.downcase)

    away_team_name = datas[4].text
    away_team = Team.find_or_create_by_name(away_team_name.downcase)
    [home_team, away_team]
  end

  def self.create_championship(datas)
    championship_name = datas[6].text
    Championship.find_or_create_by_name(championship_name.downcase)
  end
end
