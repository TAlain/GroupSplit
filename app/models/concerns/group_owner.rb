
module GroupOwner
  def create_group(groupname)
    Group.create(name: groupname, owner_id: self.id)
  end

  def destroy_group(group)
    self.is_owner_of?(group) do
      group.destroy
    end
  end

  def kick_multiple_members(member_ids,group)
    member_ids.each do |i|
      member = User.find(i)
      remove_member_from_group(member,group)
    end
  end

  def invite_member_to_group(new_member, group)
    self.is_owner_of?(group) do
      group.invite_member(new_member)
    end
  end

  def remove_member_from_group(member, group)
    self.is_owner_of?(group) do
      group.kick_member(member)
    end
  end

    protected
      def is_owner_of?(group)
        if group.owner_id == self.id
          yield
        else
          raise 'You are not the owner of this group.'
        end
      end
end