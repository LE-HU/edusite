class CommentsController < ApplicationController
  before_action :set_comment, only: [:create, :destroy]

  def create
    if @comment.save
      redirect_to course_lesson_path(@course, @lesson), notice: "Comment was successfully created."
    else
      redirect_to course_lesson_path(@course, @lesson), alert: "Something is missing."
    end
  end

  def destroy
    @comment.destroy
    redirect_to course_lesson_path(@course, @lesson), notice: "Comment was successfully deleted."
  end

  private

  def set_comment
    @course = Course.friendly.find(params[:course_id])
    @lesson = Lesson.friendly.find(params[:lesson_id])
    begin
      @comment = Comment.find(params[:id])
    rescue
      @comment = Comment.new(comment_params)
    end
    @comment.user = current_user
    @comment.lesson_id = @lesson.id
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
