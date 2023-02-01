class CommentsController < ApplicationController
  load_and_authorize_resource

  # <% if user_signed_in? %>
  #   <% if comment.user_id == current_user.id %> 
  #     <%= link_to "Edit this comment", edit_comment_path(comment.id) %>
  #     <%= button_to "Destroy this comment", comment, method: :delete %>
  #   <% end %>
  # <% end %>

  
  # <% if can? :delete, Comment %> 
  #   <%= link_to "Edit this comment", edit_comment_path(comment.id) %>
  #   <%= button_to "Destroy this comment", comment, method: :delete %>
  # <% end %>

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
   
        # format.html { redirect_to event_url(@comment.event_id), notice: "Comment was successfully created." }

        format.turbo_stream { render turbo_stream: turbo_stream.prepend("comments", @comment) }

      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.turbo_stream { render turbo_stream: turbo_stream.update("comments", @comment) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
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
