class UpdateMatchService
  LANCENET_URL = 'http://temporeal.lancenet.com.br/'

  def update_matches_from_internet
    doc = Nokogiri::HTML(open(LANCENET_URL))

    doc.css('#listaJogos tr').each do |match|
      datas = match.css('td')
      match_url = datas.css('a').first.attributes['href'].value

      update_or_create_match(match_data(datas, match_url),
                               parents(datas, match_url))
    end
  end

  private
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

  def match_data(datas, match_url)
    {
      home_team_score: datas[1].text,
      away_team_score: datas[3].text,
      internet_url: match_url,
      start_time: start_time(datas)
    }
  end

  def start_time(datas)
    date_text = datas.text.split(', ')[1]

    day     = split_text('/', date_text)
    month   = split_text(' ', date_text)
    hour    = split_text(':', date_text)
    minutes = date_text[1].to_i

    Time.zone.local(Date.today.year, month, day, hour, minutes)
  end

  def split_text(partern, text)
    splited_text  = text.split(partern)
    value = splited_text[0]
    text.replace splited_text[1]
    value.to_i
  end

  def parents(datas, match_url)
    {
      home_team:    find_or_create_home_team(datas, match_url),
      away_team:    find_or_create_away_team(datas, match_url),
      championship: find_or_create_championship(datas)
    }
  end

  def find_or_create_home_team(datas, match_url)
    home_team_name = datas[0].text
    team = Team.find_or_create_by_name(home_team_name.downcase)

    unless team.badge?
      team.remote_badge_url = find_home_team_badge(match_url)
      team.save!
    end
    team
  end

  def find_home_team_badge(match_url)
    doc = Nokogiri::HTML(open("#{LANCENET_URL}#{match_url}"))
    "#{LANCENET_URL}#{doc.css('.escudo img.png')[0].attributes['src'].value}"
  end

  def find_or_create_away_team(datas, match_url)
    away_team_name = datas[4].text
    team = Team.find_or_create_by_name(away_team_name.downcase)
    unless team.badge?
      team.remote_badge_url = find_away_team_badge(match_url)
      team.save!
    end
    team
  end

  def find_away_team_badge(match_url)
    doc = Nokogiri::HTML(open("#{LANCENET_URL}#{match_url}"))
    "#{LANCENET_URL}#{doc.css('.escudo img.png')[1].attributes['src'].value}"
  end

  def find_or_create_championship(datas)
    championship_name = datas[6].text
    Championship.find_or_create_by_name(championship_name.downcase)
  end
end