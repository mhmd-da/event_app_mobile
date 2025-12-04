class AppConfig {
  static const String baseUrl = "https://mondial-unaskingly-kent.ngrok-free.dev/api";

  // 🔹 Auth Endpoints
  static const String login = "/auth/login";

  // 🔹 Events Endpoints
  static const String getEvents = "/events";
  static String getEventDetails(int eventId) => "/events/$eventId";

  // 🔹 Speakers Endpoints
  static String getSpeakers(int eventId, String? search) => "/speakers?EventId=$eventId&Search=$search";

  // 🔹 Sessions Endpoints
  static String getSessionsForAgenda(int eventId) => "/sessions?EventId=$eventId&Category=Panel&Category=Workshop&Category=Roundtable";
  static String getSessions(int eventId) => "/sessions?EventId=$eventId";
  static String registerSession(int sessionId) => "/sessions/$sessionId/register";
  static String cancelSessionRegistration(int sessionId) => "/sessions/$sessionId/cancel";

  // 🔹 Workshops Endpoints
  static const String getWorkshops = "/workshops";
  static const String registerWorkshop = "/workshops/register";

  // 🔹 Mentorship Endpoints
  static String getMentors(int eventId, String? search) => "/mentors?EventId=$eventId&Search=$search";
  static const String getMentorSlots = "/mentorship/slots";
  static const String bookMentor = "/mentorship/book";

  // 🔹 My Schedule
  static String getMySchedule(int eventId) => "/my-schedule/$eventId";
  static String cancelWorkshop(int eventId) => "/my-schedule/$eventId/cancel-workshop";
  static String cancelMentorship(int eventId) => "/my-schedule/$eventId/cancel-mentorship";

  // 🔹 Notifications
  static const String getNotifications = "/notifications";
  static const String markNotificationRead = "/notifications/mark-read";

  // 🔹 FAQs
  static String getFaqs(int eventId) => "/faqs?EventId=$eventId";

  // 🔹 FAQs
  static const String getProfile = "/user/profile";
  static const String updateProfile = "/user/profile";
  static const String updateProfileLanguage = "/user/profile/language";

}
