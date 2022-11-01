require 'rails_helper'

RSpec.describe UsersController, type: :request do
  before(:each) do
    @user = User.create(name: 'Tom Nath', photo: 'https://picsum.photos/208', bio: 'I love coding rails',
                        post_counter: 0)
    @post = Post.create(
      author_id: @user.id,
      title: 'Post title',
      text: 'Post text'
    )
    Comment.create(author_id: @user.id, post: @post, text: 'This is great')
    Comment.create(author_id: @user.id, post: @post, text: 'Testing')
    Comment.create(author_id: @user.id, post: @post, text: 'I love this test')
  end

  describe "GET 'index' page" do
    before(:example) do
      get '/users'
    end

    it 'return correct response' do
      expect(response).to have_http_status(:ok)
    end
    it 'should render correct template' do
      expect(response).to render_template(:index)
    end
    it 'The response body should have the correct placeholder text' do
      expect(response.body).to include('<h1>Users list</h1>')
    end
  end

  describe "GET 'show' page" do
    before(:example) do
      get "/users/#{@user.id}"
    end

    it 'return correct response' do
      expect(response).to have_http_status(:ok)
    end

    it 'should render correct template' do
      expect(response).to render_template(:show)
    end

    it 'body should includes correct placeholder text' do
      expect(response.body).to include('Tom Nath')
    end
  end

  describe 'Get post from one user' do
    before(:example) do
      get "/users/#{@user.id}/posts"
    end

    it 'return correct response' do
      expect(response).to have_http_status(:ok)
    end

    it 'should render correct template' do
      expect(response).to render_template(:posts)
    end

    it 'body should includes correct placeholder text' do
      expect(response.body).to include('Number of post ')
    end
  end

  describe 'Get post from one user details page' do
    before(:example) do
      get "/users/#{@user.id}/posts/#{@post.id}"
    end

    it 'return correct response' do
      expect(response).to have_http_status(:ok)
    end

    it 'should render correct template' do
      expect(response).to render_template(:post_details)
    end

    it 'body should includes correct placeholder text' do
      expect(response.body).to include('Post content')
    end
  end
end
