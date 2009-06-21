require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('mactts', '0.1.0') do |p|
  p.description    = "Ruby wrapper around the Mac OS X say command"
  p.url            = "http://github.com/bratta/mactts"
  p.author         = "Tim Gourley"
  p.email          = "tgourley@gmail.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }

