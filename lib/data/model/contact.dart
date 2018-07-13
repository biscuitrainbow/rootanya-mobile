class Contact {
  final String id;
  final String name;
  final String tel;

  Contact({
    this.id,
    this.name,
    this.tel,
  });

  static List<Contact> fromJsonArray(List<dynamic> json) {
    var contacts = json
        ?.map(
          (c) => Contact(
                id: c['id'].toString(),
                name: c['name'],
                tel: c['tel'],
              ),
        )
        ?.toList();

    return contacts;
  }

  @override
  String toString() {
    return 'Contact{id: $id, name: $name, tel: $tel}';
  }


}
