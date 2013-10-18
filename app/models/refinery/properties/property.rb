module Refinery
  module Properties
    class Property < Refinery::Core::BaseModel
      self.table_name = 'refinery_properties'

      attr_accessible :address, :rent_amount, :region, :city, :suburb, :description, :bedrooms, :available_from, :active, :position

      validates :address, :presence => true, :uniqueness => true
    end
  end
end
