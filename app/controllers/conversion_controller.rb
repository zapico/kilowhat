class ConversionController < ApplicationController
  #caches_page :data
    
  def index
    @all = Conversion.all
    @all.map {|c| c.amount = kwh}
    
    respond_to do |format|
      format.xml {render :xml => @all.to_xml(:skip_types => true)  }
      format.json {render :json => @all.to_json  }
    end
    
  end

  def data
    ActiveRecord::Base.include_root_in_json = false
    
    @all = Conversion.all
    
    @all.map {|c| c.amount = kwh}
      
    respond_to do |format|
      format.js {render :layout => false }
    end
  end

  
  def show
    
    c = Conversion.find_by_slug(params[:id])
    
    c.amount = kwh
    
    respond_to do |format|
      format.xml {render :xml => c.to_xml(:skip_types => true)  }
      format.json {render :json => c.to_json  }
    end
    
  end

  private
  
  def kwh
    if !params[:kwh].nil? and !params[:kwh].blank?
      kwh = params[:kwh].to_f
    else
      kwh = 1
    end
    return kwh
  end
  
end
