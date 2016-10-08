class ConversionController < ApplicationController
  #caches_page require "game_controller"
  :data
    
  def index
    @all = Conversion.order(:category_id)
    @all.map {|c| c.amount = co2}
    
    respond_to do |format|
      format.xml {render :xml => @all.to_xml(:skip_types => true)  }
      format.json {render :json => @all.to_json  }
    end
    
  end

  def data
    ActiveRecord::Base.include_root_in_json = false
    
    @all = Conversion.order(:category_id)
    
    @all.map {|c| c.amount = co2}
      
   render json: @all

  end

  
  def show
    
    c = Conversion.find_by_slug(params[:id])
    
    c.amount = co2
    
    respond_to do |format|
      format.xml {render :xml => c.to_xml(:skip_types => true)  }
      format.json {render :json => c.to_json  }
    end
    
  end

  private
  
  def co2
    if !params[:co2].nil? and !params[:co2].blank?
      co2 = params[:co2].to_f
    else
      co2 = 1
    end
    return co2
  end
  
end
