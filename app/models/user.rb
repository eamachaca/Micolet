class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors.add attribute, (options[:message] || "is not an email")
    end
  end
end

class DatabaseEmailValidator < ActiveModel::Validator
  def validate(record)
    require 'net/http'
    require 'net/https'
    require 'json'
    uri = URI('https://emailvalidation.abstractapi.com/v1/?api_key=9807527fdcb742ba8c6ecb4d56242a7e&email=' + record.email)
    response = Net::HTTP.get(uri)
    output = JSON.parse response
    if output['quality_score'].to_f < 0.7
      record.errors.add(:email, "don't be a valid email by our Database")
    end
  end
end

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true, on: :create, email: true, database_email: true

  #validates :preferences, presence: true, on: :create don't func because that i used JS manual validation
  has_and_belongs_to_many :preferences
  has_many :user_preferences
end
