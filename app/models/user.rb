class User < ActiveRecord::Base
  include GroupOwner
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable, :recoverable
  has_and_belongs_to_many :groups
  validates :username,
            :presence => true,
            :uniqueness => {
                :case_sensitive => false
            }
  validate :check_empty_space
  before_save :capitalize_names


  def check_empty_space
    if username.match(/\s+/)
      errors.add(:attribute, "No empty spaces please")
    end
  end

  def capitalize_names
    username.capitalize!
  end

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username.downcase]).first
      end
    end
  end

  def leave_group(group)
    group.users.delete(self) if group.users.include? self
    group.bills.where(user_id: self.id).destroy_all
  end

end
