class CommentsController < ApplicationController
  before_action :set_lesson, only: [:create, :destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.lesson_id = @lesson.id
    if @comment.save
      redirect_to course_lesson_path(@course, @lesson), notice: "Comment was successfully created."
    else
      redirect_to course_lesson_path(@course, @lesson), alert: "Something is missing."
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.destroy
    redirect_to course_lesson_path(@course, @lesson), notice: "Comment was successfully deleted."
  end

  private

  def set_lesson
    @course = Course.friendly.find(params[:course_id])
    @lesson = Lesson.friendly.find(params[:lesson_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
