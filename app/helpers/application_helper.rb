module ApplicationHelper
  def fa_icon(name)
    content_tag(:i, nil, class: "fa fa-#{name}", 'aria-hidden' => 'true')
  end
end
