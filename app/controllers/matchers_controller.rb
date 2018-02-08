class MatchersController < ApplicationController
  before_action :set_matcher, only: [:show, :edit, :update, :destroy]

  # GET /matchers
  # GET /matchers.json
  def index
    @matchers = Matcher.all
  end

  # GET /matchers/1
  # GET /matchers/1.json
  def show
  end

  # GET /matchers/new
  def new
    @matcher = Matcher.new
  end

  # GET /matchers/1/edit
  def edit
  end

  # POST /matchers
  # POST /matchers.json
  def create
    @matcher = Matcher.new(matcher_params)

    respond_to do |format|
      if @matcher.save
        format.html { redirect_to @matcher, notice: 'Matcher was successfully created.' }
        format.json { render :show, status: :created, location: @matcher }
      else
        format.html { render :new }
        format.json { render json: @matcher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /matchers/1
  # PATCH/PUT /matchers/1.json
  def update
    respond_to do |format|
      if @matcher.update(matcher_params)
        format.html { redirect_to @matcher, notice: 'Matcher was successfully updated.' }
        format.json { render :show, status: :ok, location: @matcher }
      else
        format.html { render :edit }
        format.json { render json: @matcher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matchers/1
  # DELETE /matchers/1.json
  def destroy
    @matcher.destroy
    respond_to do |format|
      format.html { redirect_to matchers_url, notice: 'Matcher was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_matcher
      @matcher = Matcher.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def matcher_params
      params.require(:matcher).permit(:uri_pattern, :url_replacement_pattern, :name, :priority)
    end
end
