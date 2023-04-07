INSERT INTO Countries (name)
VALUES ('USA'), ('Canada'), ('Mexico');

INSERT INTO Cities (name, country_id)
VALUES ('New York City', 1), ('Los Angeles', 1), ('Toronto', 2), ('Mexico City', 3);

INSERT INTO Hotels (name, category, city_id)
VALUES ('Marriott', 5, 1), ('Hilton', 4, 2), ('Four Seasons', 5, 3), ('Holiday Inn', 3, 4);

INSERT INTO RoomFeatures (name)
VALUES ('Satellite TV'), ('Jacuzzi'), ('Balcony');

INSERT INTO Rooms (number, hotel_id, feature_id, status)
VALUES (101, 1, 1, 'available'), (102, 1, 2, 'booked'), (201, 2, 1, 'available'), (202, 2, 3, 'available'), (301, 3, 1, 'booked'), (302, 3, 2, 'available'), (401, 4, 3, 'available');

INSERT INTO Reservations (room_id, guest_name, check_in, check_out)
VALUES (2, 'John Smith', '2021-01-01', '2021-01-03'), (5, 'Jane Doe', '2021-02-01', '2021-02-03'), (6, 'Bob Johnson', '2021-03-01', '2021-03-03');

INSERT INTO Revenue (hotel_id, date, room_feature_id, revenue)
VALUES (1, '2021-01-01', 1, 500), (1, '2021-01-01', 2, 700), (2, '2021-02-01', 1, 400), (2, '2021-02-01', 3, 600), (3, '2021-03-01', 1, 800), (3, '2021-03-01', 2, 900), (4, '2021-04-01', 3, 300);
