namespace :generate do
  desc "TODO"
  task test_data: :environment do
    MAX_TASK = 400
    MAX_CATEGORY = 20
    MAX_TAG = 50

    user = User.create! :email => "testdata@test.test", :username => "testdata", :password => "testdata"

    categories = []
    MAX_CATEGORY.times do |index|
      cat_color = "#%06x" % (rand * 0xffffff)

      cat = Category.create! :title => "category#{index}", :color => cat_color, :user_id => user.id
      categories << cat.id
    end
    categories << nil

    tags = []
    MAX_TAG.times do |index|
      tag_color = "#%06x" % (rand * 0xffffff)

      tag = Tag.create! :title => "tag#{index}", :color => tag_color, :user_id => user.id
      tags << tag
    end

    MAX_TASK.times do |index|
      task_tags = []
      rand(11).times { task_tags << tags.sample }

      Task.create! :title => "task#{index}",
                   :note => "note#{index}",
                   :deadline_at => Time.now + rand(15552000),
                   :category_id => categories.sample,
                   :tags => task_tags,
                   :user_id => user.id
    end

  end

end
