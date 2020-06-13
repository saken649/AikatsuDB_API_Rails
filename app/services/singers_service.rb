class SingersService
  class << self
    def list
      singers = Singer.list
      group_by_group(singers)
    end

    private

    def group_by_group(singers)
      grouped = singers.group_by { |s| s.group_id }
      groups = Group.all.order('`groups`.`order` ASC').to_a.push(nil)

      ret = []
      groups.each do |g|
        key = g.nil? ? nil : g.id
        next if grouped[key].nil?

        ret.push({
          group_id: key,
          group_name: g.nil? ? 'その他' : g.name,
          singers: singers(grouped[key])
        })
      end
      ret
    end

    def singers(singers)
      singers.sort_by { |s| s.order }
             .map do |s|
               name = s.parent_singer_id.present? ? s.singers_parent.name : s.name
               ::ValueObjects::SingerAbout.new(singer_id: s.id, name: name, display_name: s.display_name, is_current: s.is_current)
             end
    end
  end
end