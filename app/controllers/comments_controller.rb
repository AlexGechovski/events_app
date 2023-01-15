class CommentsController < ApplicationController
  load_and_authorize_resource
  # before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments or /comments.json
  def index
    # @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    # @comment = Comment.new

    @comment.event = Event.first
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    # @comment = Comment.new(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to comment_url(@comment), notice: "Comment was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comment_url(@comment), notice: "Comment was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    # @comment.destroy

    respond_to do |format|
      format.html { redirect_to comment_url, notice: "Comment was successfully destroyed." }
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:text, :user_id , :event_id)
    end

    def current_ability
      @current_ability ||= CommentAbillity.new(current_user)
    end
end
