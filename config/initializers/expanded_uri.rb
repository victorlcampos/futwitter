module URI
  def self.remove_params(uri, params = nil)
    return uri unless params

    params = Array(params)
    uri_parsed = parse(uri)

    return uri unless uri_parsed.query

    escaped = uri_parsed.query.split(/&amp;/).size > 0
    new_params = uri_parsed.query.gsub(/&amp;/, '&').split('&')
                            .reject { |q| params.include?(q.split('=').first) }
    uri = uri.split('?').first
    amp = escaped ? '&amp;' : '&'

    new_params = new_params.join(amp)
    new_params.empty? ? uri : "#{uri}?#{new_params}"
  end
end