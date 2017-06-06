module Users
  class ImportCommand
    def initialize(data)
      @data = data
    end

    def execute
      input_schema = [:email, :enc, :name, :provider, :uid]
      users = []
      @data.each do |data|
        data = OpenStruct.new(data)
        next if User.where(email: data.email).exists?
        user = User.new(email: data.email,
          name: data.name,
          encrypted_password: data.enc,
          confirmed_at: data.confirmed_at,
          created_at: data.created_at,
          updated_at: data.updated_at,
        )

        if data.provider.present? && data.uid.present?
          user.identities.build(provider: data.provider, uid: data.uid)
        end

        users << user
      end
      User.import(users, recursive: true, validate: false)
    end
  end
end
