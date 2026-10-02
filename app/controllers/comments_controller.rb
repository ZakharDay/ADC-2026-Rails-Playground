class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_comment, only: %i[ show edit destroy ]

  # GET /comments or /comments.json
  # def index
  #   @comments = Comment.all
  # end

  # GET /comments/1 or /comments/1.json
  # def show
  # end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  # def edit
  # end

  # POST /comments or /comments.json
  def create
    @post = Post.find(params[:post_id])

    @comment = @post.comments.create!(
      user_id: current_user.id,
      body: params[:comment][:body]
    )

    redirect_to post_path(@post)
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  # def update
  #   respond_to do |format|
  #     if @comment.update(comment_params)
  #       format.html { redirect_to @comment, notice: "Comment was successfully updated.", status: :see_other }
  #       format.json { render :show, status: :ok, location: @comment }
  #     else
  #       format.html { render :edit, status: :unprocessable_content }
  #       format.json { render json: @comment.errors, status: :unprocessable_content }
  #     end
  #   end
  # end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @post = @comment.post
    @comment.destroy!

    respond_to do |format|
      format.html { redirect_to post_path(@post), notice: "Comment was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.expect(comment: [ :body ])
    end
end
