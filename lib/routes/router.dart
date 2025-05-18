import '/resources/pages/faqdetails_page.dart';
import '/resources/pages/privacy_page.dart';
import '/resources/pages/terms_page.dart';
import '/resources/pages/faq_page.dart';
import '/resources/pages/contactus_page.dart';
import '/resources/pages/payment_details_page.dart';
import '/resources/pages/addresses_page.dart';
import '/resources/pages/profile_details_page.dart';
import '/resources/pages/church_details_page.dart';
import '/resources/pages/all_group_page.dart';
import '/resources/pages/group_details_page.dart';
import '/resources/pages/event_details_page.dart';
import '/resources/pages/announcement_page.dart';
import '/resources/pages/donation_page.dart';
import '/resources/pages/bible_reading_page.dart';
import '/resources/pages/bible_page.dart';
import '/resources/pages/base_navigation_hub.dart';
import '/resources/pages/signup_page.dart';
import '/resources/pages/signin_page.dart';
import '/resources/pages/not_found_page.dart';
import '/resources/pages/home_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

/* App Router
|--------------------------------------------------------------------------
| * [Tip] Create pages faster 🚀
| Run the below in the terminal to create new a page.
| "dart run nylo_framework:main make:page profile_page"
|
| * [Tip] Add authentication 🔑
| Run the below in the terminal to add authentication to your project.
| "dart run scaffold_ui:main auth"
|
| * [Tip] Add In-app Purchases 💳
| Run the below in the terminal to add In-app Purchases to your project.
| "dart run scaffold_ui:main iap"
|
| Learn more https://nylo.dev/docs/6.x/router
|-------------------------------------------------------------------------- */

appRouter() => nyRoutes((router) {
      router.add(HomePage.path);

      // Add your routes here ...
      // router.add(NewPage.path, transitionType: TransitionType.fade());

      // Example using grouped routes
      // router.group(() => {
      //   "route_guards": [AuthRouteGuard()],
      //   "prefix": "/dashboard"
      // }, (router) {
      //
      // });
      router.add(NotFoundPage.path).unknownRoute();
      router.add(SigninPage.path).initialRoute();
      router.add(SignupPage.path);
      router.add(BaseNavigationHub.path);
      router.add(BiblePage.path);
      router.add(BibleReadingPage.path);
      router.add(DonationPage.path);
      router.add(AnnouncementPage.path);
      router.add(EventDetailsPage.path);
      router.add(GroupDetailsPage.path);
      router.add(AllGroupPage.path);
      router.add(ChurchDetailsPage.path);
      router.add(ProfileDetailsPage.path);
      router.add(AddressesPage.path);
      router.add(PaymentDetailsPage.path);
      router.add(ContactusPage.path);
      router.add(FaqPage.path);
      router.add(TermsPage.path);
      router.add(PrivacyPage.path);
      router.add(FaqdetailsPage.path);
    });
