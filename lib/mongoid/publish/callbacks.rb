module Mongoid
  module Publish
    module Callbacks
      extend ActiveSupport::Concern
      
      CALLBACKS = [
        :after_publish,
        :before_publish,
        :after_unpublish,
        :before_unpublish
      ].freeze

      included do
        extend ActiveModel::Callbacks

        define_model_callbacks :publish, :unpublish

        def publish!
          run_callbacks(:publish) { super }
        end

        def unpublish!
          run_callbacks(:unpublish) { super }
        end

      end
    end
  end
end
