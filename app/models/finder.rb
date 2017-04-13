class Finder
  require 'nokogiri'
  require 'open-uri'
  require 'kconv'
  attr_accessor :charset, :html,:nokogiri
  def initialize(f_date_year,f_date_month,f_date_day,f_hour,f_min,f_from,f_to)
    @url="http://kantobus.info/route/result/?action_route_result=1&f_from_type=1&f_to_type=1&f_from_genre=&f_to_genre=&f_from="+f_from+"&f_to="+f_to+"&f_through=&fs_from=1&fs_to=32&f_type_fromto=1&f_date_Year="+f_date_year.to_s+"&f_date_Month=4&f_date_Day="+f_date_day.to_s+"&f_hour="+f_hour.to_s+"&f_min="+f_min.to_s+"&f_wait=10&action_route_result.x=168&action_route_result.y=18&action_route_result=経路・運賃を表示"
    @charset=nil
    @html=get_html()
    @nokogiri=get_nokogiri()
  end
  def get_html
    target_css='title'
    html = open(URI.encode(@url)) do |f|
      @charset=f.charset
      f.read # htmlを読み込んで変数htmlに渡す
    end
    return html
  end
  def get_nokogiri
    return Nokogiri::HTML.parse(@html, nil, @charset)
  end
  def get_title
    @nokogiri=get_nokogiri
    binding.pry
    return @nokogiri.title
  end
end