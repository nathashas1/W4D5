require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    context 'with invalid params' do
      it 'validates the password length is at least 6' do
        post :create, params: { user: { username: 'mary', email: 'mary@mary.com', password: 'star' } }
        expect(response).to render_template('new')
        expect(flash[:errors]).to be_present
      end
      
      it 'validates the presence of email, password, and username' do
        post :create, params: { user: { email: 'mary@mary.com', password: 'starwars' } }
        expect(response).to render_template('new')
        expect(flash[:errors]).to be_present
      end
    end
    context 'with valid params' do
      it 'redirects them to the user page' do 
        post :create, params: { user: { username: 'mary', email: 'mary@mary.com', password: 'starwars' } }
        expect(response).to redirect_to(user_url(User.last))
      end
    end
  end
  
  describe 'GET #new' do
    it 'renders the new page' do
      get :new
      
      expect(response).to render_template('new')
      expect(response).to have_http_status(200)
    end
  end
  
  describe 'GET #edit' do
    it 'renders the edit page' do
      user = User.create(username: 'mary', email: 'mary@mary.com', password: 'starwars')
      get :edit, params: { id: user.id }
      
      expect(response).to render_template('edit')
      expect(response).to have_http_status(200)
    end
  end
  
  describe 'PATCH #update' do
    it 'redirects to the user show page' do
      user = User.create(username: 'mary', email: 'mary@mary.com', password: 'starwars')
      patch :update, params: { id: user.id }
      expect(response).to render_template('edit')
      expect(response).to have_http_status(200)

    end
  end
  
  describe 'GET #show' do
    it 'shows the user page' do
      user = User.create(username: 'mary', email: 'mary@mary.com', password: 'starwars')
      get :show, params: { id: user.id }
      
      expect(response).to render_template('show')
      expect(response).to have_http_status(200)
    end
  end
  
  describe 'GET #index' do
    it 'shows all the users' do
      post :create, params: { user: { username: 'mary', email: 'mary@mary.com', password: 'starwars' } }
      post :create, params: { user: { username: 'john', email: 'john@john.com', password: 'starwars' } }
      get :index
      
      expect(response).to render_template('index')
      expect(response).to have_http_status(200)
    end
  end
end
