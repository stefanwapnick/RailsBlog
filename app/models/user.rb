class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  has_many :articles, dependent: :destroy       # dependent : destroy will delete on cascade for users (deleting a user will delete all articles associated with user)
  validates :username, presence: true, uniqueness: {case_sensitive: false}, length: {minimum:3, maximum:25}
  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: {with: VALID_EMAIL_REGEX} ,length: {maximum:105}
  before_save {self.email = email.downcase}

  has_secure_password
end