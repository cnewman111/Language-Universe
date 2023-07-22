class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  scope :visible_to_user, -> (user) {where('user_id == ?', user.id)}
end
