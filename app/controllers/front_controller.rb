class FrontController < ApplicationController
  before_action :set_nav

  private
    def set_nav
      @topnavs = Front::Nav.where(level:0).order("weight ASC")
    end
end
