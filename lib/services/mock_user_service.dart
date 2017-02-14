import 'dart:async';
import 'package:angular2/core.dart';
import 'package:fo_components/fo_filtering.dart';

@Injectable()
class MockUserService
{
  MockUserService()
  {
    data["1"] = {"firstname":"patrick", "lastname":"minogue", "email":"patrick.minogue@gmail.com"};
    data["2"] = {"firstname":"bill", "lastname":"bauer", "email":"bill@gmail.com"};
    data["3"] = {"firstname":"annafrida", "lastname":"bengtsson", "email":"af@gmail.com"};
    data["4"] = {"firstname":"richard", "lastname":"minogue", "email":"richard@gmail.com"};
    data["5"] = {"firstname":"dejan", "lastname":"marlocvic", "email":"dmarlovic83@gmail.com"};
    data["6"] = {"firstname":"3", "lastname":"lkarss", "email":"pointus@gmail.com"};
    data["7"] = {"firstname":"2", "lastname":"lidman", "email":"ia.lidman@gmail.com"};
    data["8"] = {"firstname":"sara", "lastname":"bengsttson", "email":"saraha@gmail.com"};
    data["9"] = {"firstname":"patrick", "lastname":"minogue", "email":"patrick.minogue@gmail.com"};
    data["10"] = {"firstname":"bill", "lastname":"bauer", "email":"bill@gmail.com"};
    data["11"] = {"firstname":"annafrida", "lastname":"bengtsson", "email":"af@gmail.com"};
    data["12"] = {"firstname":"richard", "lastname":"minogue", "email":"richard@gmail.com"};
    data["13"] = {"firstname":"dejan", "lastname":"marlocvic", "email":"dmarlovic83@gmail.com"};
    data["14"] = {"firstname":"3", "lastname":"lkarss", "email":"pointus@gmail.com"};
    data["15"] = {"firstname":"2", "lastname":"lidman", "email":"ia.lidman@gmail.com"};
    data["16"] = {"firstname":"sara", "lastname":"bengsttson", "email":"saraha@gmail.com"};
    data["17"] = {"firstname":"patrick", "lastname":"minogue", "email":"patrick.minogue@gmail.com"};
    data["18"] = {"firstname":"bill", "lastname":"bauer", "email":"bill@gmail.com"};
    data["19"] = {"firstname":"annafrida", "lastname":"bengtsson", "email":"af@gmail.com"};
    data["20"] = {"firstname":"richard", "lastname":"minogue", "email":"richard@gmail.com"};
    data["21"] = {"firstname":"dejan", "lastname":"marlocvic", "email":"dmarlovic83@gmail.com"};
    data["22"] = {"firstname":"3", "lastname":"lkarss", "email":"pointus@gmail.com"};
    data["23"] = {"firstname":"2", "lastname":"lidman", "email":"ia.lidman@gmail.com"};
    data["24"] = {"firstname":"sara", "lastname":"bengsttson", "email":"saraha@gmail.com"};

    filteredData = new Map.from(data);
  }

  void search(String phrase)
  {
    isLoading = true;

    new Timer(const Duration(seconds: 1), ()
    {
      filteredData = FoFiltering.filter(data, phrase);
      isLoading = false;
    });
  }

  void sort(String column, String order)
  {
    isLoading = true;
    new Timer(const Duration(seconds: 1), ()
    {
      filteredData = FoFiltering.sort(filteredData, column, order);
      isLoading = false;
    });
  }

  bool isLoading = false;
  Map<String, Map<String, String>> data = new Map();
  Map<String, Map<String, String>> filteredData;
}