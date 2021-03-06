# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  phone_number           :string
#  date_of_birth          :date
#  is_admin               :boolean          default(FALSE), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  locale                 :string           default("")
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :confirmable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  has_many :spaces
  has_many :authentications, dependent: :delete_all

  validates :name, presence: true
  validates :email, presence: true
  validates :password, confirmation: true, on: [:create, :new]
  validates :password_confirmation, presence: true
  has_many :favorite_spaces, dependent: :delete_all

  def token_payload
    {
      user_id: id,
      email: email,
      name: name,
      is_admin: is_admin,
      locale: locale
    }
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def apply_auth(auth, provider, token)
    self.email = auth['email'] || "#{auth['id']}@facebook.com"
    self.name = "#{auth['first_name']} #{auth['last_name']}"
    self.date_of_birth = Date.strptime(auth['birthday']
                         .tr('/', '-'), '%m-%d-%Y') if auth['birthday'].present?

    authentications.build(provider: provider, uid: auth['id'], token: token)
  end
end
