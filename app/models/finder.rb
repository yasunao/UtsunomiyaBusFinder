class Finder
  require 'nokogiri'
  require 'open-uri'
  require 'kconv'
  attr_accessor :f_from,:f_to,:time_required,:d_time,:platform_number,:platform_name,:a_time,:price,:bording_number
  def initialize(f_date_year,f_date_month,f_date_day,f_hour,f_min,f_from,f_to)
    @url="http://kantobus.info/route/result/?action_route_result=1&f_from_type=1&f_to_type=1&f_from_genre=&f_to_genre=&f_from="+f_from+"&f_to="+f_to+"&f_through=&fs_from=1&fs_to=32&f_type_fromto=1&f_date_Year="+f_date_year.to_s+"&f_date_Month=4&f_date_Day="+f_date_day.to_s+"&f_hour="+f_hour.to_s+"&f_min="+f_min.to_s+"&f_wait=10&action_route_result.x=168&action_route_result.y=18&action_route_result=経路・運賃を表示"
    @charset=nil
    @html=get_html()
    @nokogiri=get_nokogiri()
    @time_required,@d_time,@platform_number,@platform_name,@a_time,@price=nokogiri_tr1
    @f_from=f_from
    @f_to=f_to
    @bording_number=get_bording_number(@platform_number)
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
  def get_platform
    return @nokogiri.search("tr")[1].text.gsub(/\n\t*/,",").gsub(/,+/,",").split(/,/)[3].split(/ /)[0]
  end
  private
  def nokogiri_tr1
    tr1= @nokogiri.search("tr")[1].text.gsub(/\n\t*/,",").gsub(/,+/,",").split(/,/)
    return [tr1[1],tr1[2],tr1[3].split(/ /)[0],tr1[3].split(/ /)[1],tr1[7],tr1[8]]
  end
  def get_bording_number(platform_number)
    return Platform.where(name: platform_number).pluck(:bording_number).join(",")
  end
end