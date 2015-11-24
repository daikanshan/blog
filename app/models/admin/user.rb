class Admin::User < ActiveRecord::Base
  has_many :messages
  has_many :comments
  has_many :navs,class_name:"Front::Nav"
  validates :username, presence:true,length:{maximum:30}
  validates :realname, presence:true,length:{maximum:15}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/
  validates :email, length:{maximum:255},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness:{case_senstive: false},
            allow_blank:true
  has_secure_password
  validates_length_of :password,minimum: 6, allow_blank:true,on: [:update]
  validates_length_of :password,minimum: 6, on: [:create]

  after_destroy :ensure_an_admin_remains

  def ensure_an_admin_remains
    if Admin::User.count.zero?
      raise "不能删除最后一个用户"
    end
  end
end
