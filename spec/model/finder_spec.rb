require 'rails_helper'
require 'spec_helper'
require 'pry-rails'
require 'platform_fixture'
RSpec.describe Finder, :type => :model do
  include Rack::Test::Methods
  include ActionDispatch::TestProcess
  include PlatformFixture
  before :all do
    @f_date_year ||= Date.today.year
    @f_date_month ||= Date.today.month
    @f_date_day ||= Date.today.day
    @f_hour ||= 7
    @f_min ||= 30
    @f_from ||= "宇都宮駅西"
    @f_to ||= "桜小学校入口"
    @finder=Finder.new(@f_date_year,@f_date_month,@f_date_day,@f_hour,@f_min,@f_from,@f_to)
    @platform_ids=ids_created_platforms_examples
  end
  after :all do
    Platform.delete(@platform_ids)
  end
  context "finder.get_titleについて" do
    it "取得したページは<title>運賃・経路－関東自動車株式会社</title>を含む" do
      expect(@finder.get_title).to eq "運賃・経路－関東自動車株式会社"
    end
  end
end