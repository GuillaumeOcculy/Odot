require 'rails_helper'

RSpec.describe User, type: :model do
  let(:valid_attributes) {
    {
      first_name: 'Jason',
      last_name: 'Seifer',
      email: 'jason@teamtreehouse.com',
      password: 'treehouse1234',
      password_confirmation: 'treehouse1234'
    }
  }
  context "validations" do
    let(:user) { User.new(valid_attributes) }

    before do
      User.create(valid_attributes)
    end

    it 'requires an email' do
      expect(user).to validate_presence_of(:email)
    end

    it 'requires a unique email' do
      expect(user).to validate_uniqueness_of(:email)
    end

    it 'requires a unique email (case insensitive)' do
      user.email = 'GUILLAUME@EXAMPLE.COM'
      expect(user).to validate_uniqueness_of(:email)
    end

    it 'requires the email address to look like an email' do
      user.email = 'guillaume'
      expect(user).to_not be_valid
    end


    describe '#downcase_email' do
      it 'makes the email attribute lower case' do
        user = User.new(valid_attributes.merge(email: 'JASON@EXAMPLE.COM'))
        user.downcase_email
        expect(user.email).to eq('jason@example.com')
      end

      it 'downcases an email before saving' do
        user = User.new(valid_attributes)
        user.email = "GUILLAUME@EXAMPLE.COM"
        expect(user.save).to be true
        expect(user.email).to eq("guillaume@example.com")
      end

    end
  end

end
