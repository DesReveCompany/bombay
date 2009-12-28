class User < ActiveRecord::Base
  has_attached_file :avatar,
                    :styles => { :large => "96x96", :medium => "48x48", :small => "24x24"},
                    :default_url => "/system/:attachment/default_:style.jpg",
                    :path => ":rails_root/public/system/:attachment/:id/:style/:basename.:extension"

  # new columns need to be added here to be writable through mass assignment
  # attr_accessible :username, :email, :password, :password_confirmation

  attr_accessor :password
  before_save :prepare_password

  validates_presence_of :username
  validates_uniqueness_of :username, :email, :allow_blank => true
  validates_format_of :username, :with => /^[-\w\_@]+$/i, :allow_blank => false, :message => "should only contain letters, numbers, or -_@"
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true
  validates_exclusion_of :username, :in => %w( admin superuser following follower administrator root), :message => "is not a usable username"


  has_many :flits, :dependent => :destroy
  has_many :friendships
  has_many :friends, :through => :friendships

  def add_friend(friend)
    friendship = friendships.build(:friend_id => friend.id)
    if !friendship.save
      logger.debug "User '#{ friend.email}' already exists in the user's friendship list."
    end
  end

  def remove_friend(friend)
    friendship = Friendship.find(:first, :conditions => ["user_id = ? and friend_id = ?", self.id, friend.id])
    if friendship
      friendship.destroy
    end
  end

  def friends_of
    Friendship.find(:all, :conditions => ["friend_id = ?", self.id]).map{|f|f.user}
  end

  def is_friend?(friend)
    return self.friends.include? friend
  end

  def all_flits
    Flit.find(:all, :order => "id desc", :limit => 20)
  end

  def user_and_friends_flits
    Flit.find(:all, :conditions => ["user_id in (?)", friends.map(&:id).push(self.id)], :order => "id desc")
  end

  def user_flits
    Flit.find(:all, :conditions => ["user_id in (?)", self.id], :order => "id desc")
  end

  def full_name
    [first_name, last_name].join(" ")
  end

  def self.find_user(user_id)
    user = self.find_by_id(user_id)
    return user.username
  end

  def self.find_by_search_query(q)
    User.find(:all, :conditions => ["username like ?", "%#{q}%"])
  end


  # login can be either username or email address
  def self.authenticate(login, pass)
    user = find_by_username(login) || find_by_email(login)
    return user if user && user.matching_password?(pass)
  end

  def matching_password?(pass)
    self.password_hash == encrypt_password(pass)
  end

  private

  def prepare_password
    unless password.blank?
      self.password_salt = Digest::SHA1.hexdigest([Time.now, rand].join)
      self.password_hash = encrypt_password(password)
    end
  end

  def encrypt_password(pass)
    Digest::SHA1.hexdigest([pass, password_salt].join)
  end
end
