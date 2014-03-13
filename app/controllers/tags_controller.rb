# coding: utf-8 
class TagsController < ApplicationController
  # GET /tags
  # GET /tags.json
  before_filter :signed_in_user, only: [:create, :new, :edit, :update, :destroy]
  before_filter :admin_user, only: [:edit, :update, :destroy]
  
  # Before filter
  def admin_user
    unless current_user.is_admin?
      redirect_to tags_path, :notice => "Vous n'avez pas les droits pour supprimer un tag"
    end
  end
  

  
  def index
    
    @tagsearch = Tag.search(params[:search]) #pour la recherche
    @tagas = Tag.all
    q= params[:q]  
    logger.info "test c++"
    logger.info q
    logger.info "string :"
    logger.info q.to_s
    # autocompletion à partir de l'interface de recherche de bootstrap
    if params[:term]
      @tags = Tag.find(:all,:conditions => ['LOWER(name) LIKE LOWER(?)', "%#{params[:term]}%"])
      respond_to do |format|  
        format.html 
        logger.info 'json'
        logger.info @posts.to_json
        format.json { render :json => @tags.to_json }
      end	
    elsif params[:q] #autocompletion pour le champs du choix des tags dans le forumlaire questions
      @tags = Tag.where("name like ?", "%"+q.to_s+"%")
      respond_to do |format|
        format.html
        format.json { render :json => @tags.map(&:attributes) }
      end
    end
  end
  

  # GET /tags/1
  # GET /tags/1.json
  def show
    @tag= Tag.find(params[:id])
    @questions = @tag.questions
  end
  

  # GET /tags/new
  # GET /tags/new.json
  def new
    @tag = Tag.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tag }
    end
  end

  # GET /tags/1/edit
  def edit
    @tag = Tag.find(params[:id])
  end
  
  # POST /tags
  # POST /tags.json

  def create
    puts(params[:tag])
    @tag = Tag.new(params[:tag])
    
    respond_to do |format|
    if @tag.save
     
    format.html { redirect_to tags_path, :notice => "Votre tag a bien ete ajoute" }
        format.js

    else
      format.html { render "new"}
    end
end
  end
  
  # PUT /tags/1
  # PUT /tags/1.json
  def update
    @tag = Tag.find(params[:id])
    
    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to @tag, notice: 'Tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  
  def destroy
    tag = Tag.find( params[:id])
    if tag.destroy
      redirect_to tags_path, :notice => "Votre tag a bien ete supprimé"
    else
      redirect_to tags_path, :notice => "Votre tag n'a pas pu etre supprimee"
    end 
  end
  
    
end
