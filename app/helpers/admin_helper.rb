module AdminHelper
  def active_link(controller)
    'active' if params[:controller] == controller
  end
end
