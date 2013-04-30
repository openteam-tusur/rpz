# -*- coding: utf-8 -*-

SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|

    primary.item :years, 'Учебные года', root_path, :highlights_on => ->{ controller_name == 'years' } do |years|

      years.item :year, @year.title, year_path(@year) do |year|

        year.item :edit_year, 'Изменение учебного года', edit_year_path(@year)

        year.item :faculties, @faculty.abbr, year_faculty_path(@year, @faculty) do |faculty|

          faculty.item :courses,
            "Группы #{@course.number} курса",
            year_faculty_course_groups_path(@year, @faculty, @course) do |course|

              course.item :archived_groups,
                'Архивированные группы',
                archived_year_faculty_course_groups_path(@year, @faculty, @course, :archived => 'archived')

              course.item :new_group,
                'Создание новой группы',
                new_year_faculty_course_group_path(@year, @faculty, @course)

              course.item :group, @group, year_faculty_course_group_path(@year, @faculty, @course, @group) do |group|

                group.item :edit_group, 'Изменение группы', edit_year_faculty_course_group_path(@year, @faculty, @course, @group)
                group.item :edit_group_semester, "Редактирование нагрузки. #{@semester.title_text}",
                      edit_year_faculty_course_group_semester_path(@year, @faculty, @course, @group, @semester)

              end if @group && @group.persisted?

            end if @course

        end if @faculty

      end if @year && @year.persisted?

      years.item :new_year, 'Создание нового учебного года', new_year_path if @year && @year.new_record?
    end
  end
end
