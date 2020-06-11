namespace :generate_search_keywords do
  task :exec do
    puts 'Generate Search Keywords...'

    # 曲名＆曲名（かな）
    songs = Song.all.map do |song|
      if song.parent_song_id.present?
        parent = Song.find_by(id: song.parent_song_id)

        title = "#{parent.title}#{song.sub_title}"
        title_kana = parent.title_kana
      else
        title = song.title
        title_kana = song.title_kana
      end

      [
        { keyword: title, related_table: 'songs', related_key: song.id },
        { keyword: title_kana, related_table: 'songs', related_key: song.id },
      ]
    end.flatten
    Search.insert_all(songs)

    # 歌唱担当
    # display_name, name, name_kana
    singers = Singer.eager_load(:group).where.not(display_name: nil).order('singers.order ASC').map do |singer|
      if singer.parent_singer_id.present?
        parent = Singer.find_by(id: singer.parent_singer_id)

        name = "#{parent.name_family}#{parent.name_first}"
        name_kana = "#{parent.name_family_kana}#{parent.name_first_kana}"
        # TODO: 成瀬瑛美さん（えいみ）など、from いらない方々どうする？
        display_name = "#{singer.display_name} from #{singer.group.name}"
      else
        name = "#{singer.name_family}#{singer.name_first}"
        name_kana = "#{singer.name_family_kana}#{singer.name_first_kana}"
        display_name = "#{singer.display_name} from #{singer.group.name}"
      end

      [
        { keyword: name, related_table: 'singers', related_key: singer.id},
        { keyword: name_kana, related_table: 'singers', related_key: singer.id},
        { keyword: display_name, related_table: 'singers', related_key: singer.id}
      ]
    end.flatten
    Search.insert_all(singers)

    # グループ
    groups = Group.all.map do |g|
      { keyword: g.name, related_table: 'groups', related_key: g.id}
    end
    Search.insert_all(groups)

    # キャラクター名（かな、中の人含む）
    characters = Character.all.order('characters.order ASC').map do |c|
      [
        { keyword: "#{c.name_family}#{c.name_first}", related_table: 'characters', related_key: c.id},
        { keyword: "#{c.name_family_kana}#{c.name_first_kana}", related_table: 'characters', related_key: c.id},
        { keyword: "#{c.voice_actor_family}#{c.voice_actor_first}", related_table: 'characters', related_key: c.id},
        { keyword: "#{c.voice_actor_family_kana}#{c.voice_actor_first_kana}", related_table: 'characters', related_key: c.id}
      ]
    end.flatten
    Search.insert_all(characters)

    # クリエイター名（かな含む）
    creators = Creator.eager_load(:production).all.map do |c|
      name = c.artist_name.present? ? c.artist_name : "#{c.name_family}#{c.name_first}"
      name = "#{name} (#{c.production.name})" if c.production_id.present?

      name_kana = c.artist_name_kana.present? ? c.artist_name_kana : "#{c.name_family_kana}#{c.name_first_kana}"

      [
        { keyword: name, related_table: 'creators', related_key: c.id},
        { keyword: name_kana, related_table: 'creators', related_key: c.id},
      ]
    end.flatten
    Search.insert_all(creators)

    # プロダクション
    productions = Production.all.map do |p|
      { keyword: p.name, related_table: 'productions', related_key: p.id}
    end
    Search.insert_all(productions)

    # アルバム名、サブタイトル名、発売日
    albums = Album.all.order('albums.sold_date ASC').map do |a|
      [
        { keyword: a.title, related_table: 'albums', related_key: a.id},
        { keyword: a.sub_title, related_table: 'albums', related_key: a.id},
        { keyword: a.sold_date, related_table: 'albums', related_key: a.id}
      ]
    end.flatten
    Search.insert_all(albums)

    puts 'done! Kyaha!'
  end
end
