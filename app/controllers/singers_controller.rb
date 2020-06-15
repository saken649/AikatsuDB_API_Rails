class SingersController < ApplicationController
  # 歌唱担当名前一覧
  def name_list
    render json: Singer.name_list
  end

  # 歌唱担当一覧
  def list
    render json: SingersService.list
  end

  # 歌唱担当名前
  def name
    render json: SingersService.singer_name(params[:singer_id])
  end
end