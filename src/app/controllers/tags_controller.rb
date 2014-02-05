class TagsController < ApplicationController
  # GET /tags
  # GET /tags.json
 
def index
@tagas = Tag.all
q= params[:q]  
logger.info "test c++"
logger.info q
logger.info "string :"
logger.info q.to_s
@tags = Tag.where("name like ?", "%"+q.to_s+"%")
  respond_to do |format|
    format.html
    format.json { render :json => @tags.map(&:attributes) }
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
    if @tag.save
      redirect_to tags_path, :notice => "Votre tag a bien ete ajoute"
    else
      render "new"
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
      redirect_to tags_path, :notice => "Votre tag a bien eté supprimee"
    else
      redirect_to tags_path, :notice => "Votre tag n'a pas pu etre supprimee"
    end 
  end
  
    
end
