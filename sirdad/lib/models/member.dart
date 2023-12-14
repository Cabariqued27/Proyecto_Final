class Member  {
  int idm;
  String name;
  String surname;
  int kid;
  int nid;
  int rela;
  String gen;
  int age;
  int et;//esto es para la etnia
  int heal;// esto es para el estado de salud
  int aheal; // chatgpt esto es para la AFILIACIÓN AL REGIMEN DE SALUD
  int sh;// chatgpt esto es para el ESTADO DEL INMUEBLE
  String familyId;

  Member({
    this.idm = 0,
    required this.name,
    required this.surname,
    required this.kid,
    required this.nid,
    required this.rela,
    required this.gen,
    required this.age,
    required this.et,
    required this.heal,
    required this.aheal,
    required this.sh,
    required this.familyId,
  }) ;
}