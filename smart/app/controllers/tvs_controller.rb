class TvsController < ApplicationController
  before_action :set_tv, only: %i[ show edit update destroy ]

  # GET /tvs or /tvs.json
  def index
    @tvs = Tv.all
  end

  # GET /tvs/1 or /tvs/1.json
  def show
  end

  # GET /tvs/new
  def new
    @tv = Tv.new
  end

  # GET /tvs/1/edit
  def edit
  end

  # POST /tvs or /tvs.json
  def create
    @tv = Tv.new(tv_params)

    respond_to do |format|
      if @tv.save
        format.html { redirect_to @tv, notice: "Tv was successfully created." }
        format.json { render :show, status: :created, location: @tv }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tv.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tvs/1 or /tvs/1.json
  def update
    message = Request.encode(Request.new(tv_update: @tv.to_protobuf))
    ::GATEWAY.puts(message.size)
    ::GATEWAY.write(message)
    redirect_to root_path, notice: "Sent update to #{@tv.name}"
  end

  # DELETE /tvs/1 or /tvs/1.json
  def destroy
    @tv.destroy
    respond_to do |format|
      format.html { redirect_to tvs_url, notice: "Tv was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tv
      @tv = Tv.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tv_params
      params.require(:tv).permit(:channel, :volume, :status)
    end
end
