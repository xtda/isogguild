module Api
  module V1
    class BackgroundimageController < ApiController
      skip_before_action :authenticate_user

      def index
        image_path = Rails.root.join('app', 'javascript', 'images', 'backgrounds')
        total_backgrounds_in_path = Dir[File.join(image_path, '**', '*')].count { |file| File.file?(file) }
        image = "#{image_path}/bg#{rand(total_backgrounds_in_path)}.jpg"
        File.open(image, 'rb') do |f|
          send_data(f.read, type: 'image/jpeg', disposition: 'inline')
        end
      end
    end
  end
end
