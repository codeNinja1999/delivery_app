
import 'package:fresh_fold_delivery/repository/repository.dart';

import '../../config/config.dart';

class NetworkClientProvider {
  final signatureHelper = SignatureHelper(AppConfig.shared.appKey);

  NetworkClient provideDefaultClient() {
    final client = NetworkClient();
    final interceptor = DefaultInterceptor(baseUrl: AppConfig.shared.baseUrl).interceptor();
    client.interceptors.add(interceptor);
    return client;
  }

  NetworkClient provideAppAuthenticationClient() {
    final client = NetworkClient();

    final interceptor =
        AppAuthenticationInterceptor(baseUrl: AppConfig.shared.baseUrl, signatureHelper: signatureHelper).interceptor();
    client.interceptors.add(interceptor);
    return client;
  }

  NetworkClient provideUserAuthenticationClient(UserAuthenticationRepository userAuthenticationRepository) {
    final client = NetworkClient();
    final interceptor = UserAuthenticationInterceptor(
      baseUrl: AppConfig.shared.baseUrl,
      userAuthenticationRepository: userAuthenticationRepository,
      signatureHelper: signatureHelper,
    ).interceptor();
    client.interceptors.add(interceptor);
    return client;
  }

  NetworkClient provideDefaultPlainClient() {
    final client = NetworkClient();
    return client;
  }
}
