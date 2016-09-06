require 'spec_helper'

describe BooleanTimestamps do
  class User < ActiveRecord::Base
    boolean_timestamps :activated_at
  end

  class War < ActiveRecord::Base
    boolean_timestamps :massive_attack_at
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
    it 'converts timestamp to boolean value' do
      user = User.new(activated_at: DateTime.new)
      expect(user.activated?).to be_truthy
    end
    it 'converts true assignment to current timestamp' do
      user = User.new
      user.activated = true
      expect(user.activated_at).to_not be_nil
    end
    it 'converts false assignment to nil timestamp' do
      user = User.new(activated_at: DateTime.new)
      user.activated = false
      expect(user.activated_at).to be_nil
    end
    it 'works with properties that have _at in them' do
      war = War.new
      expect(war).to respond_to(:massive_attack?)
      expect(war).to respond_to(:massive_attack=)
    end
  end
end
