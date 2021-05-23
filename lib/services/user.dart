

import 'package:shared_preferences/shared_preferences.dart';

save(index, name, clas) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'my_int_key';
  final value = 42;
  prefs.setString('index', index);
  prefs.setString('name', name);
  prefs.setString('class', clas);
  final all = prefs.get('index');
  print('saved $all');
}

read() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'index';
  final value = prefs.getString(key) ?? null;
  return key;
}
remove() async{
  final prefs = await SharedPreferences.getInstance();
  return prefs.clear();
}

isUser() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();

  final id = prefs.getString('index') ?? null;
  if (id != null) {
    return true;
  }
  return false;
}
