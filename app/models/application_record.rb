class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # rescue_from CanCan::AccessDenied do |exception|
  #   redirect_to root_path, :alert => exception.message
  # end
end
