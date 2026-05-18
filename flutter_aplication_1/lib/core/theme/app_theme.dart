import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme =
      ThemeData(
        useMaterial3: true,

        scaffoldBackgroundColor:
            AppColors.background,

        primaryColor:
            AppColors.primary,

        fontFamily: 'Roboto',

        colorScheme: ColorScheme.fromSeed(
          seedColor:
              AppColors.primary,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor:
              AppColors.primary,

          foregroundColor:
              Colors.white,

          elevation: 0,

          centerTitle: true,
        ),

        elevatedButtonTheme:
            ElevatedButtonThemeData(
              style:
                  ElevatedButton.styleFrom(
                    backgroundColor:
                        AppColors.primary,

                    foregroundColor:
                        Colors.white,

                    elevation: 0,

                    minimumSize:
                        const Size(
                          double.infinity,
                          55,
                        ),

                    shape:
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                                12,
                              ),
                        ),
                  ),
            ),

        inputDecorationTheme:
            InputDecorationTheme(
              filled: true,

              fillColor:
                  AppColors.white,

              contentPadding:
                  const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),

              border:
                  OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                          12,
                        ),

                    borderSide:
                        const BorderSide(
                          color:
                              AppColors
                                  .border,
                        ),
                  ),

              enabledBorder:
                  OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                          12,
                        ),

                    borderSide:
                        const BorderSide(
                          color:
                              AppColors
                                  .border,
                        ),
                  ),

              focusedBorder:
                  OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(
                          12,
                        ),

                    borderSide:
                        const BorderSide(
                          color:
                              AppColors
                                  .primary,
                          width: 1.5,
                        ),
                  ),
            ),

       cardTheme: CardThemeData(
  color: AppColors.card,

  elevation: 1,

  shape:
      RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(
              16,
            ),
      ),
),

        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(
              selectedItemColor:
                  AppColors.primary,

              unselectedItemColor:
                  Colors.grey,

              backgroundColor:
                  Colors.white,

              elevation: 8,

              type:
                  BottomNavigationBarType
                      .fixed,
            ),

        progressIndicatorTheme:
            const ProgressIndicatorThemeData(
              color:
                  AppColors.primary,
            ),
      );
}