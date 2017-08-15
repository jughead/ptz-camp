module Pages
  class SlugValidator < BaseSlugValidator
    private

    def check_usage(page)
      has_taken = false
      unless page.camp
        has_taken ||= Camp.where(slug: page.slug).present?
        has_taken ||= Page.where(camp_id: nil).where(slug: page.slug).where.not(id: page.id).present?
      else
        has_taken ||= Page.where(camp: page.camp).where(slug: page.slug).where.not(id: page.id).present?
      end

      page.errors.add(:slug, :taken, value: page.slug) if has_taken
    end
  end
end
