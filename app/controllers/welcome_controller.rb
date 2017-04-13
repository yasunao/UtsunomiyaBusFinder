class WelcomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @f_date_year ||= Date.today.year
    @f_date_month ||= Date.today.month
    @f_date_day ||= Date.today.day
    @f_hour ||= Time.now.hour
    @f_min ||= Time.now.min
    @f_from ||= "宇都宮駅西"
    @f_to ||= "桜小学校入口"
    @url ||= URI.encode("http://kantobus.info/route/result/?action_route_result=1&f_from_type=1&f_to_type=1&f_from_genre=&f_to_genre=&f_from=宇都宮駅西口&f_to=桜小学校入口&f_through=&fs_from=1&fs_to=32&f_type_fromto=1&f_date_Year=2017&f_date_Month=4&f_date_Day=12&f_hour=7&f_min=30&f_wait=10&action_route_result.x=168&action_route_result.y=18&action_route_result=経路・運賃を表示")
    @finder=Finder.new(@f_date_year,@f_date_month,@f_date_day,@f_hour,@f_min,@f_from,@f_to)
  end
end
