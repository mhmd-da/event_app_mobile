class AppConfig {
  static const String baseUrl = "https://api.event-management-digital-ocean.online/api";

  // 🔹 Auth Endpoints
  static const String login = "/auth/login";
  static const String register = "/user/register";
  static const String resendVerificationCode = "/user/send-verification-code";
  static const String verifyCode = "/user/verify-code";

  // 🔹 Events Endpoints
  static const String getEvents = "/events";
  static String getEventDetails(int eventId) => "/events/$eventId";

  // 🔹 Speakers Endpoints
  static String getSpeakers(String? search) => "/speakers?Search=$search";

  // 🔹 Sessions Endpoints
  static const String getSessionsForAgenda = "/sessions";
  static String getSessionsByCategory(String category) => "/sessions?Category=$category";
  static const String getSessionsForMentorship = "/sessions?Category=Mentorship";
  static String registerSession(int sessionId) => "/sessions/$sessionId/register";
  static String cancelSessionRegistration(int sessionId) => "/sessions/$sessionId/cancel";
  static String submitSessionFeedback(int sessionId) => "/sessions/$sessionId/feedback";

  // 🔹 Workshops Endpoints
  static const String getWorkshops = "/workshops";
  static const String registerWorkshop = "/workshops/register";

  // 🔹 Mentorship Endpoints
  static String getMentors(String? search) => "/mentorship/mentors?Search=$search";
  static String getMentorshipDetails(int sessionId) => "/mentorship/$sessionId/details";
  static const String bookTimeSlot = "/mentorship/slots/book";
  static const String cancelTimeSlot = "/mentorship/slots/cancel";

  // 🔹 My Schedule
  static const String getMySchedule = "/my-schedule";
  static const String cancelWorkshop = "/my-schedule/cancel-workshop";
  static const String cancelMentorship = "/my-schedule/cancel-mentorship";

  // 🔹 Notifications
  static const String getNotifications = "/notifications";
  static const String markNotificationRead = "/notifications/mark-read";
  static String getNotificationsPaged(int pageIndex, int pageSize) =>
      "/notifications?pageIndex=$pageIndex&pageSize=$pageSize";

  // 🔹 Sponsors & Partners
  static const String getSponsors = "/sponsors";
  static const String getPartners = "/partners";

  // 🔹 Session Reminder (server-driven notifications)
  static String setSessionReminder(int sessionId) => "/sessions/$sessionId/reminder"; // PUT
  static String deleteSessionReminder(int sessionId) => "/sessions/$sessionId/reminder"; // DELETE

  // 🔹 FAQs
  static const String getFaqs = "/faqs";

  // 🔹 FAQs
  static const String getProfile = "/user/profile";
  static const String updateProfile = "/user/profile";
  static const String registerDevice = "/user/register-device";
  static const String unregisterDevice = "/user/unregister-device"; // DELETE

  // 🔹 Contact Requests
  static const String submitContactRequest = "/contact-request";

  // 🔹 Static Maps (thumbnail previews)
  // Provide this via: --dart-define=GOOGLE_STATIC_MAPS_KEY=YOUR_KEY
  static const String googleStaticMapsKey = String.fromEnvironment(
    'GOOGLE_STATIC_MAPS_KEY',
    defaultValue: '',
  );

  static String googleStaticMapImageUrl(
    double lat,
    double lng, {
    int width = 800,
    int height = 400,
    int zoom = 15,
  }) {
    if (googleStaticMapsKey.isEmpty) return '';
    return 'https://maps.googleapis.com/maps/api/staticmap?center='
        '$lat,$lng&zoom=$zoom&size=${width}x$height&markers=color:red|$lat,$lng&key=$googleStaticMapsKey';
  }

  // 🔹 OpenStreetMap static map (free, public service — limited usage)
  // Note: staticmap.openstreetmap.de is a community service; do not use for heavy production.
  static String openStreetMapStaticImageUrl(
    double lat,
    double lng, {
    int width = 800,
    int height = 400,
    int zoom = 15,
  }) {
    return 'https://staticmap.openstreetmap.de/staticmap.php?center='
        '$lat,$lng&zoom=$zoom&size=${width}x$height&markers=$lat,$lng,red-pushpin';
  }
}
