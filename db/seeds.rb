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
  { email: "test@example.com", name: "テストユーザー", password: "testuser" },
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
create_post("使用済み乾電池", "battery.jpg", "マウスの中で、働いてくれました。マウスがあったからこそ、学習もスムーズに進みました。マウスの中で働いてくれた電池のおかげです。本当にありがとう。最後まで頼りになる仕事をしてくれました。お疲れさまでした。", 1, 2)
create_post("景品のぬいぐるみ", "bear.jpg", "おそらくUFOキャッチャーの景品で出会ったと思います。腹部に書いてある格言は絶対忘れません！今まで見守っていてくれてありがとう。寄贈先でも頑張ってね。", 2, 4)
create_post("汚れた長靴", "boots.jpg", "汚れた長靴、あなたには本当に感謝しています。雨の日でも、ぬかるみの中でも、いつも頼りにしてました。おかげでどんな天候にも立ち向かえました。今までありがとう！", 3, 3)
create_post("あられが入ってた缶", "can.jpg", "プレゼントにいただいたあられの缶。あられの一粒一粒の美味しさは、日常の中でのちょっとした贅沢でした。この缶が私の手に届いたことで、幸せを感じることができました。ありがとうね", 4, 1)
create_post("古い香水", "perfume.jpg", "10年くらい前に購入した香水。さすがに使用期限切れですね。少しずつ布に染み込ませて、空っぽにしてから手放すね。今まで良い香りを届けてくれて、ありがとう！", 17, 4)
create_post("買ったけど着なかった服", "clothes.jpg", "買ったけど、着る機会が訪れませんでした。欲しい人にお譲りしたので、いっぱい着てもらってね！さようなら！", 5, 1)
create_post("欠けたマグカップ", "cup.jpg", "お祝いでいただいたかわいい猫のマグカップ。洗っている最中に不注意で欠けてしまいました。本当にごめんね。手放すけど、お祝いされた気持ちは忘れません！今までありがとう", 6, 2)
create_post("英語の教科書", "english.jpg", "英語の勉強の手助けをしてくれてありがとう。あなたからもらった知識はずっと私の役に立っていきます。", 7, 4)
create_post("くっつくフライパン", "frying_pan.jpg", "購入してからほぼ毎日愛用していました。くっつくようになってきたのでそろそろ買い替えの時。いろんな料理を作ってきました。サイズ的にとても使いやすかったです！今までありがとう！", 8, 3)
create_post("ゲームのコントローラー", "game.jpg", "２人でゲームをするときに、活躍してくれました。純正のコントローラーを買ってしまったので、出番がなくなってしまったけど、今までありがとう！", 10, 3)
create_post("キーボード", "keyboard.jpg", "頂いたキーボードでしたが、なかなか使う機会もなく、欲しい人にお譲りしました。新しい環境で、がんがん働いてね！応援しています！", 11, 3)
create_post("もらった折り紙", "origami.jpg", "知らないお爺さんから頂いた折り紙。とても上手に作ってあります。感謝の気持ちを胸に、手放そうと思います。ありがとう！", 12, 2)
create_post("ボールペン", "pen.jpg", "小学校の修学旅行で京都で購入したボールペン。１０年以上愛用してましたが、そろそろ書けなくなってきました。さみしいけど、今までありがとう！", 13, 4)
create_post("冷蔵庫", "refrigerator.jpg", "初めての一人暮らしで買った冷蔵庫。霜取りが大変だった思い出。まだまだ使えるから、新しい人のところでも頑張ってね！", 14, 4)
create_post("スニーカー", "shoes.jpg", "このスニーカーとの思い出はたくさんあります。一緒に歩いたり、走ったり、楽しい冒険を共有したり。でも、そろそろ買い替え時。今までありがとう！", 16, 3)
create_post("ぼろぼろのフライパン", "frying_pan2.jpg", "たぶん１０年以上あるのでしょうか。ボロボロになってからも、お湯を沸かしたりとかで活躍してくれました。今までありがとう！", 9, 4)
create_post("炊飯器", "rice_cooker.jpg", "初めての一人暮らしで買った炊飯器。何十回、何百回とお米を炊いてきました。まだまだ使えるから、新しい人のところでも頑張ってね！", 15, 4)

# 花むけ機能のテストデータ
posts = Post.all

posts.each do |post|
  flowers_to_create = []

  # ユーザーID 1から23までからランダムに17名のユーザーを選択
  random_users = User.where(id: 1..23).sample(17)

  random_users.each do |user|
    flowers_to_create << { user: user, post: post }
  end

  Flower.create!(flowers_to_create)
end

# 遺言のテストデータ
messages = [
  { message: "あなたと出会えて嬉しかったです。少しでも私の存在が、お役に立てたなら幸いです。さようなら。" },
  { message: "面倒なのに、私のことを投稿してくれてありがとう。その気持ちがとても嬉しいです。元気でね！" },
  { message: "新しいものも、あなたが私にしてくれたように、大切に使ってあげてくださいね。さようなら！" },
  { message: "あなたと過ごした時間は本当に楽しかったです。これからも素晴らしい人生をお送りください。" },
  { message: "お別れは寂しいけど、今までのことを思い出して微笑んでいたいと思います。さようなら。" },
  { message: "あなたの手で大切に使ってくれたおかげで、いろんな思い出がいっぱいあります。ありがとう。" },
]

Message.create!(messages)

# コメントのテストデータ
comment_texts = ["素敵な思い出ですね", "wonderful memories!", "美しい記憶ですこと", "記憶・・・ワンダフォーな…記憶　それがある　これには"]

# 投稿ごとにランダムに5名のユーザーを選択してコメント
Post.all.each do |post|
  random_users = User.where(id: 1..23).sample(5)

  random_users.each do |user|
    random_comment = comment_texts.sample
    Comment.create!(user: user, post: post, comment: random_comment)
  end
end

# 通報のテストデータ
reports = [
  { reason: '不適切な内容', user_id: 2, reported_item_id: 1, reported_item_type: 'Post', status: 0 },
  { reason: '不快な気分になった。', user_id: 3, reported_item_id: 2, reported_item_type: 'Comment', status: 0 },
  { reason: '不適切な内容だと思いました。', user_id: 4, reported_item_id: 3, reported_item_type: 'Post', status: 0 },
  { reason: '言葉遣いが適切ではないと思いました。', user_id: 5, reported_item_id: 4, reported_item_type: 'Comment', status: 0 },
  { reason: '不愉快になりました。', user_id: 6, reported_item_id: 5, reported_item_type: 'Post', status: 0 },
  { reason: '中身がロボットだと思います。', user_id: 7, reported_item_id: 6, reported_item_type: 'Comment', status: 0 },
]

Report.create!(reports)

