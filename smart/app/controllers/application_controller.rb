class ApplicationController < ActionController::Base
  def index
    @acs = Ac.all
    @tvs = Tv.all
    @lights = Light.all
  end
end
