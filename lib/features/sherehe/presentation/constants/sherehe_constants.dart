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

enum TicketGroupTypes { individual, groupOfTwo, groupOfFive }

extension TicketGroupTypesX on TicketGroupTypes {
  // UI Label
  String get label {
    switch (this) {
      case TicketGroupTypes.individual:
        return "Individual";
      case TicketGroupTypes.groupOfTwo:
        return "Group of 2";
      case TicketGroupTypes.groupOfFive:
        return "Group of 5";
    }
  }

  // Convert TO backend value
  //placeholder for now, will adjust as needed when integrating with backend
  String get toBackend {
    switch (this) {
      case TicketGroupTypes.individual:
        return "INDIVIDUAL";
      case TicketGroupTypes.groupOfTwo:
        return "GROUP_OF_TWO";
      case TicketGroupTypes.groupOfFive:
        return "GROUP_OF_FIVE";
    }
  }

  // Convert FROM backend value
  //placeholder for now, will adjust as needed when integrating with backend
  static TicketGroupTypes fromBackend(String value) {
    switch (value) {
      case "INDIVIDUAL":
        return TicketGroupTypes.individual;
      case "GROUP_OF_TWO":
        return TicketGroupTypes.groupOfTwo;
      case "GROUP_OF_FIVE":
        return TicketGroupTypes.groupOfFive;
      default:
        throw Exception("Unknown TicketGroupTypes: $value");
    }
  }
}

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
