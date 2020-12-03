module CoursesHelper
  def enrollment_button(course)
    if current_user
      if course.user == current_user
        # link_to "You teach this course", course_path(course), class: ""
        "You teach this course"
      elsif course.enrollments.where(user: current_user).any?
        link_to course_path(course) do
          "<i class='fa fa-spinner'></i>".html_safe + " " +
          number_to_percentage(course.progress(current_user), precision: 0)
        end
      elsif course.price > 0
        link_to number_to_currency(course.price), new_course_enrollment_path(course), class: ""
      else
        link_to "Enroll for free", new_course_enrollment_path(course), class: ""
      end
    else
      link_to "Check price", new_course_enrollment_path(course), class: ""
    end
  end

  def review_button(course)
    if current_user
      user_course = course.enrollments.where(user: current_user)
      if user_course.any?
        if user_course.pending_review.any?
          link_to "Add a review", edit_enrollment_path(user_course.first), class: " my-2"
        else
          link_to "See your review", enrollment_path(user_course.first), class: " my-2"
        end
      end
    end
  end
end
