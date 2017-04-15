require 'rails_helper'
require 'spec_helper'
require 'pry-rails'
require 'platform_fixture'
RSpec.describe Finder, :type => :model do
  include Rack::Test::Methods
  include ActionDispatch::TestProcess
  include PlatformFixture
  before :all do
    ids_created_platforms_examples
    @f_date_year ||= Date.today.year
    @f_date_month ||= Date.today.month
    @f_date_day ||= Date.today.day
    @f_hour ||= 7
    @f_min ||= 30
    @f_from ||= "宇都宮駅西口"
    @f_to ||= "桜小学校入口"
    @finder=Finder.new(@f_date_year,@f_date_month,@f_date_day,@f_hour,@f_min,@f_from,@f_to)
    @platform_ids=ids_created_platforms_examples
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
        #binding.pry
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
    describe "finderのプライベートメソッド、get_next_busについて" do 
      it "は、次のバスの時間、2017年4月15日7時38分のパラメータを返す" do
        expect(@finder.next_bus_params).to eq ["2017", "4", "15", "7", "38"]
      end
    end
  end
end