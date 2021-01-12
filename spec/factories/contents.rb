FactoryBot.define do
  factory :content do
     title { Faker::Lorem.word }
     image_content { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg')) }
     video_content { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.MOV')) }
     overview { Faker::Lorem.sentences }
     writing { Faker::Lorem.paragraphs }
     source { Faker::Internet.url }
     association :user
  end
end
