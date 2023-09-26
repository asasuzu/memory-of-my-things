# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
  email: ENV['ADMIN_EMAIL'],
  password: ENV['ADMIN_PASSWORD']
)

user_data = [
  { email: "hokkaidou@example.com", name: "ほっかいどう", password: "password" },
  { email: "akita@example.com", name: "あきた", password: "password" },
  { email: "iwate@example.com", name: "いわて", password: "password" },
  { email: "aomori@example.com", name: "あおもり", password: "password" },
  { email: "yamagata@example.com", name: "やまがた", password: "password" },
  { email: "miyagi@example.com", name: "みやぎ", password: "password" },
  { email: "hukusima@example.com", name: "ふくしま", password: "password" },
  { email: "gunnma@example.com", name: "ぐんま", password: "password" },
  { email: "totigi@example.com", name: "とちぎ", password: "password" },
  { email: "ibaraki@example.com", name: "いばらき", password: "password" },
  { email: "saitama@example.com", name: "さいたま", password: "password" },
  { email: "toukyou@example.com", name: "とうきょう", password: "password" },
  { email: "kanagawa@example.com", name: "かながわ", password: "password" },
  { email: "tiba@example.com", name: "ちば", password: "password" },
  { email: "niigata@example.com", name: "にいがた", password: "password" },
  { email: "toyama@example.com", name: "とやま", password: "password" },
  { email: "isikawa@example.com", name: "いしかわ", password: "password" },
  { email: "hukui@example.com", name: "ふくい", password: "password" },
  { email: "nagano@example.com", name: "ながの", password: "password" },
  { email: "gihu@example.com", name: "ぎふ", password: "password" },
  { email: "yamanasi@example.com", name: "やまなし", password: "password" },
  { email: "sizuoka@example.com", name: "しずおか", password: "password" },
  { email: "aiti@example.com", name: "あいち", password: "password" },
]

user_data.each do |data|
  User.find_or_create_by!(email: data[:email]) do |user|
    user.name = data[:name]
    user.password = data[:password]
  end
end


def create_post(title, image_path, body, user_id, spend_time)
  Post.find_or_create_by!(title: title) do |post|
    post.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/#{image_path}"), filename: image_path)
    post.body = body
    post.user_id = user_id
    post.spend_time = spend_time
  end
end

# 投稿データを作成
create_post("熊のぬいぐるみ", "animal1.jpg", "ずっと、見守っていてくれてありがとう。ふわふわで物言わず、ただそこにいるだけで、安心できました。寄贈先でも頑張ってね。", 6, 4)
create_post("蛙のぬいぐるみ", "animal2.jpg", "確か、出会いはダ○ソーだったでしょうか。長い間、一緒にいてくれたね。今までありがとう。お疲れ様でした！", 5, 4)
create_post("初めて編んだぬいぐるみ", "animal3.jpg", "編み物が趣味だったとき、一生懸命編んだぬいぐるみ。母に、呪いの人形と言われました。さようならー。今度作るときはもっと上手に作る！", 4, 4)
create_post("UFOキャッチャーの景品", "animal4.jpg", "映画の半券を見せると無料でUFOキャッチャーができて、そこでGETしたぬいぐるみ。何かの漫画とコラボしたあらいぐまとのこと。今までありがとー", 3, 2)
create_post("空っぽのハンドソープ", "bottle.jpg", "大きなボトルで使いやすかったです！私たちの手を清潔に保ってくれました。今までありがとう。お疲れ様でした！", 2, 1)
create_post("英語の教科書", "english.jpg", "英語を教えてくれて、ありがとう。 とても、勉強になりました！ 長い間、一緒に過ごしたね。お疲れ様でした！", 1, 4)
