class User
  include Mongoid::Document
  include Tokenable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: DateTime

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: DateTime
  field :last_sign_in_at,    type: DateTime
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time
  field :name,               type: String
  field :gender,             type: String
  validates :name,           presence: true
  validates :gender,         presence: true
  field :auth_token,         type: String, default: ""
  validates :auth_token,     uniqueness: true
  index({ auth_token: 1 }, { unique: true })

  embeds_one :profile, :cascade_callbacks => true
  embeds_many :achievements
  embeds_many :marked_contests
  field :to_connections,    type: Hash 
  field :from_connections,  type: Hash

  before_create :initialize_profile

  private
    def initialize_profile
        self.build_profile
    end
end
