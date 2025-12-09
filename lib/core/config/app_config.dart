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
  static const String getSessionsForAgenda = "/sessions?Category=Panel&Category=Workshop&Category=Roundtable";
  static const String getSessionsForMentorship = "/sessions?Category=Mentorship";
  static String registerSession(int sessionId) => "/sessions/$sessionId/register";
  static String cancelSessionRegistration(int sessionId) => "/sessions/$sessionId/cancel";

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

  // 🔹 FAQs
  static const String getFaqs = "/faqs";

  // 🔹 FAQs
  static const String getProfile = "/user/profile";
  static const String updateProfile = "/user/profile";
  static const String updateProfileLanguage = "/user/profile/language";

}
