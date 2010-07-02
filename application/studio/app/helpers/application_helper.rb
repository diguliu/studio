# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def is_admin?(user)
    user.role_symbols.include?(:admin)
  end

end
