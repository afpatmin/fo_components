import 'package:angular/di.dart';
import '../model/model.dart';

@Injectable()
class ModelService
{
  Map<String, Model> data =
  {
    "1" : new Model("1", "patrick", "patrick.minogue@gmail.com", "0709145324", new DateTime.now(), true),
    "2" : new Model("2", "af", "af@af.com12312lkj asdölkjfadöfl ajdfölkadjfaölksdjfaö dlfjaöldjfa öldkfjadölkfjaödlkfj", "0709123456", new DateTime.now().add(const Duration(days: -3)), true),
    "3" : new Model("3", "bill", "bullen@gmail.com", "0709234567", new DateTime.now().add(const Duration(days: -5)), true),
    "4" : new Model("4", "dejan", "dejan@gmail.com", "0707111111", new DateTime.now().add(const Duration(days: -10000)), false),
    "5" : new Model("5", "bauer", "bauer@gmail.com", "0707111111", new DateTime.now().add(const Duration(days: 5)), false),
    "6" : new Model("6", "jesuse", "jesuse@gmail.com", "0707111111", new DateTime.now().add(const Duration(days: -199999)), false),
    "7" : new Model("7", "lisa", "lisa@gmail.com", "0707111111", new DateTime.now().add(const Duration(days: -10000)), false),
  };
}