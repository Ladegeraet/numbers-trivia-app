import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:numbers_trivia_app/core/network/network_info.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfoImpl networkInfo;
  MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfo = NetworkInfoImpl(
      dataConnectionChecker: mockDataConnectionChecker,
    );
  });

  group('isConnected', () {
    test('should forward the call to DataConnectionChecker.hasConnection',
        () async {
      // arrange
      final tHasConnectionFuture = Future.value(true);

      when(mockDataConnectionChecker.hasConnection)
          .thenAnswer((_) => tHasConnectionFuture);

      // act
      final result = networkInfo.isConnected;

      // assert
      verify(mockDataConnectionChecker.hasConnection);
      // @see https://resocoder.com/2019/09/23/flutter-tdd-clean-architecture-course-7-network-info/
      // Utilizing Dart's default referential equality.
      // Only references to the same object are equal.
      expect(result, tHasConnectionFuture);
    });
  });
}
