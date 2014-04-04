module ApplicationHelper
  def nav_link(link_text, link_path)
    class_name = current_page?(link_path)||current_page?("/aktualnosci_grupuj")||current_page?("/imprezy")||current_page?("/interwencje")||current_page?("/inne")||current_page?("/szkolenia")||current_page?("/galeria_wszystkie") ? 'selected' : ''

    content_tag(:li, :class => class_name, "onclick" => "location.href = '#{link_path}'") do
      link_to link_text, link_path
    end
  end
end
