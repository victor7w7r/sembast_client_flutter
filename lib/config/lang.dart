String lang(bool isEng, int index, [List<String>? custom]) {

  List<String> dictEsp = [

  ];

  List<String> dictEng = [

  ];

  return isEng ? dictEsp[index] : dictEng[index];

}