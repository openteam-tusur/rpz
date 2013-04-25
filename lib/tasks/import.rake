# encoding: utf-8

desc "Синхронизация групп с контингента"
task :sync_groups => :environment do
  GroupImporter.sync
end

desc "Синхронизация идентификаторов планов с plans"
task :sync_subspecialities => :environment do
  SubspecialityImporter.sync
end

desc "Синхронизация дисциплин и нагрузки с plans"
task :sync_disciplines => :environment do
  DisciplineImporter.sync
end

desc "Синхронизация всех справочников"
task :sync_all => :environment do
  GroupImporter.sync
  SubspecialityImporter.sync
  DisciplineImporter.sync
end
