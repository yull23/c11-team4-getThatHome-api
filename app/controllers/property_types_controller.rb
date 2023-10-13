class PropertyTypesController < ApplicationController
    def index
        @property_type = PropertyType.all 
        render json: @property_type
    end
end
