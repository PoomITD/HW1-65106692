import 'dart:io';

void main() {
  Hotel hotel = Hotel();

  hotel.rooms = [
    Room('101', 'Single', 100.0),
    Room('102', 'Double', 150.0),
    Room('103', 'Suite', 200.0),
    Room('104', 'Single', 100.0),
    Room('105', 'Double', 150.0),
  ];

  hotel.guests = [
    Guest('pumipath', 'G001'),
    Guest('aphicheat', 'G002'),
    Guest('takuya', 'G003'),
    Guest('tanapong', 'G004'),
    Guest('napatsorn', 'G005'),
  ];

  hotel.bookRoom('G001', '101');
  hotel.bookRoom('G002', '102');

  while (true) {
    print("______________[ Hotel Management ]______________");
    print("1. Manage Rooms");
    print("2. Manage Guests");
    print("3. Booking");
    print("Q. Exit");
    stdout.write("Please enter your choice (1-3 or Q): ");
    String? choice = stdin.readLineSync();

    if (choice == '1') {
      manageRooms(hotel);
    } 
    if (choice == '2') {
      manageGuests(hotel);
    } 
    if (choice == '3') {
      manageBookings(hotel);
    } 
    if (choice == 'Q' || choice == 'q') {
      break;
    } 
    if (choice != '1' && choice != '2' && choice != '3' && choice != 'Q' && choice != 'q') {
      print("Invalid choice. Please try again.");
    }
  }
}

void manageRooms(Hotel hotel) {
  while (true) {
    print("______________[ Manage Rooms ]______________");
    print("1. View Rooms");
    print("0. Back");
    stdout.write("Please enter your choice (0-1): ");
    String? choice = stdin.readLineSync();

    if (choice == '1') {
      if (hotel.rooms.isEmpty) {
        print("No rooms available.");
      } else {
        for (Room room in hotel.rooms) {
          print("Room Number: ${room.roomNumber}, Type: ${room.roomType}, Price: ${room.price}, Booked: ${room.isBooked}");
        }
      }
    }
    if (choice == '0') {
      break;
    } 
    if (choice != '1' && choice != '0') {
      print("Invalid choice. Please try again.");
    }
  }
}

void manageGuests(Hotel hotel) {
  while (true) {
    print("______________[ Manage Guests ]______________");
    print("1. View Guests");
    print("0. Back");
    stdout.write("Please enter your choice (0-1): ");
    String? choice = stdin.readLineSync();

    if (choice == '1') {
      if (hotel.guests.isEmpty) {
        print("No guests registered.");
      } else {
        for (Guest guest in hotel.guests) {
          print("Guest Name: ${guest.name}, Guest ID: ${guest.guestId}");
        }
      }
    }
    if (choice == '0') {
      break;
    } 
    if (choice != '1' && choice != '0') {
      print("Invalid choice. Please try again.");
    }
  }
}

void manageBookings(Hotel hotel) {
  while (true) {
    print("______________[ Manage Bookings ]______________");
    print("1. Book Room");
    print("2. Cancel Room Booking");
    print("3. View Bookings");
    print("0. Back");
    stdout.write("Please enter your choice (0-3): ");
    String? choice = stdin.readLineSync();

    if (choice == '1') {
      stdout.write("Enter guest ID: ");
      String? guestId = stdin.readLineSync();
      stdout.write("Enter room number to book: ");
      String? roomNumber = stdin.readLineSync();
      if (guestId != null && roomNumber != null) {
        hotel.bookRoom(guestId, roomNumber);
      } else {
        print("Invalid input. Please try again.");
      }
    }
    if (choice == '2') {
      stdout.write("Enter guest ID: ");
      String? guestId = stdin.readLineSync();
      stdout.write("Enter room number to cancel booking: ");
      String? roomNumber = stdin.readLineSync();
      if (guestId != null && roomNumber != null) {
        hotel.cancelRoom(guestId, roomNumber);
      } else {
        print("Invalid input. Please try again.");
      }
    }
    if (choice == '3') {
      for (Guest guest in hotel.guests) {
        if (guest.bookedRooms.isNotEmpty) {
          print("Guest: ${guest.name}");
          for (Room room in guest.bookedRooms) {
            print("Room Number: ${room.roomNumber}, Type: ${room.roomType}, Price: ${room.price}");
          }
        }
      }
    }
    if (choice == '0') {
      break;
    } 
    if (choice != '1' && choice != '2' && choice != '3' && choice != '0') {
      print("Invalid choice. Please try again.");
    }
  }
}

class Room {
  String roomNumber;
  String roomType;
  double price;
  bool isBooked;

  Room(this.roomNumber, this.roomType, this.price) : isBooked = false;

  void bookRoom() {
    if (!isBooked) {
      isBooked = true;
      print("Room $roomNumber has been booked.");
    } else {
      print("Room $roomNumber is already booked.");
    }
  }

  void cancelBooking() {
    if (isBooked) {
      isBooked = false;
      print("Booking for room $roomNumber has been cancelled.");
    } else {
      print("Room $roomNumber is not booked yet.");
    }
  }
}

class Guest {
  String name;
  String guestId;
  List<Room> bookedRooms = [];

  Guest(this.name, this.guestId);

  void bookRoom(Room room) {
    if (!room.isBooked) {
      room.bookRoom();
      bookedRooms.add(room);
    } else {
      print("Room ${room.roomNumber} is already booked.");
    }
  }

  void cancelRoom(Room room) {
    if (room.isBooked) {
      room.cancelBooking();
      bookedRooms.remove(room);
    } else {
      print("Room ${room.roomNumber} is not booked yet.");
    }
  }
}

class Hotel {
  List<Room> rooms = [];
  List<Guest> guests = [];

  void addRoom(Room room) {
    rooms.add(room);
    print("Room ${room.roomNumber} has been added.");
  }

  void removeRoom(Room room) {
    rooms.remove(room);
    print("Room ${room.roomNumber} has been removed.");
  }

  void registerGuest(Guest guest) {
    guests.add(guest);
    print("Guest ${guest.name} has been registered.");
  }

  void bookRoom(String guestId, String roomNumber) {
    Guest? guest = getGuest(guestId);
    Room? room = getRoom(roomNumber);
    if (guest != null && room != null) {
      guest.bookRoom(room);
    } else {
      print("Guest or Room not found.");
    }
  }

  void cancelRoom(String guestId, String roomNumber) {
    Guest? guest = getGuest(guestId);
    Room? room = getRoom(roomNumber);
    if (guest != null && room != null) {
      guest.cancelRoom(room);
    } else {
      print("Guest or Room not found.");
    }
  }

  Room? getRoom(String roomNumber) {
    for (Room room in rooms) {
      if (room.roomNumber == roomNumber) {
        return room;
      }
    }
    return null;
  }

  Guest? getGuest(String guestId) {
    for (Guest guest in guests) {
      if (guest.guestId == guestId) {
        return guest;
      }
    }
    return null;
  }
}
