abstract class Paths {
  static const home = _HomePaths._();
  static const result = _ScanningResultPaths._();
  static const scan = _ScanPaths._();
  static const onboarding = _OnboardingPaths._();
}

class _OnboardingPaths with _RootPaths {
  const _OnboardingPaths._();

  String get landing => rootPath('onboarding');
}

class _HomePaths with _RootPaths {
  const _HomePaths._();

  String get landing => rootPath('');
  String get firstTime => rootPath('?firstTime=true');
}

class _ScanningResultPaths with _RootPaths {
  const _ScanningResultPaths._();

  String get landing => rootPath("result/:code");

  String link(String code) => rootPath("result/$code");
}

class _ScanPaths with _RootPaths {
  const _ScanPaths._();

  String get landing => rootPath("scan");
}

mixin _RootPaths {
  String rootPath(String path) => '/$path';
}
