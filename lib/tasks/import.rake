# encoding: utf-8

require 'progress_bar'

desc "Синхронизация групп с контингента"
task :sync_groups => :environment do
  GroupImporter.sync
end
