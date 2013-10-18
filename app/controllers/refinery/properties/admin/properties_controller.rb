module Refinery
  module Properties
    module Admin
      class PropertiesController < ::Refinery::AdminController

        crudify :'refinery/properties/property',
                :title_attribute => 'address',
                :xhr_paging => true

      end
    end
  end
end
