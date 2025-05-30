class CommentsController < ApplicationController
  before_action :set_post, only: %i[ new create edit update destroy ]
  def new
    @comment = @post.comments.build
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.turbo_stream {
          render turbo_stream: [ turbo_stream.append("comments_list", partial: "comments/comment", locals: { comment: @comment }),
           turbo_stream.replace("comment_form", partial: "comments/form", locals: { comment: Comment.new }),
          turbo_stream.replace("comment_count", partial: "posts/comment_count", locals: { post: @post })
          ]
        }
        format.html { redirect_to @post, notice: "Comment was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @comment = @post.comments.find(params[:id])
  end

  def update
    @comment = @post.comments.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @post, notice: "Comment was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy!

    respond_to do |format|
      format.turbo_stream {
        render turbo_stream: [  turbo_stream.remove(@comment),
          turbo_stream.replace("comment_count", partial: "posts/comment_count", locals: { post: @post })
        ]
      }
      format.html { redirect_to @post, status: :see_other, notice: "Comment was successfully destroyed." }
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
