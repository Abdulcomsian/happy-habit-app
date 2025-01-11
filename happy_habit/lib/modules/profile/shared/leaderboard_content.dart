import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:happy_habit/core/constants/assets_path.dart';
import 'package:happy_habit/core/extensions/widget_extensions.dart';
import 'package:happy_habit/core/theme/theme_colors.dart';
import 'package:happy_habit/core/theme/typography.dart';

class LeaderboardContent extends StatelessWidget {
  const LeaderboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 29.h),
                child: TopScorerTile(
                  position: 2,
                  name: 'Bryan Wolf',
                ),
              ),
              TopScorerTile(
                position: 1,
                name: 'Bryan Wolf',
              ),
              Padding(
                padding: EdgeInsets.only(top: 29.h),
                child: TopScorerTile(
                  position: 3,
                  name: 'Bryan Wolf',
                ),
              ),
            ],
          ),
          20.height,
          ListView.separated(
            itemCount: 9,
            shrinkWrap: true,
            padding: EdgeInsets.only(bottom: 30.h),
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => 10.height,
            itemBuilder: (context, i) => ScoreTile(
              position: i + 1,
              isCurrentUser: i == 6,
              name: [
                'Meghan James',
                'Bryan Wolf',
                'Alex Turner',
                'Marsha Fisher',
                'Juanita Cornier',
                'You',
                'Tamara Schmidt',
                'Ricardo Velum',
                'Gary Sanford',
              ][i],
            ),
          ),
        ],
      ),
    );
  }
}

class ScoreTile extends StatelessWidget {
  final int position;
  final String name;
  final bool isCurrentUser;

  const ScoreTile({
    super.key,
    required this.name,
    required this.position,
    this.isCurrentUser = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isCurrentUser ? ThemeColor.primary : Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Text(
            position.toString(),
            style: context.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: isCurrentUser ? Colors.white : null,
            ),
          ),
          12.width,
          CircleAvatar(
            backgroundColor: ThemeColor.primary,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                DummyIcons.man,
              ),
            ),
          ),
          12.width,
          Expanded(
            child: Text(
              name,
              style: context.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isCurrentUser ? Colors.white : null,
              ),
            ),
          ),
          Text(
            '34 XP',
            style: context.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isCurrentUser ? Colors.white : null,
            ),
          ),
        ],
      ),
    );
  }
}

class TopScorerTile extends StatelessWidget {
  final int position;
  final String name;

  const TopScorerTile({
    super.key,
    required this.name,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: (isFirst ? 102   : 95).r,
          child: Stack(
            children: [
              Container(
                width: (isFirst ? 84 : 74).r,
                height: (isFirst ? 84 : 74).r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ThemeColor.primary,
                ),
                child: Image.asset(
                  DummyIcons.man,
                  width: (isFirst ? 80 : 70).r,
                  height: (isFirst ? 80 : 70).r,
                  // alignment: Alignment.bottomCenter,
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: CircleAvatar(
                  backgroundColor: ThemeColor.primary,
                  child: Text(
                    position.toString(),
                    style: context.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          name,
          style: context.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AppIcons.dumbbells,
              width: 12.r,
              height: 12.r,
            ),
            Text('XP'),
          ],
        )
      ],
    );
  }

  bool get isFirst => position == 1;
}
