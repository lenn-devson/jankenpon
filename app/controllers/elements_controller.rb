class ElementsController < ApplicationController
  before_action :set_element, only: [:show, :edit, :update, :destroy]

  # GET /elements
  # GET /elements.json
  def index
    @elements = Element.all
  end

  # GET /elements/1
  # GET /elements/1.json
  def show
  end

  # GET /elements/new
  def new
    @element = Element.new
    @elements = Element.where.not(id: @element.id)
  end

  # GET /elements/1/edit
  def edit
    @elements = Element.where.not(id: @element.id)
  end

  # POST /elements
  # POST /elements.json
  def create
    @element = Element.new(element_params)
    @elements = Element.where.not(id: @element.id)
    respond_to do |format|
      if @element.save
        win_params.each do |we|
          Win.create(element_id: @element.id, wins_against_id: we)
        end
        format.html { redirect_to @element, notice: 'Element was successfully created.' }
        format.json { render :show, status: :created, location: @element }
      else
        format.html { render :new }
        format.json { render json: @element.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /elements/1
  # PATCH/PUT /elements/1.json
  def update
    respond_to do |format|
      if @element.update(element_params)
        if win_params.sort != @element.win_elements.ids.sort
          Win.where(element_id: @element.id).destroy_all
          win_params.each do |we|
            win = Win.create(element_id: @element.id, wins_against_id: we)
          end
        end
        format.html { redirect_to @element, notice: 'Element was successfully updated.' }
        format.json { render :show, status: :ok, location: @element }
      else
        format.html { render :edit }
        format.json { render json: @element.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /elements/1
  # DELETE /elements/1.json
  def destroy
    @element.wins.destroy_all
    @element.destroy
    respond_to do |format|
      format.html { redirect_to elements_url, notice: 'Element was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_element
      @element = Element.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def element_params
      params.require(:element).permit(:title)
    end

    def win_params
      params.require(:element).permit(win_elements: [])[:win_elements].map(&:to_i)
    end
end
