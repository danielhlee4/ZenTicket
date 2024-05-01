module ApplicationHelper
    def render_flash
        flash.map do |key, value|
            content_tag :div, class: "alert alert-#{key == 'notice' ? 'success' : 'danger'} alert-dismissible fade show", role: 'alert' do
                concat value
                concat(
                content_tag(:button, '', type: 'button', class: 'btn-close', data: { bs_dismiss: 'alert' }, aria: { label: 'Close' })
                )
            end
        end.join.html_safe
    end
end
