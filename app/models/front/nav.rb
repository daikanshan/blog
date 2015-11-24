class Front::Nav < ActiveRecord::Base
  has_many :subnavs, class_name: "Front::Nav",
                    foreign_key: "supnav_id"
  belongs_to :supnav, class_name: "Front::Nav"
  belongs_to :user, class_name: "Admin::User"
  def path
    controller, action = self.url.split('/')
    options = {controller: 'front/' + controller, action: action}
    options = {controller: 'admin/home', action: action} if controller == 'admin'
    options
  end
end
