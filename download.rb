require 'open-uri'
require 'fileutils'
all = 87381
count = 0

def lat(n, y)
  180.0 / Math::PI * Math.atan(Math.sinh(Math::PI * (1.0 - 2.0 * y / n)))
end

def in_coverage?(z, x, y)
  # coverage area: 56 degrees South to 60 degrees North
  #return (lat(2 ** z, y) < 60) && (lat(2 ** z, y + 1) > -56)
  return (lat(2 ** z, y) > -56) && (lat(2 ** z, y + 1) < 60)
end

1.upto(6) {|z|
  n = 2 ** z
  n.times {|x|
    n.times {|y|
      count += 1
      dir = "#{z}/#{x}"
      path = "#{z}/#{x}/#{y}.csv"
      url = "http://earthexplorer.usgs.gov/wms/wmts/EPSG3857/srtm/#{path}"
      print "#{count}: #{url}\n"
      next unless in_coverage?(z, x, y)
      next if File.exist?(path)
      FileUtils.mkdir_p(dir) unless File.directory?(dir)
      File.write(path, open(url).read)
      sleep(rand / 3)
    }
  }
}
print count, "\n"
