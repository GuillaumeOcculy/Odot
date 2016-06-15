require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe "POST #create" do
    context 'with correct credentials' do
      let!(:user) { User.create(first_name: 'Guillaume', last_name: 'West', email: 'guillaume@example.com', password: 'password1234', password_confirmation: 'password1234') }

      it 'finds the user' do
        expect(User).to receive(:find_by).with({email: 'guillaume@example.com'})
        post :create, email: 'guillaume@example.com', password: 'password1234'
      end

      it 'redirects to the todo list path' do
        post :create, email: 'guillaume@example.com', password: 'password1234'
        expect(response).to be_redirect
        expect(response).to redirect_to(todo_lists_path)
      end

      it 'authenticates the user' do
        User.stub(:find_by).and_return(user)
        expect(user).to receive(:authenticate)
        post :create, email: 'guillaume@example.com', password: 'password1234'
      end

      it 'sets the user_id in the session' do
        post :create, email: 'guillaume@example.com', password: 'password1234'
        expect(session[:user_id]).to eq(user.id)
      end

      it 'sets the flash success message' do
        post :create, email: 'guillaume@example.com', password: 'password1234'
        expect(flash[:success]).to eq("Thanks for logging in!")
      end

      context 'with blank credentials' do
        it 'renders the new template' do
          post :create, email: '', password: ''
          expect(response).to render_template('new')
        end

        it 'sets the flash error message' do
          post :create, email: 'guillaume@example.com', password: 'password1234'
          expect(flash[:error]).to eq("There was a problem logging in. Please check your email and password")
        end
      end



    end
  end



end
