module ValueObjects
  class Singer
    attr_reader :singer_id,
                :display_name,
                :group_name,
                :display_order,
                :group_displayable,
                :delimiter_to_next

    def initialize(
      singer_id:,
      display_name:,
      group_name:,
      display_order:,
      group_displayable:,
      delimiter_to_next:
    )
      @singer_id = singer_id
      @display_name = display_name
      @group_name = group_name
      @display_order = display_order
      @group_displayable = group_displayable == 1
      @delimiter_to_next = delimiter_to_next
    end
  end
end
