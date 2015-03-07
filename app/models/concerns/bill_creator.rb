module BillCreator
  def create_bill(group, amount)
    if self.groups.include? group
      group.create_bill(self, amount)
    else
      raise 'You are not a member of this group.'
    end
  end
end