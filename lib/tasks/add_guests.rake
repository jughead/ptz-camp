task add_guests: :environment do
  guest_count = ENV['GUEST_COUNT'].to_i
  camp = CampFinder.new.current.find
  delegation = camp.delegations.find_or_create_by(name: 'Guest')

  guest_count.times do
    delegation.participants.build(
      camp: camp,
      personal: {
        first_name: 'Guest',
        last_name: '★',
        needs_visa: false,
      },
      tshirt: :xs,
    )
  end
  delegation.save!
end
