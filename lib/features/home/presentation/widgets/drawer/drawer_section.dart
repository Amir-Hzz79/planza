import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:planza/core/data/database/database.dart';
import 'package:planza/core/locale/bloc/locale_bloc.dart';
import 'package:planza/core/locale/bloc/locale_event.dart';
import 'package:planza/core/widgets/buttons/profile_button.dart';

import '../../../../../core/locale/app_localizations.dart';
import '../../../../../core/theme/bloc/theme_bloc.dart';
import 'drawer_list_button.dart';

class DrawerSection extends StatefulWidget {
  const DrawerSection({super.key});

  @override
  State<DrawerSection> createState() => _DrawerSectionState();
}

class _DrawerSectionState extends State<DrawerSection> {
  @override
  Widget build(BuildContext context) {
    Lang lang = Lang.of(context)!;

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
                                    ? Icons.light_mode_rounded
                                    : Icons.dark_mode_rounded,
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
            text: lang.general_profile,
            icon: Icons.account_circle_rounded,
          ),
          DrawerListButton(
            onTap: () {
              context.read<LocaleBloc>().add(LocaleChangeEvent());
            },
            text: lang.general_language,
            icon: Icons.language_rounded,
          ),
          DrawerListButton(
            onTap: () {},
            text: lang.general_settings,
            icon: Icons.settings_rounded,
          ),
          DrawerListButton(
            onTap: () {},
            text: lang.general_support,
            icon: Icons.message_rounded,
          ),
          DrawerListButton(
            onTap: () {},
            text: lang.general_about,
            icon: Icons.info_rounded,
          ),
          DrawerListButton(
            onTap: () {
              GetIt.instance.get<AppDatabase>().insertDummyData();

              setState(() {});
            },
            text: 'Insert Dummy Data (Debug)',
            icon: Icons.data_array_rounded,
          ),
        ],
      ),
    );
  }
}
