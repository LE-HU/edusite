class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]

  def index
    @latest_courses = Course.latest
    @latest_good_reviews = Enrollment.reviewed.latest_reviews
    @top_rated_courses = Course.top_rated
    @popular_courses = Course.popular
    @purchased_courses = Course.joins(:enrollments).where(enrollments: { user: current_user }).order(created_at: :desc).limit(3)
  end

  def activity
    authorize current_user
    @pagy, @activities = pagy(PublicActivity::Activity.all.order(created_at: :DESC))
  end

  def statistics
    authorize current_user
    @users_chart = User.group_by_day(:created_at).count
    @enrollments_chart = Enrollment.group_by_day(:created_at).count
    @course_popularity_chart = Enrollment.joins(:course).group(:'courses.title').count
  end
end
