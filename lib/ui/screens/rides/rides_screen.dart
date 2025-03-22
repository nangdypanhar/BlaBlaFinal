import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week_3_blabla_project/model/ride/ride.dart';
import 'package:week_3_blabla_project/providers/ride_preference_provider.dart';
import '../../../model/ride/ride_filter.dart';
import 'widgets/ride_pref_bar.dart';
import '../../../model/ride/ride_pref.dart';
import '../../../service/rides_service.dart';
import '../../theme/theme.dart';
import '../../../utils/animations_util.dart';
import 'widgets/ride_pref_modal.dart';
import 'widgets/rides_tile.dart';

///
///  The Ride Selection screen allow user to select a ride, once ride preferences have been defined.
///  The screen also allow user to re-define the ride preferences and to activate some filters.
///
class RidesScreen extends StatelessWidget {
  RidesScreen({super.key});
  final RideFilter currentFilter = RideFilter();

  List<Ride> matchingRides(RidesPreferencesProvider provider) {
    return RidesService.instance
        .getRidesFor(provider.currentPreference!, currentFilter);
  }

  void onBackPressed(BuildContext context) {
    // 1 - Back to the previous view
    Navigator.of(context).pop();
  }

  onRidePrefSelected(BuildContext context, RidesPreferencesProvider provider,
      RidePreference newPreference) async {
    provider.setCurrentPreference(newPreference);
  }

  void onPreferencePressed(
      BuildContext context, RidesPreferencesProvider provider) async {
    // Open a modal to edit the ride preferences
    RidePreference? newPreference = await Navigator.of(
      context,
    ).push<RidePreference>(
      AnimationUtils.createTopToBottomRoute(
        RidePrefModal(initialPreference: provider.currentPreference),
      ),
    );

    if (newPreference != null) {
      // 1 - Update the current preference
      provider.setCurrentPreference(newPreference);
      // 2 -   Update the state   -- TODO MAKE IT WITH STATE MANAGEMENT
    }
  }

  void onFilterPressed() {}

  @override
  Widget build(BuildContext context) {
    return Consumer<RidesPreferencesProvider>(
      builder: (context, provider, child) {
        List<Ride> rides = matchingRides(provider);

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(
              left: BlaSpacings.m,
              right: BlaSpacings.m,
              top: BlaSpacings.s,
            ),
            child: Column(
              children: [
                // Top search Search bar
                RidePrefBar(
                  ridePreference: provider.currentPreference!,
                  onBackPressed: () => onBackPressed(context),
                  onPreferencePressed: () =>
                      onPreferencePressed(context, provider),
                  onFilterPressed: onFilterPressed,
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: rides.length,
                    itemBuilder: (ctx, index) =>
                        RideTile(ride: rides[index], onPressed: () {}),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
