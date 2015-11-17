class AdminController < ApplicationController
  before_action :set_nav

  private
    def set_nav
      @navs = []
      raw = YAML.load(File.read('config/extra/admin_nav.yml'))["nav"]
      raw.each do |item|
        controller, action = item["path"].split('/')
        @navs << {text: item["text"], icon: item["icon"], options: {controller: 'admin/' + controller, action: action}}
      end
      @navs
    end
end
