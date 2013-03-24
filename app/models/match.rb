class Match < ActiveRecord::Base
  LANCENET_URL = "http://temporeal.lancenet.com.br/"

  has_many :moves

  belongs_to :home_team, class_name: "Team"
  belongs_to :away_team, class_name: "Team"

  delegate :name, to: :home_team, prefix: true
  delegate :badge_url, to: :home_team, prefix: true
  delegate :name, to: :away_team, prefix: true
  delegate :badge_url, to: :away_team, prefix: true

  attr_accessible :home_team, :away_team, :home_team_score, :away_team_score

  def self.update_matches_from_internet
    doc = Nokogiri::HTML(open(LANCENET_URL))

    doc.css("#listaJogos tr").each do |match|
      datas = match.css("td")
      home_team, away_team = create_teams(datas)

      unless match = Match.where(home_team_id: home_team, away_team_id: away_team).first
        match_data = {
          home_team: home_team,
          away_team: away_team,
          home_team_score: datas[1].text,
          away_team_score: datas[3].text
        }

        match = Match.create!(match_data)
      end

      match
    end
  end

  private
  def self.create_teams(datas)
    home_team_name = datas[0].text
    home_team = Team.create!(name: home_team_name) unless (home_team = Team.where(name: home_team_name.downcase).first)

    away_team_name = datas[4].text
    away_team = Team.create!(name: away_team_name) unless (away_team = Team.where(name: away_team_name.downcase).first)
    [home_team, away_team]
  end
end
