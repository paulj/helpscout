require "erb"
require "httparty"
require "yaml"

module HelpScout
  class BaseClient
    include HTTParty

    # Requests a single item from the Help Scout API. Should return either an 
    # item from the SingleItemEnvelope, or raise an error with an 
    # ErrorEnvelope.
    #
    # url     String  A string representing the url for the REST endpoint to be
    #                 queried.
    # params  Hash    A hash of GET parameters to use for this particular 
    #                 request.
    #
    # Response
    #           Name    Type   Notes     
    #  Header   Status  Int    200
    #  Body     item

    def self.request_item(auth, url, params = {})
      item = nil

      request_url = ""
      request_url << url
      if params
        query = ""
        params.each { |k,v| query += "#{k}=#{v}&" }
        request_url << "?" + query
      end

      begin
        response = self.get(request_url, {:basic_auth => auth})
      rescue SocketError => se
        raise StandardError, se.message
      end

      if 200 <= response.code && response.code < 300
        envelope = SingleItemEnvelope.new(response)
        if envelope.item
          item = envelope.item
        end
      elsif 400 <= response.code && response.code < 500
        if response["message"]
          envelope = ErrorEnvelope.new(response)
          raise StandardError, envelope.message
        else
          raise StandardError, response["error"]
        end
      else
        raise StandardError, "Server Response: #{response.code}"
      end

      item
    end


    # Requests a collections of items from the Help Scout API. Should return 
    # either an array of items from the CollectionsEnvelope, or raise an error 
    # with an ErrorEnvelope.
    # 
    # Collections return a maximum of 50 records per page.
    #
    # url     String  A string representing the url for the REST endpoint to be 
    #                 queried.
    # params  Hash    A hash of GET parameters to use for this particular 
    #                 request.
    #
    # Response
    #           Name    Type   Notes     
    #  Header   Status  Int    200
    #  Body     page    Int    Current page that was passed in on the request
    #           pages   Int    Total number of pages available
    #           count   Int    Total number of objects available
    #           items   Array  Collection of objects

    def self.request_items(auth, url, params = {})
      items = []

      request_url = URI.parse(url)
      if params
        request_url.query = URI.encode_www_form(params.to_a)
      end
      
      begin
        response = self.get(request_url.to_s, {:basic_auth => auth})
      rescue SocketError => se
        raise StandardError, se.message
      end
    
      if 200 <= response.code && response.code < 300
        envelope = CollectionsEnvelope.new(interpret_response(response))
        if envelope.items
          envelope.items.each do |item|
            items << item
          end
        end
      elsif 400 <= response.code && response.code < 500
        if response["message"]
          envelope = ErrorEnvelope.new(response)
          raise StandardError, envelope.message
        else
          raise StandardError, response["error"]
        end
      else
        raise StandardError, "Server Response: #{response.code}"
      end

      items
    end
    

    # Requests a collections of items from the Help Scout API. Should return 
    # the total count for this collection, or raise an error with an 
    # ErrorEnvelope.
    # 
    # url     String  A string representing the url for the REST endpoint to be 
    #                 queried.
    # params  Hash    A hash of GET parameters to use for this particular 
    #                 request.
    #
    # Response
    #           Name    Type   Notes
    #  Header   Status  Int    200
    #  Body     page    Int    Current page that was passed in on the request
    #           pages   Int    Total number of pages available
    #           count   Int    Total number of objects available
    #           items   Array  Collection of objects

    def self.request_count(auth, url, params = {})
      request_url = ""
      request_url << url
      if params
        query = ""
        params.each { |k,v| query += "#{k}=#{v}&" }
        request_url << "?" + query
      end

      begin
        response = self.get(request_url, {:basic_auth => auth})
      rescue SocketError => se
        raise StandardError, se.message
      end
    
      if 200 <= response.code && response.code < 300
        envelope = CollectionsEnvelope.new(response)
        envelope.count
      elsif 400 <= response.code && response.code < 500
        if response["message"]
          envelope = ErrorEnvelope.new(response)
          raise StandardError, envelope.message
        else
          raise StandardError, response["error"]
        end
      else
        raise StandardError, "Server Response: #{response.code}"
      end     
    end


    # Sends a POST request to create a single item from the Help Scout API.
    #
    # url     String  A string representing the url to POST.
    # params  Hash    A hash of POST parameters to use for this particular 
    #                 request.
    #
    # Response
    #  Name      Type    Notes
    #  Location  String  https://api.helpscout.net/v1/conversations/{id}.json

    def self.create_item(auth, url, params = {})
      begin
        response = self.post(url, {:basic_auth => auth, :headers => { 'Content-Type' => 'application/json' }, :body => params })
      rescue SocketError => se
        raise StandardError, se.message
      end

      if response.code == 201
        if response["item"]
          response["item"]
        else
          response["Location"]
        end
      else
        raise StandardError.new("Server Response: #{response.code} #{response.message} (#{response.body})")
      end
    end


    # HelpScout::Client.new
    # 
    # Initializes the Help Scout Client. Once called, you may use any of the 
    # HelpScout::Client methods to query the Help Scout API.
    #
    # key  String  Help Scout API Key. Optional. If not passed, the key will be
    #              loaded from @@settings, which defaults to helpscout.yml.

    def initialize(key=nil)
      self.class.settings
  
      if key.nil?
        key = @@settings["api_key"]
      end

      # The Help Scout API uses Basic Auth, where username is your API Key. 
      # Password can be any arbitrary non-zero-length string.
      @auth = { :username => key, :password => "X" }
    end

    # Hook method allowing a response to be interpreted. This is necessary because the docs API wraps
    # the response differently to the Helpdesk API.
    def self.interpret_response(response)
      response
    end
  end
end