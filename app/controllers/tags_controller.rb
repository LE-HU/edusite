class TagsController < ApplicationController
  def index
    @tags = Tag.all.order(course_tags_count: :DESC)
    authorize @tags
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      render json: @tag
    else
      render json: { errors: @tag.errors.full_messages }
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    authorize @tag
    if @tag.destroy
      redirect_to tags_path, notice: "Tag was successfully destroyed."
    else
      redirect_to tags_path, alert: "Something went wrong."
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end

# authorize @course
# if @course.destroy
#   respond_to do |format|
#     format.html { redirect_to courses_url, notice: "Course was successfully destroyed." }
#     format.json { head :no_content }
#   end
# else
#   redirect_to @course, alert: "Can not delete course with ongoing enrollments."
# end
