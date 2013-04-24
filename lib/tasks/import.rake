# encoding: utf-8

desc "Синхронизация групп с контингента"
task :sync_groups => :environment do
  GroupImporter.sync
end

desc "Синхронизация идентификаторов планов с plans"
task :sync_subspecialities => :environment do
  SubspecialityImporter.sync
end
