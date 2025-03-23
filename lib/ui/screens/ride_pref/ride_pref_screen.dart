import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_3_blabla_project/providers/async_value.dart';
import 'package:week_3_blabla_project/providers/ride_preference_provider.dart';
import 'package:week_3_blabla_project/ui/widgets/errors/bla_error_screen.dart';
import '../../../model/ride/ride_pref.dart';
import '../../theme/theme.dart';
import '../../../utils/animations_util.dart';
import '../rides/rides_screen.dart';
import 'widgets/ride_pref_form.dart';
import 'widgets/ride_pref_history_tile.dart';

const String blablaHomeImagePath = 'assets/images/blabla_home.png';

///
/// This screen allows user to:
/// - Enter his/her ride preference and launch a search on it
/// - Or select a last entered ride preferences and launch a search on it
///
class RidePrefScreen extends StatelessWidget {
  const RidePrefScreen({super.key});

  onRidePrefSelected(BuildContext context, RidesPreferencesProvider provider,
      RidePreference newPreference) async {
    // 1 - Update the current preference
    provider.setCurrentPreference(newPreference);

    // 2 - Navigate to the rides screen (with a bottom-to-top animation)
    await Navigator.of(context).push(
      AnimationUtils.createBottomToTopRoute(RidesScreen()),
    );

    // 3 - After wait  - Update the state   -- TODO MAKE IT WITH STATE MANAGEMENT
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RidesPreferencesProvider>(
      builder: (context, provider, child) {
        RidePreference? currentRidePreference = provider.currentPreference;
        return Stack(
          children: [
            // 1 - Background  Image
            BlaBackground(),

            // 2 - Foreground content
            Column(
              children: [
                SizedBox(height: BlaSpacings.m),
                Text(
                  "Your pick of rides at low price",
                  style: BlaTextStyles.heading.copyWith(color: Colors.white),
                ),
                SizedBox(height: 100),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
                  decoration: BoxDecoration(
                    color: Colors.white, // White background
                    borderRadius: BorderRadius.circular(16), // Rounded corners
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 2.1 Display the Form to input the ride preferences
                      RidePrefForm(
                        initialPreference: currentRidePreference,
                        onSubmit: (preference) =>
                            onRidePrefSelected(context, provider, preference),
                      ),
                      SizedBox(height: BlaSpacings.m),

                      // 2.2 Optionally display a list of past preferences
                      pastPreferenceWidget(provider, context)
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget pastPreferenceWidget(
      RidesPreferencesProvider provider, BuildContext context) {
    final rideValue = provider.pastPreferences;
    switch (rideValue.state) {
      case AsyncValueState.loading:
        return BlaError(message: "Loading...");
      case AsyncValueState.error:
        return BlaError(message: 'No Connection. Try again later');

      case AsyncValueState.success:
        final pastPreferences = rideValue.data ?? [];
        return SizedBox(
          height: 200,
          child: ListView.builder(
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: pastPreferences.length,
            itemBuilder: (ctx, index) => RidePrefHistoryTile(
              ridePref: pastPreferences[index],
              onPressed: () =>
                  onRidePrefSelected(context, provider, pastPreferences[index]),
            ),
          ),
        );
    }
  }
}

class BlaBackground extends StatelessWidget {
  const BlaBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 340,
      child: Image.asset(
        blablaHomeImagePath,
        fit: BoxFit.cover, // Adjust image fit to cover the container
      ),
    );
  }
}
