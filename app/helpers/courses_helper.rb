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
end
