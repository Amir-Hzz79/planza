import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planza/core/locale/app_localization.dart';
import 'package:planza/core/locale/bloc/locale_bloc.dart';
import 'package:planza/core/locale/bloc/locale_event.dart';
import 'package:planza/core/widgets/buttons/profile_button.dart';

import '../../../../../core/theme/bloc/theme_bloc.dart';
import 'drawer_list_button.dart';

class DrawerSection extends StatelessWidget {
  const DrawerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProfileButton(
                      radius: 25,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        context.read<ThemeBloc>().add(ThemeChangeEvent());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: BlocConsumer<ThemeBloc, ThemeState>(
                            listener: (context, state) {},
                            builder: (context, state) {
                              return Icon(
                                state is DarkModeState
                                    ? Icons.dark_mode_rounded
                                    : Icons.light_mode_rounded,
                              );
                            }),
                      ),
                    ),
                  ],
                ),
                Text('Amir Hosein Zamani'),
                /* CircleAvatar(
                    backgroundImage: AssetImage('assets/images/profile.JPEG'),
                    radius: 20,
                  ), */
              ],
            ),
          ),
          DrawerListButton(
            onTap: () {},
            text: AppLocalizations.of(context).translate('profile'),
            icon: Icons.account_circle_rounded,
          ),
          DrawerListButton(
            onTap: () {
              context.read<LocaleBloc>().add(LocaleChangeEvent());
            },
            text: AppLocalizations.of(context).translate('language'),
            icon: Icons.language_rounded,
          ),
          DrawerListButton(
            onTap: () {},
            text: AppLocalizations.of(context).translate('settings'),
            icon: Icons.settings_rounded,
          ),
          DrawerListButton(
            onTap: () {},
            text: AppLocalizations.of(context).translate('support'),
            icon: Icons.message_rounded,
          ),
          DrawerListButton(
            onTap: () {},
            text: AppLocalizations.of(context).translate('about'),
            icon: Icons.info_rounded,
          ),
        ],
      ),
    );
  }
}
