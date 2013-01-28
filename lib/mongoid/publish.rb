module Mongoid
  module Publish
    extend ActiveSupport::Concern

    included do
      field :published_at, :type => DateTime
      field :published,    :type => Boolean, :default => false
      
      scope :published, where(:published => true )
      scope :published_and_orderly, where(:published => true).desc(:published_at, :created_at)

      before_save :set_published_at
    end

    include Mongoid::Publish::Callbacks

    def published?
      return true if self.published && self.published_at && self.published_at <= DateTime.now
      false
    end

    def publish!
      self.published    = true
      self.published_at = DateTime.now
      self.save
    end
    
    def publication_status
      self.published? ? self.published_at.to_date : "draft"
    end

    private
    def set_published_at
      self.published_at = DateTime.now if self.published && self.published_at.nil?
    end

    module ClassMethods
    end

  end
end
