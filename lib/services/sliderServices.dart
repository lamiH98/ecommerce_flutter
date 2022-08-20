import 'package:ecommerce/api.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/models/slider.dart';

class SliderServices {
  static var client = http.Client();

  static Future<List<Slider>?> fetchSlider() async {
    var response = await http.get(Uri.parse('$my_api/sliders'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return sliderFromJson(jsonString);
    } else {
      return null;
    }
  }
}