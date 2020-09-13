import 'package:test/test.dart';
import 'package:wasteagram/models/postData.dart';

void main() {
  test('Post created from Map should have appropriate property values', ()
  {
    final date = DateTime.parse('2020-08-13');
    const imageUrl = 'FAKE';
    const quantity = 1;
    const latitude = 1.0;
    const longitude = 2.0;

    final foodWastePost = Post.fromMap({
      'date' : date,
      'imageUrl' : imageUrl,
      'quantity' : quantity,
      'latitude' : latitude,
      'longitude' : longitude
    });

    expect(foodWastePost.date, date);
    expect(foodWastePost.imageUrl, imageUrl);
    expect(foodWastePost.quantity, quantity);
    expect(foodWastePost.latitude, latitude);
    expect(foodWastePost.longitude, longitude);



  });
}
