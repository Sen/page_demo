class Api::PagesController < ApplicationController
  respond_to :json, :xml

  # GET /pages.xml
  # GET /pages.json
  def index
    @pages = Page.all

    respond_to do |format|
      format.json { render json: @pages }
      format.xml  { render xml: @pages }
    end
  end

  # GET /pages/1.xml
  # GET /pages/1.json
  def show
    @page = Page.find(params[:id])

    respond_to do |format|
      format.json { render json: @page }
      format.xml  { render xml: @page }
    end
  end

  # GET /pages/new.xml
  # GET /pages/new.json
  def new
    @page = Page.new

    respond_to do |format|
      format.json { render json: @page }
      format.xml  { render xml: @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages.xml
  # POST /pages.json
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        format.json { render json: @page, status: :created, location: [:api, @page] }
        format.xml  { render xml: @page,  status: :created, location: [:api, @page] }
      else
        format.json { render json: @page.errors, status: :unprocessable_entity }
        format.xml  { render xml: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1.xml
  # PUT /pages/1.json
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.json { head :no_content }
        format.xml { head :no_content }
      else
        format.json { render json: @page.errors, status: :unprocessable_entity }
        format.xml  { render xml: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1.xml
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end

  def published
    @pages = Page.published
    respond_with @pages
  end

  def unpublished
    @pages = Page.unpublished

    respond_with @pages
  end

  def publish
    @page = Page.find(params[:id])
    @page.publish

    head :ok
  end

  def total_words
    @page = Page.find(params[:id])

    respond_with @page.count_words
  end
end
