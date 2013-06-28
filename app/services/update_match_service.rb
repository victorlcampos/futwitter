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
      away_team_score: datas[3].text,
      internet_url: datas.css('a').first.attributes['href'].value,
      start_time: start_time(datas)
    }
  end

  def start_time(datas)
    date_text = datas.text.split(', ')[1]

    day,     date_text = split_text('/', date_text)
    month,   date_text = split_text(' ', date_text)
    hour,    date_text = split_text(':', date_text)
    minutes, date_text = date_text[1].to_i

    DateTime.new(Date.today.year, month, day, hour, minutes)
  end

  def split_text(partern, text)
    text  = text.split(partern)
    value = text[0]
    text  = text[1]
    [value.to_i, text]
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