class CommentsController < ApplicationController
  before_action :set_comment, only: [:create]

  def create
    if @comment.save
      redirect_to course_lesson_path(@course, @lesson), notice: "Comment was successfully created."
    else
      redirect_to course_lesson_path(@course, @lesson), alert: "Something is missing."
    end
  end

  private

  def set_comment
    @course = Course.friendly.find(params[:course_id])
    @lesson = Lesson.friendly.find(params[:lesson_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.lesson_id = @lesson.id
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
