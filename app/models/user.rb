class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessor :login
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_and_belongs_to_many :groups
  validates :username,
            :presence => true,
            :uniqueness => {
                :case_sensitive => false
            }

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_h).first
    end
  end

  def create_group(groupname)
    Group.create(name: groupname, owner_id: self.id)
  end

  def destroy_group(group)
    self.is_owner_of?(group) do
      group.destroy_self
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

  def is_owner_of?(group)
    if group.owner_id == self.id
      yield
    else
      raise 'You are not the owner of this group.'
    end
  end

  def create_bill(group, amount)
    if self.groups.include? group
    group.create_bill(self, amount)
    else
      raise 'You are not a member of this group.'
    end
  end
end
