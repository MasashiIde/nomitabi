# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
  Admin.create!(
    email: 'admin@admin',
    password: 'testtest'
  )
  
  users = User.create!(
    [
      {email: 'reiwa@test.com', family_name: '令和', first_name: '花子', nickname: 'れいわはなこ', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")},
      {email: 'heisei@test.com', family_name: '平成', first_name: '太郎', nickname: 'へいせいたろう', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")},
      {email: 'shouwa@test.com', family_name: '昭和', first_name: '一郎', nickname: 'しょうわいちろう', password: 'password', profile_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")}
    ]
  )

  Post.create!(
    [
      {shop_name: '和食居酒屋', introduction: 'お刺身や卵焼きが美味しいお店です。', shop_address: '東京都渋谷区1-1-1', shop_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg"), user_id: users[0].id },
      {shop_name: '大衆居酒屋', introduction: '焼き鳥や唐揚げが美味しいお店です。', shop_address: '東京都新宿区1-1-1', shop_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg"), user_id: users[1].id },
      {shop_name: 'もつ鍋居酒屋', introduction: 'もつ鍋が美味しいです。日本酒と一緒に食べるのがおすすめです。', shop_address: '東京都港区1-1-1', shop_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg"), user_id: users[2].id }
    ]
  )