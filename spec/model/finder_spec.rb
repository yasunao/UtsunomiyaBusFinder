require 'rails_helper'
require 'spec_helper'
require 'pry-rails'
require 'platform_fixture'
RSpec.describe Finder, :type => :model do
  include Rack::Test::Methods
  include ActionDispatch::TestProcess
  include PlatformFixture
  before :all do
    @platform_ids=ids_created_platforms_examples
    @f_date_year ||= Date.today.year
    @f_date_month ||= Date.today.month
    @f_date_day ||= Date.today.day
    @f_hour ||= 7
    @f_min ||= 30
    @f_from ||= "宇都宮駅西口"
    @f_to ||= "桜小学校入口"
    @url ||= nil
    @finder=Finder.new(@f_date_year,@f_date_month,@f_date_day,@f_hour,@f_min,@f_from,@f_to,@url)
  end
  after :all do
    Platform.delete(@platform_ids)
  end
  context "今日の朝７時３０分、宇都宮駅西発、桜小学校入口着のバスについて検索すると、" do
    describe "finderのインスタンス変数について" do
      it "出発停留所名は宇都宮駅西口、到着停留所名は桜小学校入り口" do
        expect(@finder.f_from).to eq "宇都宮駅西口"
        expect(@finder.f_to).to eq "桜小学校入口"
      end
      it "は、所要時間8分、出発時間7:30,系統番号は55、系統名は作新学院経由・宝木団地、touchakujikokuha7:38,大人運賃は２１０円" do
        expect(@finder.time_required).to eq "8分"
        expect(@finder.d_time).to eq "07:30"
        expect(@finder.platform_number).to eq "55"
        expect(@finder.platform_name).to eq "作新学院経由・宝木団地"
        expect(@finder.a_time).to eq "07:38"
        expect(@finder.price).to eq "大人運賃：210円"
      end
    end
    describe "finderのプライベートメソッド、get_bording_numberについて" do 
      it "は、'1番 2番'を返す" do
        expect(@finder.bording_number).to eq "1番 2番"
      end
    end
    describe "finderのプライベートメソッド、get_next_bus_urlおよびget_prev_bus_urlについて" do 
      it "は、次のバスの時間、2017年4月15日7時32分に準じたURLを返す" do
        a=@finder.prev_bus_url
        b="http://kantobus.info/route/result/?f_mode=2&f_type_fromto=2&fs_from=1&f_from_type=1&f_from_genre=&fs_to=32&fs_through=&f_to_type=1&f_to_genre=&f_date_Year=2017&f_date_Month=4&f_date_Day=17&f_hour=7&f_min=37&f_wait=10&f_from=%E5%AE%87%E9%83%BD%E5%AE%AE%E9%A7%85%E8%A5%BF%E5%8F%A3&f_to=%E6%A1%9C%E5%B0%8F%E5%AD%A6%E6%A0%A1%E5%85%A5%E5%8F%A3&f_through="
        expect(a.split(//)-b.split(//)).to eq []
      end
      it "は、前のバスの時間、2017年4月15日7時32分に準じたURLを返す" do
        a=@finder.next_bus_url
        b="http://kantobus.info/route/result/?f_mode=2&f_type_fromto=1&fs_from=1&f_from_type=1&f_from_genre=&fs_to=32&fs_through=&f_to_type=1&f_to_genre=&f_date_Year=2017&f_date_Month=4&f_date_Day=17&f_hour=7&f_min=31&f_wait=10&f_from=%E5%AE%87%E9%83%BD%E5%AE%AE%E9%A7%85%E8%A5%BF%E5%8F%A3&f_to=%E6%A1%9C%E5%B0%8F%E5%AD%A6%E6%A0%A1%E5%85%A5%E5%8F%A3&f_through="
        expect(a.split(//)-b.split(//)).to eq []
      end
    end
  end
end