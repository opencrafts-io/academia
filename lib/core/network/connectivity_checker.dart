import 'package:academia/core/core.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';

/// ConnectivityChecker
/// -------------------
/// A mixin with methods that help to check whether a user is connected to the
/// internet
///
/// Mix it with remote datasources to help in checking for network connections
/// NOTE: This is not a fool-proof method of knowing whether a user is
/// connected to the internet. It might return that a user is connected to wifi
/// when in fact the wifi they're on is not connected to the internet so BEWARE!
mixin ConnectivityChecker {
  final Connectivity _connectivity = Connectivity();

  // Function to check internet connectivity status
  Future<bool> isConnectedToInternet() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
  }

  // Optionally, a method to handle no internet connection and return a failure message
  Future<Either<Failure, T>> handleNoConnection<T>() async {
    return left(
      ServerFailure(
        message: "No internet connection. Please check your network.",
        error: Exception("No Internet Connection"),
      ),
    );
  }
}
