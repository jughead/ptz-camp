# bcrypt-rb, ~> 3.0.1
require "openssl"
require 'bcrypt_ext'

module BCrypt301
  module Errors
    class InvalidSalt   < StandardError; end  # The salt parameter provided to bcrypt() is invalid.
    class InvalidHash   < StandardError; end  # The hash parameter provided to bcrypt() is invalid.
    class InvalidCost   < StandardError; end  # The cost parameter provided to bcrypt() is invalid.
    class InvalidSecret < StandardError; end  # The secret parameter provided to bcrypt() is invalid.
  end

  # A Ruby wrapper for the bcrypt() C extension calls and the Java calls.
  class Engine < BCrypt::Engine
    # The default computational expense parameter.
    DEFAULT_COST    = 10
    # The minimum cost supported by the algorithm.
    MIN_COST        = 4
    # Maximum possible size of bcrypt() salts.
    MAX_SALT_LENGTH = 16

    # Given a secret and a valid salt (see BCrypt::Engine.generate_salt) calculates
    # a bcrypt() password hash.
    def self.hash_secret(secret, salt, cost = nil)
      if valid_secret?(secret)
        if valid_salt?(salt)
          if cost.nil?
            cost = autodetect_cost(salt)
          end

          __bc_crypt(secret.to_s, salt)
        else
          raise Errors::InvalidSalt.new("invalid salt")
        end
      else
        raise Errors::InvalidSecret.new("invalid secret")
      end
    end

    # Returns true if +salt+ is a valid bcrypt() salt, false if not.
    def self.valid_salt?(salt)
      !!(salt =~ /^\$[0-9a-z]{2,}\$[0-9]{2,}\$[A-Za-z0-9\.\/]{22,}$/)
    end

    # Returns true if +secret+ is a valid bcrypt() secret, false if not.
    def self.valid_secret?(secret)
      secret.respond_to?(:to_s)
    end

    # Autodetects the cost from the salt string.
    def self.autodetect_cost(salt)
      salt[4..5].to_i
    end
  end

  # A password management class which allows you to safely store users' passwords and compare them.
  #
  # Example usage:
  #
  #   include BCrypt
  #
  #   # hash a user's password
  #   @password = Password.create("my grand secret")
  #   @password #=> "$2a$10$GtKs1Kbsig8ULHZzO1h2TetZfhO4Fmlxphp8bVKnUlZCBYYClPohG"
  #
  #   # store it safely
  #   @user.update_attribute(:password, @password)
  #
  #   # read it back
  #   @user.reload!
  #   @db_password = Password.new(@user.password)
  #
  #   # compare it after retrieval
  #   @db_password == "my grand secret" #=> true
  #   @db_password == "a paltry guess"  #=> false
  #
  class Password < String
    # The hash portion of the stored password hash.
    attr_reader :checksum
    # The salt of the store password hash (including version and cost).
    attr_reader :salt
    # The version of the bcrypt() algorithm used to create the hash.
    attr_reader :version
    # The cost factor used to create the hash.
    attr_reader :cost

    # Initializes a BCrypt::Password instance with the data from a stored hash.
    def initialize(raw_hash)
      if valid_hash?(raw_hash)
        self.replace(raw_hash)
        @version, @cost, @salt, @checksum = split_hash(self)
      else
        raise Errors::InvalidHash.new("invalid hash")
      end
    end

    # Compares a potential secret against the hash. Returns true if the secret is the original secret, false otherwise.
    def ==(secret)
      super(BCrypt301::Engine.hash_secret(secret, @salt))
    end
    alias_method :is_password?, :==

  private
    # Returns true if +h+ is a valid hash.
    def valid_hash?(h)
      h =~ /^\$[0-9a-z]{2}\$[0-9]{2}\$[A-Za-z0-9\.\/]{53}$/
    end

    # call-seq:
    #   split_hash(raw_hash) -> version, cost, salt, hash
    #
    # Splits +h+ into version, cost, salt, and hash and returns them in that order.
    def split_hash(h)
      _, v, c, mash = h.split('$')
      return v, c.to_i, h[0, 29].to_str, mash[-31, 31].to_str
    end
  end
end
