class HomeController < ApplicationController
  def index
    @frontpage = Setting.find_by(name: 'frontpage').settings['contents']
    
  end
end
