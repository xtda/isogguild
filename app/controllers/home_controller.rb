class HomeController < ApplicationController
  def index
    @frontpage = Setting.find_by(name: 'frontpage').settings['contents']
    @recruiting = Setting.find_by(name: 'recruiting').settings
  end
end
