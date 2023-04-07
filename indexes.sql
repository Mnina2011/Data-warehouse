-- add index for Cities table
CREATE INDEX idx_cities_country_id ON Cities (country_id);

-- add index for Hotels table
CREATE INDEX idx_hotels_city_id ON Hotels (city_id);

-- add index for Rooms table
CREATE INDEX idx_rooms_hotel_id ON Rooms (hotel_id);
CREATE INDEX idx_rooms_feature_id ON Rooms (feature_id);

-- add index for Reservations table
CREATE INDEX idx_reservations_room_id ON Reservations (room_id);

-- add index for Revenue table
CREATE INDEX idx_revenue_hotel_id ON Revenue (hotel_id);
CREATE INDEX idx_revenue_date ON Revenue (date);
CREATE INDEX idx_revenue_feature_id ON Revenue (room_feature_id);
