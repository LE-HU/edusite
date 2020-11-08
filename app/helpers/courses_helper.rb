module CoursesHelper
  def enrollment_button(course)
    if current_user
      if course.user == current_user
        link_to "View analytics", course_path(course), class: "btn btn-sm btn-info"
      elsif course.enrollments.where(user: current_user).any?
        link_to "Keep learning", course_path(course), class: "btn btn-sm btn-primary"
      elsif course.price > 0
        link_to number_to_currency(course.price), new_course_enrollment_path(course), class: "btn btn-sm btn-success"
      else
        link_to "Free", new_course_enrollment_path(course), class: "btn btn-sm btn-success"
      end
    else
      link_to "Check price", course_path(course), class: "btn btn-sm btn-info"
    end
  end

  def review_button(course)
    if current_user
      user_course = course.enrollments.where(user: current_user)
      if user_course.any?
        if user_course.pending_review.any?
          link_to "Add a review", edit_enrollment_path(user_course.first), class: "btn btn-sm btn-info my-2"
        else
          link_to "See your review", enrollment_path(user_course.first), class: "btn btn-sm btn-secondary my-2"
        end
      end
    end
  end
end
