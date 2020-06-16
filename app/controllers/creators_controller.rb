class CreatorsController < ApplicationController
  # TODO: 一旦やらないが、作曲石濱翔、編曲田中秀和、といったような担当別の検索も実現する

  def list
    render json: CreatorsService.list
  end

  def name
    render json: CreatorsService.name(params[:creator_id])
  end
end