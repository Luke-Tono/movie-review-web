# db/seeds.rb
# 清空现有数据（请谨慎使用！）
puts "正在清除现有数据..."
Comment.destroy_all
Review.destroy_all
Movie.destroy_all
Watchlist.destroy_all
Profile.destroy_all
User.destroy_all

# 创建管理员用户
puts "创建用户..."
admin = User.create!(
  username: "admin",
  email: "admin@example.com",
  password: "password",
  role: "admin"
)

user1 = User.create!(
  username: "lucy",
  email: "lucy@example.com",
  password: "password"
)

user2 = User.create!(
  username: "jack",
  email: "jack@example.com",
  password: "password"
)

# 更新个人资料
puts "更新用户资料..."
admin.profile.update(
  bio: "我是网站管理员，热爱电影和评论。",
  location: "北京",
  favorite_genre: "科幻、悬疑"
)

user1.profile.update(
  bio: "电影爱好者，特别喜欢动作片和喜剧片。",
  location: "上海",
  favorite_genre: "动作、喜剧"
)

user2.profile.update(
  bio: "文艺片爱好者，也喜欢一些小众电影。",
  location: "广州",
  favorite_genre: "剧情、文艺"
)

# 创建电影
puts "创建电影数据..."
movies = [
  {
    title: "肖申克的救赎",
    release_year: 1994,
    director: "弗兰克·德拉邦特",
    cast: "蒂姆·罗宾斯, 摩根·弗里曼",
    synopsis: "两个被囚禁在肖申克监狱的男人在多年中找到了友谊和救赎。银行家安迪·杜佛雷因涉嫌谋杀妻子及其情人而被判无期徒刑。在狱中，他结识了红，一个能搞到任何东西的囚犯。安迪凭借自己的智慧和技能，不仅改变了监狱生活，还策划了一场令人难以置信的越狱。",
    # poster_image: "poster/The_Shawshank_Redemption.jpg",
    duration: 142,
    language: "英语",
    genres: "剧情"
  },
  {
    title: "千与千寻",
    release_year: 2001,
    director: "宫崎骏",
    cast: "柊瑠美, 入野自由",
    synopsis: "10岁的少女千寻与父母意外进入了神灵世界，她必须想办法救出变成猪的父母。千寻和父母在搬家途中误入一个奇怪的隧道，来到一个神奇的世界。父母因贪吃变成了猪，千寻则被迫在一家神灵浴场工作，以寻找救出父母的方法。在这里，她遇到了各种各样神奇的人物，也慢慢成长为一个勇敢坚强的女孩。",
    # poster_image: "poster/Spirited_Away.jpg",
    duration: 125,
    language: "日语",
    genres: "动画, 奇幻, 冒险"
  },
  {
    title: "盗梦空间",
    release_year: 2010,
    director: "克里斯托弗·诺兰",
    cast: "莱昂纳多·迪卡普里奥, 约瑟夫·高登-莱维特",
    synopsis: "一个高端盗贼能够通过技术潜入他人梦境，偷取想法，但他面临最危险的一次任务。柯布和他的团队是专业的'潜盗者'，通过分享梦境的方式，可以窃取别人内心深处的秘密。这次，他们面临一个全新的任务：不是窃取思想，而是植入思想。这个危险的任务涉及多层梦境，而柯布还必须面对自己心中的恶魔。",
    # poster_image: "poster/Inception.jpg",
    duration: 148,
    language: "英语",
    genres: "科幻, 冒险, 动作"
  },
  {
    title: "星际穿越",
    release_year: 2014,
    director: "克里斯托弗·诺兰",
    cast: "马修·麦康纳, 安妮·海瑟薇",
    synopsis: "一组宇航员通过虫洞进行星际旅行，寻找人类的新家园。在不远的未来，地球上的资源正在枯竭，人类面临灭亡。前NASA宇航员库珀被招募加入一支团队，穿越虫洞去探索可能适合人类居住的新星球。在这场穿越时空的旅行中，他必须在拯救全人类和与女儿重聚之间做出抉择。",
    # poster_image: "poster/Interstellar.jpg",
    duration: 169,
    language: "英语",
    genres: "科幻, 冒险, 剧情"
  },
  {
    title: "泰坦尼克号",
    release_year: 1997,
    director: "詹姆斯·卡梅隆",
    cast: "莱昂纳多·迪卡普里奥, 凯特·温斯莱特",
    synopsis: '贵族女孩Rose和穷画家Jack在泰坦尼克号上相爱，但这艘"不沉的船"即将面临灾难。年轻的贵族女孩罗丝与母亲和未婚夫乘坐泰坦尼克号头等舱前往美国。在船上，她遇见了穷画家杰克，两人迅速堕入爱河。然而，当这艘豪华邮轮撞上冰山后，所有乘客都面临着生死抉择。',
    # poster_image: "poster/Titanic.jpg",
    duration: 194,
    language: "英语",
    genres: "爱情, 灾难, 剧情"
  },
  {
    title: "楚门的世界",
    release_year: 1998,
    director: "彼得·威尔",
    cast: "金·凯瑞, 劳拉·琳妮",
    synopsis: "楚门不知道自己的生活是一个巨大的电视真人秀节目，他开始怀疑并寻找真相。楚门从出生起就生活在一个巨大的摄影棚中，而他的一举一动都被全球数百万观众实时收看。当他开始怀疑自己的世界并试图逃离时，他必须面对一个可能颠覆他整个认知的残酷真相。",
    # poster_image: "poster/The_Truman_Show.jpg",
    duration: 103,
    language: "英语",
    genres: "剧情, 科幻"
  }
]

# 保存电影到数据库
movies.each do |movie_data|
  Movie.create!(movie_data)
end

# 创建评论
puts "创建电影评论..."
Movie.all.each do |movie|
  # 第一个用户的评论
  if [1, 3, 5, 7].include?(movie.id)
    Review.create!(
      user: user1,
      movie: movie,
      content: "这是一部非常棒的电影，情节引人入胜，演员表演出色。特别喜欢#{movie.director}导演的拍摄手法，将#{movie.cast}的表演完美展现。每次看都有新的感受，绝对是我心目中的经典之作，强烈推荐所有人观看！",
      rating: rand(7..10)
    )
  end
  
  # 第二个用户的评论
  if [2, 4, 6, 8].include?(movie.id)
    Review.create!(
      user: user2,
      movie: movie,
      content: "这部电影给我留下了深刻的印象，导演#{movie.director}的手法非常独特，画面也很美。故事节奏把握得很好，既有紧张刺激的部分，也有令人感动的情节。#{movie.cast}的演技非常到位，角色塑造立体而真实。总体来说是一部值得反复观看的优秀作品。",
      rating: rand(6..9)
    )
  end
  
  # 管理员的评论
  Review.create!(
    user: admin,
    movie: movie,
    content: "作为电影评论人，我认为这是#{movie.director}导演的代表作之一。剧情发展紧凑，#{movie.cast}的演技也非常精湛。影片在视觉效果和音乐配合上都达到了很高的水准，情感表达真挚动人。虽然有些小缺点，但瑕不掩瑜，仍然是一部不可错过的佳作。",
    rating: rand(8..10)
  )
end

# 给一些评论添加回复
puts "创建评论回复..."
Review.all.sample(5).each do |review|
  # 添加1-3条回复
  rand(1..3).times do
    user = [admin, user1, user2].sample
    if user != review.user # 确保用户不回复自己的评论
      Comment.create!(
        user: user,
        review: review,
        content: ["完全同意你的观点！", "我也很喜欢这部电影，特别是剧情的转折部分。", "演员的表演确实很出色，尤其是主角。", "导演的手法很独特，镜头语言丰富。", "这个评分我觉得很公正，确实是部好片。", "感谢分享你的见解，让我对这部电影有了新的理解。"].sample
      )
    end
  end
end

# 创建观影清单
puts "创建观影清单..."
# 用户1的观影清单
watchlist1 = Watchlist.create!(
  user: user1,
  name: "必看经典",
  description: "我认为每个电影爱好者都应该看的经典电影，这些电影或因剧情、或因演技、或因导演的独特视角而成为电影史上不可忽视的作品。",
  is_public: true
)

watchlist2 = Watchlist.create!(
  user: user1,
  name: "待看清单",
  description: "我计划近期观看的电影，包括一些新上映的和以前错过的经典影片。",
  is_public: false
)

# 用户2的观影清单
watchlist3 = Watchlist.create!(
  user: user2,
  name: "最爱电影",
  description: "我最喜欢的几部电影，每部都看过不止一遍，百看不厌的佳作。",
  is_public: true
)

watchlist4 = Watchlist.create!(
  user: user2,
  name: "文艺片收藏",
  description: "收集的一些文艺片，适合慢慢品味，感受导演的独特视角和艺术表达。",
  is_public: true
)

# 管理员的观影清单
watchlist5 = Watchlist.create!(
  user: admin,
  name: "年度推荐",
  description: "今年我最推荐的几部电影，包括新上映的佳作和重新发现的经典。",
  is_public: true
)

# 添加电影到观影清单
puts "将电影添加到观影清单..."
# 确保我们使用实际存在的电影ID
movie_ids = Movie.pluck(:id)

# 使用随机的实际电影ID
watchlist1.movies << Movie.find(movie_ids.sample(3))
watchlist2.movies << Movie.find(movie_ids.sample(2))
watchlist3.movies << Movie.find(movie_ids.sample(3))
watchlist4.movies << Movie.find(movie_ids.sample(2))
watchlist5.movies << Movie.find(movie_ids.sample(4))

puts "种子数据创建完成！"
puts "管理员账号: admin@example.com / password"
puts "普通用户1: lucy@example.com / password"
puts "普通用户2: jack@example.com / password"