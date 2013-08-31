# encoding: utf-8
class Mood
  @queue = :mood
  def self.perform(tweet_id)
    tweet = Tweet.find(tweet_id)

    words = {
      'gol' => 1,
      'pra cima' => 1,
      'golaço' => 1,
      ':D' => 1,
      ':P' => 1,
      '\o' => 1,
      '\o/' => 1,
      ':-)' => 1,
      ':)' => 1,
      ':o)' => 1,
      ':]' => 1,
      ':3' => 1,
      ':c)' => 1,
      ':-(' => -1,
      ':(' => -1,
      ':c' => -1,
      ':[' => -1,
      'perna de pau' => -1,
      'bobo' => -1,
      'imbecil' => -1,
      'idiota' => -1,
      'cabeça de bagre' => -1,
      'incompetente' => -1,
      'gol' => -1,
      ':(' => -1,
      ":'(" => -1,
      'pipocou' => -1,
      'amarelou' => -1,
      'pipoqueiro' => -1
    }

    words.each do |word, value|
      (tweet.mood += value) if tweet.text.match /word/
    end

    tweet.save!
  end
end
