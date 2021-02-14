class LightsController < ApplicationController
  before_action :set_light, only: %i[ show edit update destroy ]

  # GET /lights or /lights.json
  def index
    @lights = Light.all
  end

  # GET /lights/1 or /lights/1.json
  def show
  end

  # GET /lights/new
  def new
    @light = Light.new
  end

  # GET /lights/1/edit
  def edit
  end

  # POST /lights or /lights.json
  def create
    @light = Light.new(light_params)

    respond_to do |format|
      if @light.save
        format.html { redirect_to @light, notice: "Light was successfully created." }
        format.json { render :show, status: :created, location: @light }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @light.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lights/1 or /lights/1.json
  def update
    message = Request.encode(Request.new(light_update: @light.to_protobuf))
    ::GATEWAY.puts(message.size)
    ::GATEWAY.write(message)
    redirect_to root_path, notice: "Sent update to #{@light.name}"
  end

  # DELETE /lights/1 or /lights/1.json
  def destroy
    @light.destroy
    respond_to do |format|
      format.html { redirect_to lights_url, notice: "Light was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_light
      @light = Light.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def light_params
      params.require(:light).permit(:brightness, :color)
    end
end
