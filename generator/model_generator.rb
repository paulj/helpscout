require 'restclient'
require 'nokogiri'
require 'fileutils'
require 'pp'
require 'erb'
require 'ostruct'

BASE_URL = 'http://developer.helpscout.net'
SEED_URL = "#{BASE_URL}/docs-api/"

FileUtils.mkdir_p('cache')

def fetch_url(u)
  fname = 'cache/' + u.gsub('http://developer.helpscout.net/', '').gsub(/\/$/, '').gsub('/', '-') + '.html'
  if File.exists? fname
    return File.read fname
  end

  content = RestClient.get u
  File.open(fname, 'w') { |f| f << content }

  content
end

endpoint_seed_urls = []
object_urls = []

phase = nil
seed_doc = Nokogiri::HTML(fetch_url(SEED_URL))
seed_doc.at('aside.sidebar ul#devNav').css('li').each do |item|
  if item.text == 'Endpoints'
    phase = 'endpoints'
  elsif item.text == 'Objects'
    phase = 'objects'
  elsif phase != nil
    url = BASE_URL + item.at('a')['href']

    endpoint_seed_urls << url if phase == 'endpoints'
    object_urls << url if phase == 'objects'
  end
end

endpoint_urls = endpoint_seed_urls.map do |url|
  doc = Nokogiri::HTML(fetch_url(url))
  doc.at('aside.sidebar ul.subnav').css('li').map do |item|
    BASE_URL + item.at('a')['href']
  end
end.flatten

endpoints = endpoint_urls.map do |url|
  content = fetch_url(url)
  doc = Nokogiri::HTML(content)
  main_content = doc.css('section.content-main')

  # Top text
  name = main_content.at('h1').text
  base_attributes = main_content.at('h1').next_element
  raise "Bad HTML structure - got tag #{base_attributes.name} instead of ul" unless base_attributes.name == 'ul'

  method = base_attributes.at('li:contains("REST Method:")').text.split(' ').last
  url = base_attributes.at('li:contains("URL:")').text.split(' ').last

  # Request Details
  request_header = main_content.at('h2:contains("Request")')
  request_attributes = if request_header  
    request_table = request_header.next_element
    raise "Bad HTML structure - got tag #{request_table.name} instead of table" unless request_table.name == 'table'

    request_table.at('tbody').css('tr').map do |row|
      cells = row.css('td').map(&:text)

      OpenStruct.new(
        name: cells[0],
        type: cells[1],
        required: cells[2] == 'Yes',
        options: cells[3].split("\n"),
        notes: cells[4]
      )
    end
  end

  # Response Details
  response_header = main_content.at('h2:contains("Response")')
  response_table = response_header.next_element
  raise "Bad HTML structure - got tag #{response_table.name} instead of table" unless response_table.name == 'table'

  response_attributes = response_table.at('tbody').css('tr').map do |row|
    cells = row.css('td').map(&:text)

    next if cells[0] == 'Header'

    subtype = if cells[2] == 'Collection'
      link = row.css('td')[3].at('a')
      if link then link.text else 'Collection' end
    end

    OpenStruct.new(
      name: cells[1],
      type: cells[2],
      subtype: subtype, 
      notes: cells[3]
    )
  end.compact

  OpenStruct.new(
    name: name,
    rest_method: method,
    url: url,
    request_attributes: request_attributes,
    response_attributes: response_attributes
  )
end

objects = object_urls.map do |url|
  doc = Nokogiri::HTML(fetch_url(url))
  main_content = doc.at('section.content-main')

  name = main_content.at('h1').text.gsub(/ Object$/, '')
  field_table = main_content.at('table')

  fields = field_table.at('tbody').css('tr').map do |row|
    cells = row.css('td').map(&:text)

    OpenStruct.new(
      name: cells[0],
      type: cells[1],
      example: cells[2],
      notes: cells[3]
    )
  end

  OpenStruct.new(
    name: name,
    fields: fields
  )
end

File.open(File.expand_path('../../lib/helpscout/docs_models.rb', __FILE__), 'w') do |f|
  template = ERB.new(File.read('objects.erb'))
  b = binding

  f << template.result(b)
end
File.open(File.expand_path('../../lib/helpscout/docs_client.rb', __FILE__), 'w') do |f|
  template = ERB.new(File.read('client.erb'))
  b = binding

  f << template.result(b)
end

pp endpoints
pp objects