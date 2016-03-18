class User < ActiveRecord::Base
  has_many :books

  validates :name, presence: true
  validates :email, email: true, presence: true, uniqueness: {allow_blank: true}

  after_create :send_welcome_email

  def send_welcome_email
    AdminMailer.delay.new_user(self)
  end
end
