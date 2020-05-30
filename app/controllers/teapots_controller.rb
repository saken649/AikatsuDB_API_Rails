class TeapotsController < ApplicationController
  def index
    render json: { msg: "I'm a teapot." }, status: 418
  end
end
