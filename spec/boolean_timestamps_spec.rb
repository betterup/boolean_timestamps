require 'spec_helper'

describe BooleanTimestamps do
  class User < ActiveRecord::Base
    boolean_timestamps :activated_at
  end

  it 'has a version number' do
    expect(BooleanTimestamps::VERSION).not_to be nil
  end

  describe '#boolean_timestamps' do
    it 'adds boolean methods to model' do
      user = User.new
      expect(user).to respond_to(:activated?)
      expect(user).to respond_to(:activated=)
    end
  end
end
