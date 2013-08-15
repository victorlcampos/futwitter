require 'nokogiri'

class SummaryUrl
  def self.fetch(url)
    html = open(url)
    doc = Nokogiri::HTML(html.read)
    doc.encoding = 'utf-8'

    {
      title: title(doc),
      description: description(doc),
      image_url: images(doc)
    }
  end

  private
  def self.description(doc, size=140)
    if (description = doc.xpath("//meta[@property='og:description']")[0]) &&
           (content = description.attributes['content'])
      ret = content.value
    end

    unless ret
      description = doc.xpath("//meta[@name='description']")

      if !description.empty? && !description[0].attributes["content"]
                                                              .content.empty?
        ret = description[0].attributes["content"].content
      end
    end

    if ret && ret.length > size
      ret = ret.first(size) + "..."
    end

    ret
  end

  def self.title(doc)
    if title = doc.xpath("//meta[@property='og:title']")[0]
      ret = title.attributes['content'].value if title.attributes['content']
    end

    ret = doc.title unless ret

    ret
  end

  def self.images(doc)
    image = doc.xpath("//meta[@property='og:image']").collect do |img|
      url = img.attributes['content'].value
      {
        url: url,
        size: FastImage.size(url)
      }
    end.reject do |img|
      img.nil? || img[:size].nil? || img[:size][0] < 50 || img[:size][1] < 50
    end

    url = image[0][:url] if image[0]

    unless url
      image = doc.xpath("//link[@rel='image_src']").collect do |img|
        if (content = img.attributes['content']) && (url = content.value)
          {
            url: url,
            size: FastImage.size(url)
          }
        end
      end.reject do |img|
        img.nil? || img[:size].nil? || img[:size][0] < 50 || img[:size][1] < 50
      end

      url = image[0][:url] if image[0]
    end

     url
  end
end