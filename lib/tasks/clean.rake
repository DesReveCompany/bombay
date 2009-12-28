    CLEAN_FILES = FileList['**/*~']

    CLEAN_FILES.clear_exclude

    desc "delete emacs backup files."

    task :clean do

    rm CLEAN_FILES

    puts "cleaned below."

    puts CLEAN_FILES

    end
