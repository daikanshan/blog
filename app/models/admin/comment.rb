class Admin::Comment < ActiveRecord::Base
  belongs_to :message
  belongs_to :user
  has_many :subcomments, class_name: "Admin::Comment",
                    foreign_key: "supcomment_id"
  belongs_to :supcomment, class_name: "Admin::Comment"
end
