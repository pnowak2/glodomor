class PropertiesController < ApplicationController
  before_filter :require_user_admin
  
  # GET /properties
  # GET /properties.xml
  def index
    @product = Product.find(params[:product_id])
    @properties = Property.find_all_by_product_id(@product)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @properties }
    end
  end

  # GET /properties/1
  # GET /properties/1.xml
  def show
    @property = Property.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @property }
    end
  end

  # GET /properties/new
  # GET /properties/new.xml
  def new
    @product = Product.find(params[:product_id])
    @property = Property.new(:product_id => @product.id)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @property }
    end
  end

  # GET /properties/1/edit
  def edit
    @property = Property.find(params[:id])
    @product = Product.find(params[:product_id])
  end

  # POST /properties
  # POST /properties.xml
  def create
    @property = Property.new(params[:property])

    respond_to do |format|
      if @property.save
        flash[:notice] = 'Property was successfully created.'
        format.html { redirect_to(product_property_path(@property.product, @property)) }
        format.xml  { render :xml => @property, :status => :created, :location => @property }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @property.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /properties/1
  # PUT /properties/1.xml
  def update
    @property = Property.find(params[:id])
    
    respond_to do |format|
      if @property.update_attributes(params[:property])
        flash[:notice] = 'Property was successfully updated.'
        format.html { redirect_to(product_property_path(@property.product, @property)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @property.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.xml
  def destroy
    @property = Property.find(params[:id])
    @property.destroy
    product = @property.product

    respond_to do |format|
      format.html { redirect_to(product_properties_url(product)) }
      format.xml  { head :ok }
    end
  end
end
