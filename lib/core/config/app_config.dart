class AppConfig {
  static const String baseApiUrl =
      "https://api.event-management-digital-ocean.online/api";

  // 🔹 Events Endpoints
  static const String getEvents = "/events";
  static String getEventDetails(int eventId) => "/events/$eventId";

  // 🔹 Speakers Endpoints
  static String getSpeakers(String? search) => "/speakers?Search=$search";
  static String getSpeakerDetails(int speakerId) => "/speakers/$speakerId";

  // 🔹 Sessions Endpoints
  static const String getSessionsForAgenda = "/sessions";
  static String getSessionsByCategory(String category) =>
      "/sessions?Category=$category";
  static const String getSessionsForMentorship =
      "/sessions?Category=Mentorship";
  static String submitSessionFeedback(int sessionId) =>
      "/sessions/$sessionId/feedback";

  // 🔹 Workshops Endpoints
  static const String getWorkshops = "/workshops";

  // 🔹 Mentorship Endpoints
  static String getMentors(String? search) =>
      "/mentorship/mentors?Search=$search";
  static String getMentorDetails(int mentorId) =>
      "/mentorship/mentors/$mentorId";
  static String getMentorshipDetails(int sessionId) =>
      "/mentorship/$sessionId/details";

  // 🔹 Sponsors & Partners
  static const String getSponsors = "/sponsors";
  static const String getPartners = "/partners";

  // 🔹 FAQs
  static const String getFaqs = "/faqs";

  // 🔹 Contact Requests
  static const String submitContactRequest = "/contact-request";

  // 🔹 Event Photos
  static String getEventPhotos(
    int eventId, {
    int pageIndex = 1,
    int pageSize = 24,
  }) {
    return "/events/$eventId/photos?pageIndex=$pageIndex&pageSize=$pageSize";
  }



}
