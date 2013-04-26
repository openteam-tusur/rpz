# -*- coding: utf-8 -*-

SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|

    primary.item :years, 'Учебные года', root_path, :highlights_on => ->{ controller_name == 'years' } do |years|

      years.item :year, @year.title, year_path(@year) do |year|

        year.item :edit_year, 'Изменение учебного года', edit_year_path(@year)

        year.item :faculties, @faculty.abbr, year_faculty_path(@year, @faculty) do |faculty|

          faculty.item :archived_groups, 'Архивированные группы', archived_year_faculty_groups_path(@year, @faculty, :archived => 'archived')
          faculty.item :new_group, 'Создание новой группы', new_year_faculty_group_path(@year, @faculty)
          faculty.item :groups,
                       "Группы #{params[:by_course] ? params[:by_course].match(/\d+/) : @group.course} курса",
                       scoped_year_faculty_groups_path(@year, @faculty, :by_course => "course_#{params[:by_course] ? params[:by_course].match(/\d+/) : @group.course}") do |faculty|

            faculty.item :group, @group, year_faculty_group_path(@year, @faculty, @group) do |group|

              group.item :edit_group, 'Изменение группы', edit_year_faculty_group_path(@year, @faculty, @group)

            end if @group

          end if params[:by_course] || @group && @group.persisted?

        end if @faculty

      end if @year && @year.persisted?

      years.item :new_year, 'Создание нового учебного года', new_year_path if @year && @year.new_record?
    end
  end
end
