class SongCreator < ApplicationRecord
  # cf. https://qiita.com/ryonext/items/1a813639ab2a2a00058e
  self.inheritance_column = :_type_disabled
end