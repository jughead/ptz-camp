module Camps
  class SlugValidator < BaseSlugValidator
    private

    def check_usage(camp)
      has_taken = Page.where(camp_id: nil, slug: camp.slug).present?
      has_taken ||= Camp.where(slug: camp.slug).where.not(id: camp.id).present?
      camp.errors.add(:slug, :taken, value: page.slug) if has_taken
    end
  end
end
