module PlatformFixture
  def ids_created_platforms_examples
    platform_array=[
      ["33","1番 2番"],
      ["50","1番 2番"],
      ["53","1番 2番"],
      ["54","1番 2番"],
      ["54","1番 2番"],
      ["55","1番 2番"],
      ["55","1番 2番"],
      ["16","5番"],
      ["16","5番"],
      ["16","5番"],
      ["18","5番"],
      ["60","5番"],
      ["61","5番"],
      ["61","5番"],
      ["62","5番"],
      ["64","5番"],
      ["10","6番"],
      ["45","6番"],
      ["46","6番"],
      ["47","6番"],
      ["10","7番"],
      ["51","8番"],
      ["52","8番"],
      ["52","8番"],
      ["56","8番"],
      ["58","8番"],
      ["70","8番"],
      ["71","8番"],
      ["71","8番"],
      ["73","8番"],
      ["12","9番"],
      ["12","9番"],
      ["80","9番"],
      ["80","9番"],
      ["81","9番"],
      ["83","9番"],
      ["84","9番"],
      ["85","9番"],
      ["85","9番"],
      ["40","10番"],
      ["43","10番"],
      ["43","10番"],
      ["31","11番"],
      ["25","12番"],
      ["36","12番"],
      ["36","12番"],
      ["41","12番"],
      ["34","13番"],
      ["37","13番"],
      ["37","13番"],
    ]
    ids=[]
    platform_array.each{|pl|
      platform=Platform.new(name: pl[0],bording_number: pl[1])
      platform.save
      ids.push(platform.id)
    }
    return ids
  end
end