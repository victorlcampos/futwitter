class UpdateMatchService
  LANCENET_URL = 'http://temporeal.lancenet.com.br/'

  def update_matches_from_internet
    doc = Nokogiri::HTML(open(LANCENET_URL))

    doc.css('#listaJogos tr').each do |match|
      datas = match.css('td')
      update_or_create_match(match_data(datas), parents(datas))
    end
  end

  private
  def match_data(datas)
    {
      home_team_score: datas[1].text,
      away_team_score: datas[3].text
    }
  end

  def parents(datas)
    {
      home_team:    find_or_create_home_team(datas),
      away_team:    find_or_create_away_team(datas),
      championship: find_or_create_championship(datas)
    }
  end

  def update_or_create_match(match_data, parents)
    if match = Match.where(search_data(parents)).first
      match.update_attributes!(match_data)
    else
      match_data.merge!(parents)
      Match.create!(match_data)
    end
  end

  def search_data(parents)
    {
      home_team_id: parents[:home_team],
      away_team_id: parents[:away_team],
      championship_id: parents[:championship]
    }
  end

  def find_or_create_home_team(datas)
    home_team_name = datas[0].text
    Team.find_or_create_by_name(home_team_name.downcase)
  end

  def find_or_create_away_team(datas)
    away_team_name = datas[4].text
    Team.find_or_create_by_name(away_team_name.downcase)
  end

  def find_or_create_championship(datas)
    championship_name = datas[6].text
    Championship.find_or_create_by_name(championship_name.downcase)
  end
end