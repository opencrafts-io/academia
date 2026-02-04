enum TicketStubMode {
  purchasingTicket,
  allTicketsPurchased,
  eventTicketPurchased,
}

enum PaymentTypes { paybill, till, sendMoney, pochi }

final List<String> availableGenres = [
  'Meetup',
  'Party',
  'Official',
  'Physical',
  'Social',
  'Sports',
  'Conference',
  'Workshop',
  'Seminar',
  'Webinar',
  'Festival',
  'Exhibition',
  'Charity',
  'Gaming',
  'Music',
  'Arts & Culture',
  'Food & Drink',
  'Networking',
  'Education',
  'Technology',
  'Health & Wellness',
  'Other',
];

enum AttendeeStatus { valid, wrongEvent, alreadyScanned, invalid }

extension AttendeeStatusMapper on String {
  AttendeeStatus toAttendeeStatus() {
    switch (toUpperCase()) {
      case 'VALID':
        return AttendeeStatus.valid;
      case 'ALREADY_SCANNED':
        return AttendeeStatus.alreadyScanned;
      case 'WRONG_EVENT':
        return AttendeeStatus.wrongEvent;
      case 'INVALID':
      default:
        return AttendeeStatus.invalid;
    }
  }
}

//mock data
final List<String> mockUniversityData = [
  'Daystar University',
  'University of London',
  'Kenyatta University',
  'University of Nairobi',
  'Strathmore University',
  'United States International University',
  'Jomo Kenyatta University of Agriculture and Technology',
  'Dedan Kimathi University of Technology',
  'Moi University',
  'Maseno University',
];
