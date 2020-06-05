class CharactersController < ApplicationController
  # キャラクター名前一覧
  def name_list
    render json: Character.name_list
  end
end