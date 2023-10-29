import 'package:beats/models/category.dart';

class CategoryOperations {
  CategoryOperations._() {}
  static List<Category> getCategories() {
    return <Category>[
      Category('Top songs',
          'https://is4-ssl.mzstatic.com/image/thumb/Purple122/v4/f5/1e/85/f51e856c-52c9-a109-44c2-acf22f742643/AppIcon-1x_U007emarketing-0-7-0-sRGB-85-220.png/256x256bb.jpg'),
      Category('Hip Hop',
          'https://img.freepik.com/premium-vector/street-style-black-white-print-with-big-boombox-hip-hop-rap-music-type_185390-358.jpg'),
      Category('Romantic',
          'https://us.123rf.com/450wm/ukususha/ukususha1601/ukususha160100137/51613528-treble-clef-of-hearts-romantic-music-symbol.jpg'),
      Category('Jazz songs',
          'https://is3-ssl.mzstatic.com/image/thumb/Purple3/v4/88/1a/9b/881a9b3d-e662-51a6-8d04-da7292fc3814/source/256x256bb.jpg'),
      Category('Classic',
          'https://www.cmuse.org/wp-content/uploads/2020/11/What-Makes-Classical-Music-Classical.jpg'),
      Category('Rock Music',
          'https://i.pinimg.com/originals/ac/9d/1d/ac9d1d9f22ebd188737dc9714311efbf.jpg'),
      Category("90's hits",
          'https://www.musicgrotto.com/wp-content/uploads/2021/10/90s-music-cassette-tapes-records-graphic-art.jpg'),
      Category('Folk',
          'https://previews.123rf.com/images/seamartini/seamartini1611/seamartini161100193/66208449-folk-music-heart-emblem-of-musical-instruments-music-label-with-pattern-of-music-folk-instruments-vi.jpg'),
    ];
  }
}
