import 'package:core/core.dart';
import 'package:test/test.dart';

void main() {
  test('decodes a DRF pagination envelope and its items', () {
    final response = PaginatedResponse<String>.fromJson({
      'count': 2,
      'next': 'https://example.test/courses/?page=2',
      'previous': null,
      'results': [
        {'title': 'Algorithms'},
        {'title': 'Databases'},
      ],
    }, (json) => (json as Map<String, dynamic>)['title'] as String);

    expect(response.count, 2);
    expect(response.next, 'https://example.test/courses/?page=2');
    expect(response.previous, isNull);
    expect(response.results, ['Algorithms', 'Databases']);
  });
}
