class Spree::StaticContentController < Spree::StoreController
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  helper 'spree/products'
  layout :determine_layout

  def show
    @page = Spree::Page.by_store(current_store).visible.slug_relative_to_mount_point(request.path).first!
  end

  private
    def determine_layout
      return @page.layout if @page and @page.layout.present? and not @page.render_layout_as_partial?
      Spree::Config.layout
    end

    def accurate_title
      @page ? (@page.meta_title.present? ? @page.meta_title : @page.title) : nil
    end
end
