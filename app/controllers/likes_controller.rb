# Description/Explanation of LikesController class
class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_comment, only: [:create_comment]
  before_action :find_like_comment, only: [:create_comment]
  # before_action :find_post, only: %i[create find_like]
  # before_action :find_like, only: %i[create find_like_comment]

  def create
    # if !@like.nil?
    #   destroy_like
    # else
    #   @like = @post.likes.build(user_id: current_user.id)
    #   create_like
    # end
    @post = Post.find_by(id: params[:post_id])
    @comment = Comment.find_by(id: params[:comment_id])
    current_user.likes.create like_params
  end

  # def create_comment
  #   if @like.present?
  #     destroy_like
  #   else
  #     @like = @comment.likes.build(user_id: current_user.id)
  #     create_like
  #   end
  # end

  def destroy
    @like = Like.find_by(id: params[:id])
    if @like.tagetable_type == 'Post'
      @post = @like.tagetable
    else
      @comment = @like.tagetable
    end
    @like.destroy
  end

  private

  def like_params
    params.require(:like).permit(:tagetable_type, :tagetable_id)
  end

  # def find_post
  #   @post_id = params[:post_id]
  #   @post = Post.find_by(id: params[:post_id])
  # end

  # def find_comment
  #   @comment = Comment.find_by(id: params[:comment_id])
  #   @post_id = @comment.post_id
  #   @post = Post.find_by(id: @post_id)
  # end

  # def find_like
  #   user_id = current_user.id
  #   @like = @post.likes.where(user_id: user_id).first
  # end

  # def find_like_comment
  #   user_id = current_user.id
  #   @like = @comment.likes.where(user_id: user_id).first
  # end

  # def create_like
  #   respond_to do |format|
  #     if @like.save
  #       format.html { redirect_to post_path(@post), notice: "#{@like.tagetable_type} was liked successfully ." }
  #       format.json { render :show, status: :created, location: @post }
  #     else
  #       format.html { redirect_to post_path(@post), notice: 'Like failed .' }
  #       format.json { render json: @like.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # def destroy_like
  #   respond_to do |format|
  #     if @like.destroy
  #       format.html { redirect_to post_path(@post), notice: "#{@like.tagetable_type} was liked successfully ." }
  #       format.json { render :show, status: :created, location: @post }
  #     else
  #       format.html { redirect_to post_path(@post), notice: 'Like failed .' }
  #       format.json { render json: @like.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
end
