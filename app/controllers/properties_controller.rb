class PropertiesController < ApplicationController
    def index
        @properties = Property.where(active: true)
        render json: @properties
    end
    # GET /properties/1
    def show
        render json: @properties
    end

    def create
        return render status: :unauthorized unless #current_user.role_name == "Landlord"
        address = PropertyAddress.new(modify_params(params[:address],["name"]))
        return render json: {address: ["Incorrect data"]}, status: :unprocessable_entity unless address.save
        photos = params[:photo_url]
        #op_type = params[:operation_type]
        other_data_keys = ["bedrooms", "bathrooms", "area", "description", "active", "property_type_id"]
        other_data = property_params.select { |k, _v| other_data_keys.include?(k) }
        body = other_data.merge!({ photo_url: photos, property_address: address })
    
        @property = Property.new(body)
        if @property.save  
            render json: @property
        else
          render json: @property.errors, status: :unprocessable_entity
        end
    end

    def show
        property = Property.find(params[:id])
        render json: property
        # if property
        #     render json: property
        # else
        #     render json: {"message": "Property not found"}, status: :not_found
        # end    
    end

    def destroy
        property = properties.find(params[:id])
        property.destroy
    end    

    def update
        #return render status: :unauthorized #unless current_user.role_name == "Landlord"
        property = Property.find(params[:id])
        puts "Hola"
        puts property
        p json: property

        #address = PropertyAddress.find_by(id: property.property_address_id)
        #address.update(modify_params(params[:address],["name"])) if params[:address].present?
        #photos = params[:photo_url]
        #op_type = params[:operation_type]
        #other_data_keys = ["bedrooms", "bathrooms", "area", "description", "active", "property_type_id","property_address_id"]
        #other_data = property_params.select { |k, _v| other_data_keys.include?(k) }
    
        #body = photos.present? ? (other_data.merge!({ photo_url: photos })) : other_data
    #     if op_type.present?
    #      is_same_op_type = @property.operation_type[:type] == op_type[:type]
    #      change_op_type = is_same_op_type ? change_operation_data(op_type) : change_operation_type(op_type)
    #     else
    #       change_op_type = true
    #     end
    #     return render json: {operation_type: ["Incorrect data"]} unless body
        # if @property.update(body)
        #   render json: @property
        # else
        #    render json: @property.errors, status: :unprocessable_entity
        #  end
    end

    private

    def property_params
        params.permit(:bedrooms, :bathrooms, :area, :description, :active, :property_type_id, :property_address_id,
                      :photo_urls, :operation_type)
    end 

    #guarda nombre y direccion a una tabla hash
    def modify_params(hash, exceptions)
        keys = hash.keys
        new_hash = {}
        keys.each { |k| new_hash[k] = hash[k] }
        new_hash.map { |k, v| { k => exceptions.include?(k) ? v : v.to_f } }.reduce(:merge)
    end

    def change_operation_data(op_type)
        data = op_type.except("type")
        modified_data = modify_params(data,data.keys)
        case op_type[:type]
        when "for rent"
          model = PropertyForRent
        when "for sale"
          model = PropertyForSale
        else
          return false
        end
        prop = model&.find_by(property: @property)
        attrs = model&.attribute_names || []
        return false unless modified_data.keys.all?{|k| attrs.include?(k)}
        prop.update(modified_data) 
    end
    # def change_operation_type(op_type)
    #     data = op_type.except("type").merge!({ property_id: @property.id })
    #     modified_data = modify_params(data,data.keys)
    
    #     case op_type[:type]
    #     when "for rent"
    #       model = PropertyForRent
    #       other_model = PropertyForSale
    #     when "for sale"
    #       model = PropertyForSale
    #       other_model = PropertyForRent
    #     else
    #       return false
    #     end
       
    #     attrs = model&.attribute_names
    #     modified_data
    #     return false unless modified_data.keys.all?{|k| attrs&.include?(k)}
    #     new_prop = model.new(modified_data)
    #     new_prop.save
    #     other_model.destroy_by(property: @property) if new_prop.persisted?
    #     #UserProperty.create(user: current_user, ownable: new_prop) if new_prop.persisted?
    #     new_prop.persisted?
    # end
end
