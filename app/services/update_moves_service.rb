class UpdateMovesService
  FIRST_HALF  = 'etapa-1.htm'
  SECOND_HALF = 'etapa-2.htm'

  attr_accessor :match

  def initialize(match)
    @match = match
  end

  def update_moves_from_internet
    find_or_create_move(FIRST_HALF)
    find_or_create_move(SECOND_HALF)
  end

  protected

  def find_or_create_move(half)
    doc = Nokogiri::HTML(open(get_url(half)), nil, 'UTF-8')
    doc.css('tr').each do |move|
      params = get_param(move, half)
      Move.create!(params) unless Move.where(params).first
    end
  end

  def get_url(half)
    base_url = UpdateMatchService::LANCENET_URL
    match_url = match.internet_url
    "#{base_url}#{match_url}#{half}"
  end

  def get_param(move, half)
    {
      match_id: match.id,
      minute: get_minutes(move),
      text: get_text(move),
      team_name: get_team_name(move),
      half: get_half(half)
    }
  end

  def get_half(half)
    case half
    when FIRST_HALF
      1
    when SECOND_HALF
      2
    end
  end

  def get_minutes(move)
     move.css('.minuto').text.gsub(/[^0-9]/, '')
  end

  def get_text(move)
    move.css('.lances').text
  end

  def get_team_name(move)
    team_name = nil
    team_tag = move.css('.td-EscudoTime .png')
    unless team_tag.empty?
      team_name = team_tag[0].attributes['alt'].value.downcase
    end
    team_name
  end
end