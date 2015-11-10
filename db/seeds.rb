# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# いったんきれいにお掃除する
Product.delete_all

# 新しく商品データを作成する
Product.create([
  {
    id: 1,
    title: 'Programing Ruby 1.9',
    description: %{<p>
      Ruby is the fastest growing and most exciting dynamic language out there.
      </p>},
    image_url: 'ruby.jpg',
    price: 49.95
  },
  {
    id: 2,
    title: 'CoffeeScript',
    description: %{<p>
      CoffeeScript is JavaScript done right.
      </p>},
    image_url: 'cs.jpg',
    price: 36.00
  },
  {
    id: 3,
    title: 'Rails Test Prescriptions',
    description: %{<p>
      Rails Test Prescriptions is a comprehensive guide to testing.
      </p>},
    image_url: 'rtp.jpg',
    price: 45.00
  },
  {
    id: 4,
    title: '週刊アスキー No.1052 （2015年11月10日発行）<週刊アスキー> [雑誌] [Kindle版]',
    description: %{<p>
      <b>※この商品はタブレットなど大きいディスプレイを備えた端末で読むことに適しています。また、文字列のハイライトや検索、辞書の参照、引用などの機能が使用できません。</b><br><br>
      新製品ではソニーが発表した超弩級4240万画素のコンパクトカメラ『RX1RII』に、デルの宇宙いち速いというゲームノート『Alienware17』をご紹介。もちろん特集は、今ＰＣを買うと必ず付いてくる『Windows10』の厳選最強TIPSをたっぷりご紹介させていただきました。新連載コミックの『ど根性ガエルの娘』もたっぷり載ってますよ～～。
      </p>},
    image_url: '91BZwCtR1IL._SL1500_.jpg',
    price: 360.00
  },
  ])


