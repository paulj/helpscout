# Help Scout API V1 Client
# http://developer.helpscout.net/
#
# Authentication
# This is an HTTPS-only API. Authentication will be based on API Keys, which can
# be generated the Help Scout UI in the User Profile. Each API Key will map to 
# an existing Help Scout user. Results returned from various responses will be 
# based upon the role of the user to which the API key is tied.
#
# The API Key will be passed via HTTP Basic Authentication. The API Key will go 
# in the username field and a dummy password, such as X, in the password field.
#
# Rate Limiting
# Requests will be limited to 200 requests per minute. Response code 429 will 
# be returned when throttle limit has been reached. A "Retry-After" header will
#  be returned indicating how many seconds to wait until retry.
#
# Formats
# Each endpoint will specify the response format in the URL. However, the API
# will only support JSON at this time.
#
# Usage
# 1. Follow the instructions at Help Scout's Developers site to generate an API 
#    key: http://developer.helpscout.net/
# 2. Add your API Key to config/helpscout.yml:
#    api_key: XXXXXX
# 3. Initialize your Help Scout client:
#    HelpScout::Client.new
# 4. You may now query the Help Scout API:
#    mailboxes = HelpScout::Client.mailboxes
#
# You may also initialize a client without using helpscout.yml by passing the
# API Key to new:
# HelpScout::Client.new(XXXXXX)

require "helpscout/base_client"

module HelpScout
  class DocsClient < BaseClient
    # All API requests will be made to: https://api.helpscout.net/. All 
    # requests are served over HTTPS. The current version is v1.
    base_uri 'https://docsapi.helpscout.net/v1'

    @@settings ||= nil

    # Returns the current Help Scout Client settings.
    # If no settings have been loaded yet, this function will load its 
    # configuration from helpscout.yml
    # 
    # Settings
    # api_key  String  Help Scout API Key. The API is currently available for 
    #                  paying Help Scout accounts (Basic or Standard plan). You
    #                  can generate a key from your User Profile, on the API 
    #                  Keys tab.

    def self.settings
      if @@settings.nil?
        path = "config/helpscout.yml"
        if File.exist?(path)
          @@settings = YAML.load(ERB.new(File.new(path).read).result)
        end
      end
      @@settings
    end

    # HelpScout::Client.new
    # 
    # Initializes the Help Scout Client. Once called, you may use any of the 
    # HelpScout::Client methods to query the Help Scout API.
    #
    # key  String  Help Scout API Key. Optional. If not passed, the key will be
    #              loaded from @@settings, which defaults to helpscout.yml.

    def initialize(key=nil)
      super
    end

    
      # List Articles
      # https://docsapi.helpscout.net/v1/collections/{id}/articles
      #
      # 
      
      def list_articles(opts = {})
        url = "https://docsapi.helpscout.net/v1/collections/{id}/articles"

        
          
            self.class.request_items(@auth, url, opts.merge()).map do |item|
              ArticleRef.new(item)
            end
          
        
      end
    
      # Search Articles
      # https://docsapi.helpscout.net/v1/search/articles
      #
      # 
      
      def search_articles(query, opts = {})
        url = "https://docsapi.helpscout.net/v1/search/articles"

        
          
            self.class.request_items(@auth, url, opts.merge(query: query)).map do |item|
              ArticleSearch.new(item)
            end
          
        
      end
    
      # List Related Articles
      # https://docsapi.helpscout.net/v1/articles/{id}/related
      #
      # 
      
      def list_related_articles(opts = {})
        url = "https://docsapi.helpscout.net/v1/articles/{id}/related"

        
          
            self.class.request_items(@auth, url, opts.merge()).map do |item|
              ArticleRef.new(item)
            end
          
        
      end
    
      # List Revisions
      # https://docsapi.helpscout.net/v1/articles/{id}/revisions
      #
      # 
      
      def list_revisions(opts = {})
        url = "https://docsapi.helpscout.net/v1/articles/{id}/revisions"

        
          
            self.class.request_items(@auth, url, opts.merge()).map do |item|
              ArticleRevisionRef.new(item)
            end
          
        
      end
    
      # Get Article
      # https://docsapi.helpscout.net/v1/articles/{id}
      #
      # 
      
      def get_article(opts = {})
        url = "https://docsapi.helpscout.net/v1/articles/{id}"

        
          
        
      end
    
      # Get Revision
      # https://docsapi.helpscout.net/v1/revisions/{id}
      #
      # 
      
      def get_revision(opts = {})
        url = "https://docsapi.helpscout.net/v1/revisions/{id}"

        
          
        
      end
    
      # Create Article
      # https://docsapi.helpscout.net/v1/articles
      #
      # 
      
      def create_article(opts = {})
        url = "https://docsapi.helpscout.net/v1/articles"

        
      end
    
      # Update Article
      # https://docsapi.helpscout.net/v1/articles/{id}
      #
      # 
      
      def update_article(opts = {})
        url = "https://docsapi.helpscout.net/v1/articles/{id}"

        
      end
    
      # Upload Article
      # https://docsapi.helpscout.net/v1/articles/upload
      #
      # 
      
      def upload_article(opts = {})
        url = "https://docsapi.helpscout.net/v1/articles/upload"

        
      end
    
      # Update View Count
      # https://docsapi.helpscout.net/v1/articles/{id}/views
      #
      # 
      
      def update_view_count(opts = {})
        url = "https://docsapi.helpscout.net/v1/articles/{id}/views"

        
      end
    
      # Delete Article
      # https://docsapi.helpscout.net/v1/articles/{id}
      #
      # 
      
      def delete_article(opts = {})
        url = "https://docsapi.helpscout.net/v1/articles/{id}"

        
      end
    
      # Save Article Draft
      # https://docsapi.helpscout.net/v1/articles/{id}/drafts
      #
      # 
      
      def save_article_draft(opts = {})
        url = "https://docsapi.helpscout.net/v1/articles/{id}/drafts"

        
      end
    
      # Delete Article Draft
      # https://docsapi.helpscout.net/v1/articles/{articleId}/drafts
      #
      # 
      
      def delete_article_draft(opts = {})
        url = "https://docsapi.helpscout.net/v1/articles/{articleId}/drafts"

        
      end
    
      # Create Article Asset
      # https://docsapi.helpscout.net/v1/assets/article
      #
      # 
      
      def create_article_asset(opts = {})
        url = "https://docsapi.helpscout.net/v1/assets/article"

        
      end
    
      # Create Settings Asset
      # https://docsapi.helpscout.net/v1/assets/settings
      #
      # 
      
      def create_settings_asset(opts = {})
        url = "https://docsapi.helpscout.net/v1/assets/settings"

        
      end
    
      # List Categories
      # https://docsapi.helpscout.net/v1/collections/{id}/categories
      #
      # 
      
      def list_categories(opts = {})
        url = "https://docsapi.helpscout.net/v1/collections/{id}/categories"

        
          
            self.class.request_items(@auth, url, opts.merge()).map do |item|
              Category.new(item)
            end
          
        
      end
    
      # Get Category
      # https://docsapi.helpscout.net/v1/categories/{id}
      #
      # 
      
      def get_category(opts = {})
        url = "https://docsapi.helpscout.net/v1/categories/{id}"

        
          
        
      end
    
      # Create Category
      # https://docsapi.helpscout.net/v1/categories
      #
      # 
      
      def create_category(opts = {})
        url = "https://docsapi.helpscout.net/v1/categories"

        
      end
    
      # Update Category
      # https://docsapi.helpscout.net/v1/categories/{id}
      #
      # 
      
      def update_category(opts = {})
        url = "https://docsapi.helpscout.net/v1/categories/{id}"

        
      end
    
      # Update Category Order
      # https://docsapi.helpscout.net/v1/collections/{id}/categories
      #
      # 
      
      def update_category_order(opts = {})
        url = "https://docsapi.helpscout.net/v1/collections/{id}/categories"

        
      end
    
      # Delete Category
      # https://docsapi.helpscout.net/v1/categories/{id}
      #
      # 
      
      def delete_category(opts = {})
        url = "https://docsapi.helpscout.net/v1/categories/{id}"

        
      end
    
      # List Collections
      # https://docsapi.helpscout.net/v1/collections
      #
      # 
      
      def list_collections(opts = {})
        url = "https://docsapi.helpscout.net/v1/collections"

        
          
            self.class.request_items(@auth, url, opts.merge()).map do |item|
              Collection.new(item)
            end
          
        
      end
    
      # Get Collection
      # https://docsapi.helpscout.net/v1/collections/{id}
      #
      # 
      
      def get_collection(opts = {})
        url = "https://docsapi.helpscout.net/v1/collections/{id}"

        
          
        
      end
    
      # Create Collection
      # https://docsapi.helpscout.net/v1/collections
      #
      # 
      
      def create_collection(opts = {})
        url = "https://docsapi.helpscout.net/v1/collections"

        
      end
    
      # Update Collection
      # https://docsapi.helpscout.net/v1/collections/{id}
      #
      # 
      
      def update_collection(opts = {})
        url = "https://docsapi.helpscout.net/v1/collections/{id}"

        
      end
    
      # Delete Collection
      # https://docsapi.helpscout.net/v1/collections/{id}
      #
      # 
      
      def delete_collection(opts = {})
        url = "https://docsapi.helpscout.net/v1/collections/{id}"

        
      end
    
      # List Sites
      # https://docsapi.helpscout.net/v1/sites
      #
      # 
      
      def list_sites(opts = {})
        url = "https://docsapi.helpscout.net/v1/sites"

        
          
            self.class.request_items(@auth, url, opts.merge()).map do |item|
              Site.new(item)
            end
          
        
      end
    
      # Get Site
      # https://docsapi.helpscout.net/v1/sites/{id}
      #
      # 
      
      def get_site(opts = {})
        url = "https://docsapi.helpscout.net/v1/sites/{id}"

        
          
        
      end
    
      # Create Site
      # https://docsapi.helpscout.net/v1/sites
      #
      # 
      
      def create_site(opts = {})
        url = "https://docsapi.helpscout.net/v1/sites"

        
      end
    
      # Update Site
      # https://docsapi.helpscout.net/v1/sites/{id}
      #
      # 
      
      def update_site(opts = {})
        url = "https://docsapi.helpscout.net/v1/sites/{id}"

        
      end
    
      # Delete Site
      # https://docsapi.helpscout.net/v1/sites/{id}
      #
      # 
      
      def delete_site(opts = {})
        url = "https://docsapi.helpscout.net/v1/sites/{id}"

        
      end
    

    def self.interpret_response(response)
      response.values.first
    end

    # Search Articles
    # http://developer.helpscout.net/docs-api/articles/search/
    #
    # Search articles based upon a given query.
    #
    # query  String  the query being made
    #
    # Request 
    #  REST Method: GET
    #  URL: https://docsapi.helpscout.net/v1/search/articles.json
    #
    #  GET Parameters
    #  Name            Type
    #  conversationId  Int  id of the Conversation being requested
    #
    # Response
    #  Name  Type
    #  items ArticleRef
  end
end