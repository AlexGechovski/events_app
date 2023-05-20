class CommentsController < ApplicationController
  load_and_authorize_resource

  # GET /comments
  def index
    # @comments = Comment.all
  end

  # GET /comments/1
  def show
  end

  # GET /comments/new
  def new
    # @comment = Comment.new

    @comment.event = Event.first
  end

  # GET /comments/1/edit
  def edit
    # respond_to do |format|
    #        format.turbo_stream { render turbo_stream: turbo_stream.prepend("comments", @comment) }

    # end
  end

  # POST /comments
  def create
    # @comment = Comment.new(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        # format.html { redirect_to event_url(@comment.event_id), notice: "Comment was successfully created." }
        format.turbo_stream { render turbo_stream: turbo_stream.prepend("comments", @comment) }
      else
        #format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("comment_form", partial: "comments/form", locals: { comment: @comment }) }
      end
    end
  end

  # PATCH/PUT /comments/1
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.turbo_stream { render turbo_stream: turbo_stream.update("comments", @comment) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  def destroy
     @comment.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@comment) }
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:text, :user_id , :event_id)
    end

    def current_ability
      @current_ability ||= CommentAbility.new(current_user)
    end
end
