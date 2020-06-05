class SingersController < ApplicationController
  # 歌唱担当名前一覧
  def name_list
    render json: Singer.name_list
  end
end