class Front::Nav < ActiveRecord::Base
  has_many :subnavs, class_name: "Front::Nav",
                    foreign_key: "supnav_id"
  belongs_to :supnav, class_name: "Front::Nav"
  belongs_to :user, class_name: "Admin::User"
  validates :text,presence:true
  before_create :check_url

  def check_url
    if self.url.nil?||self.url==""#为空
      self.url = root_url
      return
    end
    if self.url =~ /^http/ #外链
      return
    end
    if self.url =~ /^\// #内链
      return
    end
    self.url = "http://"+self.url #外链简写
  end

  def path
    controller, action = self.url.split('/')
    options = {controller: 'front/' + controller, action: action}
    options = {controller: 'admin/home', action: action} if controller == 'admin'
    options
  end
end
