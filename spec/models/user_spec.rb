require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(email: 'emmanuel@gmail.com', password: 'x', name: 'Emmanuel', username: 'emmanuel') }

  before { subject.save }

  it 'name should not be empty' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'name should not be blank' do
    subject.name = '   '
    expect(subject).to_not be_valid
  end
end
