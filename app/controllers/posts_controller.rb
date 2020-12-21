# Description/Explanation of PostsController class
class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  # GET /posts
  # GET /posts.json
  def index
    @search = Post.ransack(params[:q])
    @posts =  @search.result
  end

  # GET /posts/1
  # GET /posts/1.json
  def show; end

  # GET /posts/new
  def new
    # @post = Post.new
    @post = current_user.posts.build
    # @categories = Category.all
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts
  # POST /posts.json
  def create
    tag = Tag.find_by(name: post_params[:tags_attributes]['0'][:name])
    if tag.present?
      redirect_to category_path(post_params[:category_id]), notice: 'tags existed'
    else
      @post = current_user.posts.build(post_params)
      respond_to do |format|
        if @post.save
          format.html { redirect_to category_path(@post['category_id']), notice: 'Post was successfully created.' }
        # format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new }
          # format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        # format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        # format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to category_path(@post['category_id']), notice: 'Post was successfully destroyed.' }
      # format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :body, :category_id, { tag_ids: [] }, tags_attributes: %i[id name])
  end
end
