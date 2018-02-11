module Admin
  class FrontpageController < AdminController
    def index
      render plain: 'okay'
    end

    def edit
      @frontpage = Setting.find_by(name: 'frontpage').settings['contents']
    end

    def update
      @frontpage = Setting.find_by(name: 'frontpage')
      new_contents = JSON.parse("{\"contents\": \"#{params[:contents]}\"}")
      @frontpage.settings = new_contents
      if @frontpage.save
        flash[:success] = 'Frontpage updated'
        redirect_to admin_frontpage_edit_path
      end
    end
  end
end
