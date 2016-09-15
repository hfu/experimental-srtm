require 'open-uri'
require 'fileutils'
all = 87381
count = 0
0.upto(8) {|z|
  n = 2 ** z
  n.times {|x|
    n.times {|y|
      count += 1
      dir = "#{z}/#{x}"
      path = "#{z}/#{x}/#{y}.csv"
      url = "http://example.com/path/#{path}"
      # FileUtils.mkdir_p(dir) unless File.directory?(dir)
      # File.write(path, open(url).read)
      print "#{count}: #{url}\n"
    }
  }
}
print count, "\n"
