class RelevantLinksController < ApplicationController
  before_action :set_relevant_link, only: [:show, :edit, :update, :destroy]

  # GET /relevant_links
  # GET /relevant_links.json
  def index
    @relevant_links = RelevantLink.all
  end

  # GET /relevant_links/1
  # GET /relevant_links/1.json
  def show
  end

  # GET /relevant_links/new
  def new
    @relevant_link = RelevantLink.new
  end

  # GET /relevant_links/1/edit
  def edit
  end

  # POST /relevant_links
  # POST /relevant_links.json
  def create
    @relevant_link = RelevantLink.new(relevant_link_params)

    respond_to do |format|
      if @relevant_link.save
        format.html { redirect_to :back, notice: 'Relevant link was successfully created.' }
        format.json { render :show, status: :created, location: @relevant_link }
      else
        format.html { render :back }
        format.json { render json: @relevant_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /relevant_links/1
  # PATCH/PUT /relevant_links/1.json
  def update
    respond_to do |format|
      if @relevant_link.update(relevant_link_params)
        format.html { redirect_to @relevant_link, notice: 'Relevant link was successfully updated.' }
        format.json { render :show, status: :ok, location: @relevant_link }
      else
        format.html { render :edit }
        format.json { render json: @relevant_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /relevant_links/1
  # DELETE /relevant_links/1.json
  def destroy
    @relevant_link.destroy
    respond_to do |format|
      format.html { redirect_to relevant_links_url, notice: 'Relevant link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_relevant_link
      @relevant_link = RelevantLink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def relevant_link_params
      params.require(:relevant_link).permit(:title, :source, :review_post_id, :link_type)
    end
end
