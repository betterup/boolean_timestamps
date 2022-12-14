require 'boolean_timestamps/version'
require 'active_support/concern'
require 'active_support/lazy_load_hooks'

module BooleanTimestamps
  extend ActiveSupport::Concern

  class_methods do
    def boolean_timestamps(*attributes, scopes: true)
      attributes.each do |timestamp_attribute|
        boolean_attribute = timestamp_attribute.to_s.gsub(/_at\z/, '')
        define_method boolean_attribute do
          send("#{timestamp_attribute}?")
        end
        define_method "#{boolean_attribute}?" do
          send("#{timestamp_attribute}?")
        end
        define_method "#{boolean_attribute}=" do |value|
          boolean_value = ActiveRecord::Type::Boolean.new.cast(value)
          unless boolean_value && send("#{timestamp_attribute}?")
            timestamp = boolean_value ? Time.zone.now : nil
            send("#{timestamp_attribute}=", timestamp)
          end
        end
        if scopes
          scope boolean_attribute, lambda { |value = true|
            if value
              where.not(timestamp_attribute => nil)
            else
              where(timestamp_attribute => nil)
            end
          }
        end
      end
    end
  end
end
ActiveSupport.on_load(:active_record) do
  include BooleanTimestamps
end
