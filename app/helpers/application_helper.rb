module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Moto Share'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def toastr_flash
    flash.each_with_object([]) do |(type, message), flash_messages|
      type = 'bg-success' if type == 'notice'
      type = 'bg-danger' if type == 'alert'
      text = "<div class='toast align-items-center text-white #{type} border-0 position-absolute m-3 bottom-0 end-0' role='alert' aria-live='assertive' aria-atomic='true'><div class='d-flex'><div class='toast-body'>#{message}</div><button type='button' class='btn-close btn-close-white me-2 m-auto' data-bs-dismiss='toast' aria-label='Close'></button></div></div>"
      flash_messages << text.html_safe if message
    end.join("\n").html_safe
  end

  def avatar_for(image, size = 50, alt = 'Avatar')
    if image.blank?
      image_tag('default-avatar.png', alt: alt, width: size, class: 'rounded-circle shadow-sm')
    else
      cl_image_tag(
        image,
        folder: 'moto-6',
        width: size,
        height: size,
        class: 'rounded-circle shadow-sm',
        crop: 'fill'
      )
    end
  end

  def vehicle_image(vehicle, size = 150, alt = 'vehicle image')
    if vehicle.vehicle_images.exists?
      cl_image_tag(
        vehicle.vehicle_images.first.image_path,
        height: size,
        width: size,
        crop: :fill,
        class: 'rounded-start'
      )
    else
      image_link = "https://via.placeholder.com/#{size}"
      image_tag(image_link, alt: alt, class: 'img-fluid')
    end
  end

  def active_class controller
    return 'active' if controller == params[:controller]
  end
end
