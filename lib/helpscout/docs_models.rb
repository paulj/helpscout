module HelpScout
  
    class Article
      attr_reader :id, :number, :collectionId, :slug, :status, :hasDraft, :name, :text, :code, :categories, :related, :publicUrl, :popularity, :viewCount, :createdBy, :updatedBy, :createdAt, :updatedAt, :lastPublishedAt

      def initialize(object)
        
          @id = 
            object['id']
          
        
          @number = 
            object['number']
          
        
          @collectionId = 
            object['collectionId']
          
        
          @slug = 
            object['slug']
          
        
          @status = 
            object['status']
          
        
          @hasDraft = 
            object['hasDraft']
          
        
          @name = 
            object['name']
          
        
          @text = 
            object['text']
          
        
          @code = 
            object['code']
          
        
          @categories = 
            object['categories']
          
        
          @related = 
            object['related']
          
        
          @publicUrl = 
            object['publicUrl']
          
        
          @popularity = 
            object['popularity']
          
        
          @viewCount = 
            object['viewCount']
          
        
          @createdBy = 
            object['createdBy']
          
        
          @updatedBy = 
            object['updatedBy']
          
        
          @createdAt = 
            DateTime.iso8601(object['createdAt']) if object['createdAt']
          
        
          @updatedAt = 
            DateTime.iso8601(object['updatedAt']) if object['updatedAt']
          
        
          @lastPublishedAt = 
            DateTime.iso8601(object['lastPublishedAt']) if object['lastPublishedAt']
          
        
      end
    end
  
    class ArticleRef
      attr_reader :id, :number, :collectionId, :slug, :status, :hasDraft, :name, :publicUrl, :popularity, :viewCount, :createdBy, :updatedBy, :createdAt, :updatedAt, :lastPublishedAt

      def initialize(object)
        
          @id = 
            object['id']
          
        
          @number = 
            object['number']
          
        
          @collectionId = 
            object['collectionId']
          
        
          @slug = 
            object['slug']
          
        
          @status = 
            object['status']
          
        
          @hasDraft = 
            object['hasDraft']
          
        
          @name = 
            object['name']
          
        
          @publicUrl = 
            object['publicUrl']
          
        
          @popularity = 
            object['popularity']
          
        
          @viewCount = 
            object['viewCount']
          
        
          @createdBy = 
            object['createdBy']
          
        
          @updatedBy = 
            object['updatedBy']
          
        
          @createdAt = 
            DateTime.iso8601(object['createdAt']) if object['createdAt']
          
        
          @updatedAt = 
            DateTime.iso8601(object['updatedAt']) if object['updatedAt']
          
        
          @lastPublishedAt = 
            DateTime.iso8601(object['lastPublishedAt']) if object['lastPublishedAt']
          
        
      end
    end
  
    class ArticleRevision
      attr_reader :id, :articleId, :text, :createdBy, :createdAt

      def initialize(object)
        
          @id = 
            object['id']
          
        
          @articleId = 
            object['articleId']
          
        
          @text = 
            object['text']
          
        
          @createdBy = 
            object['createdBy']
          
        
          @createdAt = 
            DateTime.iso8601(object['createdAt']) if object['createdAt']
          
        
      end
    end
  
    class ArticleRevisionRef
      attr_reader :id, :articleId, :createdBy, :createdAt

      def initialize(object)
        
          @id = 
            object['id']
          
        
          @articleId = 
            object['articleId']
          
        
          @createdBy = 
            object['createdBy']
          
        
          @createdAt = 
            DateTime.iso8601(object['createdAt']) if object['createdAt']
          
        
      end
    end
  
    class ArticleSearch
      attr_reader :id, :collectionId, :categoryIds, :slug, :name, :preview, :url, :docsUrl, :number, :status, :visibility

      def initialize(object)
        
          @id = 
            object['id']
          
        
          @collectionId = 
            object['collectionId']
          
        
          @categoryIds = 
            object['categoryIds']
          
        
          @slug = 
            object['slug']
          
        
          @name = 
            object['name']
          
        
          @preview = 
            object['preview']
          
        
          @url = 
            object['url']
          
        
          @docsUrl = 
            object['docsUrl']
          
        
          @number = 
            object['number']
          
        
          @status = 
            object['status']
          
        
          @visibility = 
            object['visibility']
          
        
      end
    end
  
    class Category
      attr_reader :id, :number, :slug, :collectionId, :order, :name, :createdBy, :updatedBy, :createdAt, :uppdatedAt

      def initialize(object)
        
          @id = 
            object['id']
          
        
          @number = 
            object['number']
          
        
          @slug = 
            object['slug']
          
        
          @collectionId = 
            object['collectionId']
          
        
          @order = 
            object['order']
          
        
          @name = 
            object['name']
          
        
          @createdBy = 
            object['createdBy']
          
        
          @updatedBy = 
            object['updatedBy']
          
        
          @createdAt = 
            DateTime.iso8601(object['createdAt']) if object['createdAt']
          
        
          @uppdatedAt = 
            DateTime.iso8601(object['uppdatedAt']) if object['uppdatedAt']
          
        
      end
    end
  
    class Collection
      attr_reader :id, :number, :siteId, :slug, :visibility, :order, :name, :createdBy, :updatedBy, :createdAt, :uppdatedAt

      def initialize(object)
        
          @id = 
            object['id']
          
        
          @number = 
            object['number']
          
        
          @siteId = 
            object['siteId']
          
        
          @slug = 
            object['slug']
          
        
          @visibility = 
            object['visibility']
          
        
          @order = 
            object['order']
          
        
          @name = 
            object['name']
          
        
          @createdBy = 
            object['createdBy']
          
        
          @updatedBy = 
            object['updatedBy']
          
        
          @createdAt = 
            DateTime.iso8601(object['createdAt']) if object['createdAt']
          
        
          @uppdatedAt = 
            DateTime.iso8601(object['uppdatedAt']) if object['uppdatedAt']
          
        
      end
    end
  
    class Person
      attr_reader :id, :firstName, :lastName

      def initialize(object)
        
          @id = 
            object['id']
          
        
          @firstName = 
            object['firstName']
          
        
          @lastName = 
            object['lastName']
          
        
      end
    end
  
    class Site
      attr_reader :id, :status, :subDomain, :cname, :hasPublicSite, :companyName, :title, :logoUrl, :logoWidth, :logoHeight, :favIconUrl, :touchIconUrl, :homeUrl, :homeLinkText, :bgColor, :description, :hasContactForm, :mailboxId, :contactEmail, :styleSheetUrl, :headerCode, :createdBy, :updatedBy, :createdAt, :updatedAt

      def initialize(object)
        
          @id = 
            object['id']
          
        
          @status = 
            object['status']
          
        
          @subDomain = 
            object['subDomain']
          
        
          @cname = 
            object['cname']
          
        
          @hasPublicSite = 
            object['hasPublicSite']
          
        
          @companyName = 
            object['companyName']
          
        
          @title = 
            object['title']
          
        
          @logoUrl = 
            object['logoUrl']
          
        
          @logoWidth = 
            object['logoWidth']
          
        
          @logoHeight = 
            object['logoHeight']
          
        
          @favIconUrl = 
            object['favIconUrl']
          
        
          @touchIconUrl = 
            object['touchIconUrl']
          
        
          @homeUrl = 
            object['homeUrl']
          
        
          @homeLinkText = 
            object['homeLinkText']
          
        
          @bgColor = 
            object['bgColor']
          
        
          @description = 
            object['description']
          
        
          @hasContactForm = 
            object['hasContactForm']
          
        
          @mailboxId = 
            object['mailboxId']
          
        
          @contactEmail = 
            object['contactEmail']
          
        
          @styleSheetUrl = 
            object['styleSheetUrl']
          
        
          @headerCode = 
            object['headerCode']
          
        
          @createdBy = 
            object['createdBy']
          
        
          @updatedBy = 
            object['updatedBy']
          
        
          @createdAt = 
            DateTime.iso8601(object['createdAt']) if object['createdAt']
          
        
          @updatedAt = 
            DateTime.iso8601(object['updatedAt']) if object['updatedAt']
          
        
      end
    end
  
end