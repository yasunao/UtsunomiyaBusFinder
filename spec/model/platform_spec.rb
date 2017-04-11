require 'rails_helper'
require 'spec_helper'
require 'pry-rails'
require 'platform_fixture'
RSpec.describe Platform, :type => :model do
  include Rack::Test::Methods
  include ActionDispatch::TestProcess
  include PlatformFixture
  before :all do
    @platform_ids=ids_created_platforms_examples
  end
  after :all do
    Platform.delete(@platform_ids)
  end
  context "バス番号が分かっている。４３だ。さて、乗り場番号を知りたい。" do
    it "インスタンスメソッドplatform.to_bording_number(55)は '1番 2番'を返す" do
      platform=Platform.where(name: "55").first
      expect(platform.bording_number).to eq "1番 2番"
    end
  end
end