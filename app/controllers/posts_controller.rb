class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: [ :edit, :update, :destroy ]
  load_and_authorize_resource
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path
    else
      render :new, status: 422
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit, status: 422
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private
    def find_post
      @post = Post.find(params[:id])
    end 

    def post_params
      params.require(:post).permit( :title, :body )
    end 
end
