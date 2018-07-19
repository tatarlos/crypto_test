class CrpytoInfosController < ApplicationController
    # before_action :set_crpyto_info, only: [:show, :edit, :update, :destroy]

  # gets ticker info from apis
  def get_ti
    data = params['crpyto_info']
    info = CryptoApis.new
    ticker = info.set_ticker(data['ticker'])
    if ticker
      json = {
          coin:data['ticker'],
          market_cap:info.percent_marketcap,
          market_rank: info.top_fifty?,
          alltime_high: info.alltime_high
      }
      p json
      respond_to do |format|
        format.json { render json: json  }
      end
    else
      respond_to do |format|
        format.json { render json: {error:'there was a issue finding your coin please enter full name'}  }
      end
    end

  end

  # GET /crpyto_infos
  # GET /crpyto_infos.json
  def index
    @crpyto_infos = CrpytoInfo.all
  end

  # GET /crpyto_infos/1
  # GET /crpyto_infos/1.json
  def show
  end

  # GET /crpyto_infos/new
  def new
    @crpyto_info = CrpytoInfo.new
  end

  # GET /crpyto_infos/1/edit
  def edit
  end

  # POST /crpyto_infos
  # POST /crpyto_infos.json
  def create
    @crpyto_info = CrpytoInfo.new(crpyto_info_params)

    respond_to do |format|
      if @crpyto_info.save
        format.html { redirect_to @crpyto_info, notice: 'Crpyto info was successfully created.' }
        format.json { render :show, status: :created, location: @crpyto_info }
      else
        format.html { render :new }
        format.json { render json: @crpyto_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /crpyto_infos/1
  # PATCH/PUT /crpyto_infos/1.json
  def update
    respond_to do |format|
      if @crpyto_info.update(crpyto_info_params)
        format.html { redirect_to @crpyto_info, notice: 'Crpyto info was successfully updated.' }
        format.json { render :show, status: :ok, location: @crpyto_info }
      else
        format.html { render :edit }
        format.json { render json: @crpyto_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /crpyto_infos/1
  # DELETE /crpyto_infos/1.json
  def destroy
    @crpyto_info.destroy
    respond_to do |format|
      format.html { redirect_to crpyto_infos_url, notice: 'Crpyto info was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_crpyto_info
      @crpyto_info = CrpytoInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def crpyto_info_params
      params.require(:crpyto_info).permit(:ticker, :date)
    end
end
