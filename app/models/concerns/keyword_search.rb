module KeywordSearch
  def keyword_search(keywords, user)
    keywords_array = keywords.split(" ").map{|keyword| keyword.strip}
    keywords_list = keywords_array.collect do |keyword|
      self.search(keyword, user)
    end
    keywords_list.flatten.uniq.compact
  end
end
