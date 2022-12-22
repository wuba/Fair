import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/app_extensions.dart';
import 'package:fair_online/base/components/buttons/transparent_btn.dart';
import 'package:fair_online/base/components/mouse_hover_builder.dart';
import 'package:fair_online/base/components/spacing.dart';
import 'package:fair_online/base/components/styled_card.dart';
import 'package:fair_online/editor/services/dartservices.dart';
import 'package:fair_online/views/page/create/create_page_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageTemplateItemView extends StatelessWidget {
  final CreatePageCallback? onCreatePagePressed;
  final TemplatePageInfo templatePageInfo;
  final double height;

  const PageTemplateItemView(this.templatePageInfo, this.height,
      {Key? key, this.onCreatePagePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppTheme theme = AppTheme.of(context);
    TextStyle cardContentText = TextStyles.T1.textColor(theme.txt);
    return Column(children: [
      Container(
        height: 30,
        child: Text(templatePageInfo.pageName, style: cardContentText),
      ),
      MouseHoverBuilder(builder: (context, isHovering) {
        return StyledCard(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Corners.s8),
            image: templatePageInfo.screenshot.isEmpty
                ? DecorationImage(
                    image: AssetImage('assets/images/onboarding-bg.png'),
                    fit: BoxFit.cover,
                  )
                : DecorationImage(
                    image: NetworkImage(templatePageInfo.screenshot),
                    fit: BoxFit.cover,
                  ),
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Corners.s8),
              color: theme.bg2.withOpacity(isHovering ? 0.7 : 0.3),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isHovering) ...[
                  Text(templatePageInfo.pageName, style: cardContentText),
                  VSpace(Insets.l),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Insets.m),
                    child: StyledCard(
                      onPressed: () => onCreatePagePressed?.call(
                          templatePageInfo.pagePath, templatePageInfo.pageName),
                      bgColor: theme.accent1Darker,
                      align: Alignment.center,
                      child: Text('Use Template', style: cardContentText),
                    ).height(54),
                  ),
                ]
              ],
            ),
          ),
        ).height(height);
      })
    ]);
  }
}

class CreateNewPageItemView extends StatelessWidget {
  final CreatePageCallback? onCreatePagePressed;

  const CreateNewPageItemView(this.height, {Key? key, this.onCreatePagePressed})
      : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    TextStyle cardContentText = TextStyles.T1.textColor(theme.txt);
    return Column(
      children: [
        Container(
          height: 30,
          child: Text('Blank Page', style: cardContentText),
        ),
        TransparentBtn(
          onPressed: () => onCreatePagePressed?.call('', ''),
          borderRadius: Corners.s8,
          contentPadding: EdgeInsets.zero,
          child: StyledCard(
            bgColor: theme.bg2,
            align: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_circle_outline_outlined,
                  size: 50,
                  color: theme.txt,
                ),
                VSpace(Insets.l),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Insets.m),
                  child: StyledCard(
                    bgColor: theme.accent1Darker,
                    align: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          size: 16,
                          color: theme.txt,
                        ),
                        HSpace(Insets.sm),
                        Text('Create New Page', style: cardContentText),
                      ],
                    ).height(54),
                  ),
                ),
              ],
            ),
          ).height(height),
        ),
      ],
    );
  }
}
