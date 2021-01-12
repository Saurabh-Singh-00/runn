import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runn/blocs/blocs.dart';

class FlexibleAppBar extends StatelessWidget {
  const FlexibleAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: -124.0,
          right: -108.0,
          child: CircleAvatar(
            backgroundColor: Colors.amberAccent.withOpacity(0.35),
            radius: 124.0,
          ),
        ),
        Positioned(
          top: -108.0,
          right: 36.0,
          child: CircleAvatar(
            backgroundColor: Colors.redAccent.withOpacity(0.35),
            radius: 96.0,
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 26.0,
                            backgroundImage: NetworkImage(
                              (state is Authenticated)
                                  ? state.account.photoUrl
                                  : 'https://randomuser.me/api/portraits/women/11.jpg',
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Text(
                  "Hello Lady",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodyText1.fontSize,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Discover marathons near by.",
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headline4.fontSize,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
