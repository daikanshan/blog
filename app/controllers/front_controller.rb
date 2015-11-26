class FrontController < ApplicationController
  before_action :set_nav
  before_action :set_side_bar

  private
    def set_nav
      @topnavs = Front::Nav.where(level:0).order("weight ASC")
    end
    def set_side_bar
      @categories = Admin::Category.all
      @latest_messages = Admin::Message.all.limit(10)
      @tags = Admin::Tag.all
    end
end
