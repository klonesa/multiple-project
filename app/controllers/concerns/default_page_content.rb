module DefaultPageContent
  extend ActiveSupport::Concern

  included do
    before_action :set_page_dafaults
  end
  def set_page_dafaults
    @page_title = "Multiple Project | My Portfolio Website"
    @seo_keywords = "Habip Yeşilyurt Portfolio"
  end
end