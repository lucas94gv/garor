# frozen_string_literal: true

# ApplicationRecord is the base class for all models in the application.
# It extends ActiveRecord::Base and includes common functionality that
# is shared among all models.
#
# All shared model-level configurations, associations, and behavior should
# be defined here to maintain consistency across the application.
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
