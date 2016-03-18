class User < ActiveRecord::Base
  has_many :books

  validates :name, presence: true
  validates :email, email: true, presence: true, uniqueness: {allow_blank: true}
end
