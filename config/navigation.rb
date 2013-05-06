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

              Semester.title_options.each do |season, translated_season|
                course.item season, "Потоки. #{translated_season}", semester_year_faculty_course_streams_path(@year, @faculty, @course, by_semester_title: season) do |stream|
                  stream.item :new_stream, 'Новый поток', new_year_faculty_course_stream_path(@year, @faculty, @course)
                  stream.item :stream, "Поток &laquo;#{@stream.title}&raquo;", edit_year_faculty_course_stream_path(@year, @faculty, @course, @stream) if @stream && @stream.persisted?
                end if params[:by_semester_title] || @stream && @stream.semester.title == season
              end

              course.item :group, @group, year_faculty_course_group_path(@year, @faculty, @course, @group) do |group|

                group.item :edit_group, 'Изменение группы', edit_year_faculty_course_group_path(@year, @faculty, @course, @group)
                group.item :edit_group_semester, "Редактирование нагрузки. #{@semester.title_text}",
                      edit_year_faculty_course_group_semester_path(@year, @faculty, @course, @group, @semester) if @semester

              end if @group && @group.persisted?

            end if @course

        end if @faculty

      end if @year && @year.persisted?

      years.item :new_year, 'Создание нового учебного года', new_year_path if @year && @year.new_record?
    end
  end
end
