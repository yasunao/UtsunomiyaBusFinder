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
    @finder=Finder.new(@f_date_year,@f_date_month,@f_date_day,@f_hour,@f_min,@f_from,@f_to)
  end
end
