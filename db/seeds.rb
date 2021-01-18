math = Category.create(name: "数学")
math.children.create([{name: "基礎"}, {name: "純粋数学"}, {name: "応用数学"}, {name: "その他"}])

japanese = Category.create(name: "国語")
japanese.children.create([{name: "現代文"}, {name: "古典"}, {name: "読書"}, {name: "作文"}, {name: "書写"}, {name: "その他"}])

social_study = Category.create(name: "社会")
social_study.children.create([{name: "地理"}, {name: "歴史"}, {name: "公民"}, {name: "哲学"}, {name: "その他"}])

science = Category.create(name: "理科")
science.children.create([{name: "化学"}, {name: "生物"}, {name: "物理"}, {name: "地学"}, {name: "その他"}])

music = Category.create(name: "音楽")
music.children.create([{name: "声楽"}, {name: "器楽"}, {name: "作曲"}, {name: "指揮"}, {name: "その他"}])

art = Category.create(name: "美術")
art.children.create([{name: "絵画"}, {name: "彫刻"}, {name: "デザイン"}, {name: "工芸"}, {name: "その他"}])

health = Category.create(name: "保健")
health.children.create([{name: "福祉"}, {name: "保育"}, {name: "健康"}, {name: "その他"}])

physical_education = Category.create(name: "体育")
physical_education.children.create([{name: "陸上競技"}, {name: "球技"}, {name: "水泳"}, {name: "器械運動・体操"}, {name: "武道"}, {name: "ダンス"}, {name: "その他"}])

tech_engineering = Category.create(name: "技術")
tech_engineering.children.create([{name: "工学"}, {name: "情報"}, {name: "農業"}, {name: "水産"}, {name: "その他"}])

home_economics = Category.create(name: "家庭")
home_economics.children.create([{name: "料理"}, {name: "家政"}, {name: "被服"}, {name: "その他"}])

language = Category.create(name: "外国語")
language.children.create([{name: "英語"}, {name: "フランス語"}, {name: "ドイツ語"}, {name: "中国語"}, {name: "その他"}])

etc = Category.create(name: "その他")
etc.children.create([{name: "商業"}, {name: "総合"}, {name: "その他"}])
