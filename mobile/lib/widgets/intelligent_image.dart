import 'package:bitescan/config/locator.dart';
import 'package:bitescan/cubits/system_config/system_config_cubit.dart';
import 'package:bitescan/repositories/data/remote_data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IntelligentImage extends StatefulWidget {
  final String source;

  const IntelligentImage(this.source, {super.key});

  @override
  State<IntelligentImage> createState() => _IntelligentImageState();

  static Future<ImageProvider> getProvider(
      String source, BuildContext context) async {
    source = await findPath(source, context);

    if (source.startsWith("http")) {
      return NetworkImage(source);
    } else {
      if (await _assetExists(source)) {
        return AssetImage(source);
      } else {
        final endPoint =
            locator.get<RemoteDataRepository>().createEndpoint(source);
        return NetworkImage(endPoint);
      }
    }
  }

  static Future<String> findPath(String source, BuildContext context) async {
    final lang = Localizations.localeOf(context).languageCode;

    source = source.replaceAll(".\$lang.", ".$lang.");

    if (source.startsWith("http")) {
      return source;
    } else {
      if (await _assetExists(source)) {
        return source;
      } else {
        final endPoint =
            locator.get<RemoteDataRepository>().createEndpoint(source);
        return endPoint;
      }
    }
  }
}

class _IntelligentImageState extends State<IntelligentImage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SystemConfigCubit, SystemConfigState>(
      buildWhen: (prev, next) => prev.locale != next.locale,
      builder: (__, state) => FutureBuilder<String>(
        key: ValueKey(state.locale),
        future: IntelligentImage.findPath(widget.source, context),
        builder: (_, val) {
          if (!val.hasData) return Container();

          if (val.data!.startsWith("http")) {
            return Image.network(val.data!);
          } else {
            return Image.asset(val.data!);
          }
        },
      ),
    );
  }
}

Future<bool> _assetExists(String path) async {
  try {
    await rootBundle.loadBuffer(path);
    return true;
  } catch (_) {
    return false;
  }
}
