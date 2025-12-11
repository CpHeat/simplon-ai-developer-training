import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grizbee/src/presentation/internationalization/translation.dart';
import 'package:grizbee/src/presentation/widgets/features/additional_feature_row.dart';

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final additionalFeatures = [
      _AdditionalFeature(CupertinoIcons.device_phone_portrait, Translation.of(context).toUpPrepaidPhones),
      _AdditionalFeature(CupertinoIcons.qrcode, Translation.of(context).acceptQRCodePayment),
      _AdditionalFeature(CupertinoIcons.globe, Translation.of(context).sendBankTransfersOrCash),
      _AdditionalFeature(CupertinoIcons.person_3, Translation.of(context).createPot),
      _AdditionalFeature(CupertinoIcons.heart, Translation.of(context).supportAssociation),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(Translation.of(context).more)),
      body: ListView.separated(
        itemCount: additionalFeatures.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          final additionalFeature = additionalFeatures[index];
          return AdditionalFeatureRow(iconData: additionalFeature.iconData, title: additionalFeature.title);
        },
      ),
    );
  }
}

class _AdditionalFeature {
  final IconData iconData;
  final String title;

  _AdditionalFeature(this.iconData, this.title);
}
