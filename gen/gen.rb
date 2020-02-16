#! /usr/bin/env ruby

require 'erb'
require 'yaml'
require 'uri'

STDOUT.binmode

erb = File.read('part.erb')
i = 0
YAML.load_file('list.yml').each do |y|
  next if y['article'].nil?
  unless y['caption'].empty?
    y['caption'] = "<p class=\"card-text\">#{y['caption']}</p>"
  end
  if y['oldid'].nil?
    y['url'] = "https://ja.wikipedia.org/wiki/#{URI.escape(y['article'])}"
  else
    y['url'] = "https://ja.wikipedia.org/w/index.php?title=#{URI.escape(y['article'])}&oldid=#{y['oldid']}"
  end
  html = ERB.new(erb).result(binding)
  puts html
  i += 1
  puts if i % 3 == 0
end
