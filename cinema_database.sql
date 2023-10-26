-- create database
CREATE DATABASE cinema;
\c cinema
-- TABLE DEFINITION
-- Hoi_vien(Muc_hoi_vien, Muc_giam_gia)
-- Phim(Ma_phim, Thoi_luong, Rating)
-- Phong_chieu(Ma_phong, So_hang, So_cot, Loai_phong)
-- Ghe(Ma_ghe, Hang, Cot, Ma_phong)
-- Lich_lam_viec(Ma_lich_lam_viec, Ngay_lam_viec, Gio_bat_dau, Gio_ket_thuc)
-- Phim_Ten_phim(Ten_phim, Ma_phim)
-- Phim_The_loai(The_loai, Ma_phim)
-- Phim_Dao_dien(Dao_dien, Ma_phim)
-- Phim_Dien_vien(Dien_vien, Ma_phim)
-- Lich_chieu(Ma_lich_chieu, Ngay_chieu, Loai_ngay, Gio_chieu, Gio_ket_thuc, Ma_phim, Ma_phong)
-- Ve(Ma_ve, Gia_ve, Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
-- Khach_hang(Ma_khach_hang, Ten_khach_hang, Dia_chi, So_dien_thoai, Muc_hoi_vien)

-- ================================================================================
-- Create sequence for Ma_lich_chieu
CREATE SEQUENCE lich_chieu_ma_lich_chieu_seq;

-- Create sequence for Ma_ve
CREATE SEQUENCE ve_ma_ve_seq;

-- Hoi_vien(Muc_hoi_vien, Muc_giam_gia)
CREATE TABLE Hoi_vien
(
  Muc_hoi_vien INT NOT NULL,
  Muc_giam_gia INT NOT NULL,
  PRIMARY KEY (Muc_hoi_vien)
);

-- Phim(Ma_phim, Thoi_luong, Rating)
CREATE TABLE Phim
(
  Ma_phim VARCHAR(50) NOT NULL,
  Thoi_luong TIME NOT NULL,
  Rating VARCHAR(5),
  PRIMARY KEY (Ma_phim)
);

-- Phong_chieu(Ma_phong, So_hang, So_cot, Loai_phong)
CREATE TABLE Phong_chieu
(
  Ma_phong VARCHAR(50) NOT NULL,
  So_hang INT NOT NULL CHECK (So_hang > 0 AND So_hang < 26),
  So_cot INT NOT NULL,
  Loai_phong VARCHAR(255) NOT NULL,
  PRIMARY KEY (Ma_phong)
);

-- Ghe(Ma_ghe, Hang, Cot, Ma_phong)
CREATE TABLE Ghe
(
  Ma_ghe VARCHAR(50) NOT NULL,
  Hang CHAR(1) NOT NULL CHECK (Hang >= 'A' AND Hang <= 'Z'),
  Cot INT NOT NULL,
  Ma_phong VARCHAR(50) NOT NULL,
  PRIMARY KEY (Ma_ghe),
  FOREIGN KEY (Ma_phong) REFERENCES Phong_chieu(Ma_phong)
);

-- Lich_lam_viec(Ma_lich_lam_viec, Ngay_lam_viec, Gio_bat_dau, Gio_ket_thuc)
CREATE TABLE Lich_lam_viec
(
  Ma_lich_lam_viec VARCHAR(10) NOT NULL,
  Ngay_lam_viec VARCHAR(20) NOT NULL,
  Gio_bat_dau TIME NOT NULL,
  Gio_ket_thuc TIME NOT NULL,
  PRIMARY KEY (Ma_lich_lam_viec)
);

-- Phim_Ten_phim(Ten_phim, Ma_phim)
CREATE TABLE Phim_Ten_phim
(
  Ten_phim VARCHAR(255) NOT NULL,
  Ma_phim VARCHAR(50) NOT NULL,
  PRIMARY KEY (Ten_phim, Ma_phim),
  FOREIGN KEY (Ma_phim) REFERENCES Phim(Ma_phim)
);

-- Phim_The_loai(The_loai, Ma_phim)
CREATE TABLE Phim_The_loai
(
  The_loai VARCHAR(255) NOT NULL,
  Ma_phim VARCHAR(50) NOT NULL,
  PRIMARY KEY (The_loai, Ma_phim),
  FOREIGN KEY (Ma_phim) REFERENCES Phim(Ma_phim)
);

-- Phim_Dao_dien(Dao_dien, Ma_phim)
CREATE TABLE Phim_Dao_dien
(
  Dao_dien VARCHAR(255) NOT NULL,
  Ma_phim VARCHAR(50) NOT NULL,
  PRIMARY KEY (Dao_dien, Ma_phim),
  FOREIGN KEY (Ma_phim) REFERENCES Phim(Ma_phim)
);

-- Phim_Dien_vien(Dien_vien, Ma_phim)
CREATE TABLE Phim_Dien_vien
(
  Dien_vien VARCHAR(255) NOT NULL,
  Ma_phim VARCHAR(50) NOT NULL,
  PRIMARY KEY (Dien_vien, Ma_phim),
  FOREIGN KEY (Ma_phim) REFERENCES Phim(Ma_phim)
);

-- Lich_chieu(Ma_lich_chieu, Ngay_chieu, Loai_ngay, Gio_chieu, Gio_ket_thuc, Ma_phim, Ma_phong)
CREATE TABLE Lich_chieu
(
  Ma_lich_chieu VARCHAR(50) DEFAULT CONCAT('LC', nextval('lich_chieu_ma_lich_chieu_seq')) NOT NULL,
  Ngay_chieu DATE NOT NULL,
  Loai_ngay VARCHAR(20) NOT NULL,
  Gio_chieu TIME NOT NULL,
  Gio_ket_thuc TIME NOT NULL,
  Ma_phim VARCHAR(50) NOT NULL,
  Ma_phong VARCHAR(50) NOT NULL,
  PRIMARY KEY (Ma_lich_chieu),
  FOREIGN KEY (Ma_phim) REFERENCES Phim(Ma_phim),
  FOREIGN KEY (Ma_phong) REFERENCES Phong_chieu(Ma_phong)
);

-- Ve(Ma_ve, Gia_ve, Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
CREATE TABLE Ve
(
  Ma_ve INT DEFAULT nextval('ve_ma_ve_seq') NOT NULL,
  Gia_ve INT NOT NULL,
  Danh_gia INT CHECK (Danh_gia BETWEEN 1 AND 5),
  Ma_lich_chieu VARCHAR(50) NOT NULL,
  Ma_ghe VARCHAR(50) NOT NULL,
  Muc_hoi_vien INT NOT NULL,
  PRIMARY KEY (Ma_ve),
  FOREIGN KEY (Ma_lich_chieu) REFERENCES Lich_chieu(Ma_lich_chieu),
  FOREIGN KEY (Ma_ghe) REFERENCES Ghe(Ma_ghe),
  FOREIGN KEY (Muc_hoi_vien) REFERENCES Hoi_vien(Muc_hoi_vien)
);

-- Khach_hang(Ma_khach_hang, Ten_khach_hang, Dia_chi, So_dien_thoai, Muc_hoi_vien)
CREATE TABLE Khach_hang
(
  Ma_khach_hang INT NOT NULL,
  Ten_khach_hang VARCHAR(255) NOT NULL,
  Dia_chi VARCHAR(255) NOT NULL,
  So_dien_thoai VARCHAR(20) NOT NULL,
  Muc_hoi_vien INT NOT NULL,
  PRIMARY KEY (Ma_khach_hang),
  FOREIGN KEY (Muc_hoi_vien) REFERENCES Hoi_vien(Muc_hoi_vien)
);

-- Nhan_vien(Ma_nhan_vien, Ten_nhan_vien, Chuc_vu, So_dien_thoai, Luong, Ma_lich_lam_viec)
CREATE TABLE Nhan_vien
(
  Ma_nhan_vien VARCHAR(50) NOT NULL,
  Ten_nhan_vien VARCHAR(255) NOT NULL,
  Chuc_vu VARCHAR(255) NOT NULL,
  So_dien_thoai VARCHAR(20) NOT NULL,
  Luong INT NOT NULL,
  Ma_lich_lam_viec VARCHAR(50) NOT NULL,
  PRIMARY KEY (Ma_nhan_vien),
  FOREIGN KEY (Ma_lich_lam_viec) REFERENCES Lich_lam_viec(Ma_lich_lam_viec)
);


--Triggers and Functions
-- Trigger and function to automatically add seats of Phong_chieu to Ghe table
--Function
CREATE OR REPLACE FUNCTION add_seats_to_ghe()
RETURNS TRIGGER AS $$
BEGIN
    FOR r IN 1..NEW.So_hang LOOP
        FOR c IN 1..NEW.So_cot LOOP
            INSERT INTO Ghe (Ma_ghe, Hang, Cot, Ma_phong)
            VALUES (CONCAT(NEW.Ma_phong, '_', CHR(64 + r)::CHAR(1), c), CHR(64 + r)::CHAR(1), c, NEW.Ma_phong);
        END LOOP;
    END LOOP;
    
    RAISE NOTICE 'Seats have been successfully added to the Ghe table.';
    
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
--Trigger
CREATE TRIGGER add_seats_trigger
AFTER INSERT ON Phong_chieu
FOR EACH ROW
EXECUTE FUNCTION add_seats_to_ghe();
--Trigger and function to automatically add gio_ket_thuc to Lich_chieu
--Function
CREATE OR REPLACE FUNCTION calculate_gio_ket_thuc()
  RETURNS TRIGGER AS
$$
DECLARE
  phim_thoi_luong INTERVAL;
BEGIN
  SELECT Thoi_luong INTO phim_thoi_luong FROM Phim WHERE Ma_phim = NEW.Ma_phim;
  NEW.Gio_ket_thuc := NEW.Gio_chieu + INTERVAL '10 minutes' + phim_thoi_luong;
  RETURN NEW;
END;
$$
LANGUAGE plpgsql;
--Trigger
CREATE TRIGGER tg_calculate_gio_ket_thuc
  BEFORE INSERT OR UPDATE ON Lich_chieu
  FOR EACH ROW
  EXECUTE FUNCTION calculate_gio_ket_thuc();
--Trigger and function to ensure Lich_chieu doesn't have conflicts
--Funciton
CREATE OR REPLACE FUNCTION check_duplicate_lich_chieu()
  RETURNS TRIGGER AS
$$
DECLARE
  count_rows INT;
BEGIN
  SELECT COUNT(*) INTO count_rows FROM Lich_chieu
  WHERE Ngay_chieu = NEW.Ngay_chieu
    AND Ma_phong = NEW.Ma_phong
    AND  (NEW.Gio_chieu >= Gio_chieu AND NEW.Gio_chieu < Gio_ket_thuc );

  IF count_rows > 0 THEN
    RAISE EXCEPTION 'The time slot and screening room are already in use.';
 RETURN NULL;
  END IF;

  RETURN NEW;
END;
$$
LANGUAGE plpgsql;
--Trigger
CREATE TRIGGER tg_check_duplicate_lich_chieu
  BEFORE INSERT ON Lich_chieu
  FOR EACH ROW
  EXECUTE FUNCTION check_duplicate_lich_chieu();
--Trigger and Function to calculate ticket_price
--Function
CREATE OR REPLACE FUNCTION calculate_ticket_price()
  RETURNS TRIGGER AS
$$
DECLARE
  ticket_price INT;
  hoi_vien_muc_giam_gia INT;
  loai_phong VARCHAR(255);
  loai_ngay VARCHAR(20);
BEGIN
  SELECT Muc_giam_gia INTO hoi_vien_muc_giam_gia FROM Hoi_vien WHERE Muc_hoi_vien = NEW.Muc_hoi_vien;

  IF hoi_vien_muc_giam_gia IS NULL THEN
    RAISE EXCEPTION 'Invalid Muc_hoi_vien: %', NEW.Muc_hoi_vien;
  END IF;

  SELECT Lich_chieu.Loai_ngay, Phong_chieu.Loai_phong INTO loai_ngay, loai_phong 
  FROM Lich_chieu
  JOIN Phong_chieu ON Lich_chieu.Ma_phong = Phong_chieu.Ma_phong
  WHERE Lich_chieu.Ma_lich_chieu = NEW.Ma_lich_chieu;

  IF loai_ngay IS NULL OR loai_phong IS NULL THEN
    RAISE EXCEPTION 'Invalid Ma_lich_chieu: %', NEW.Ma_lich_chieu;
  END IF;
  
  IF loai_ngay = 'Normal' THEN
    ticket_price := 40;
  ELSIF loai_ngay = 'Special' THEN
    ticket_price := 60;
  ELSE
    RAISE EXCEPTION 'Invalid Loai_ngay: %', loai_ngay;
  END IF;

  ticket_price := ticket_price - hoi_vien_muc_giam_gia;

  IF loai_phong = '2D' THEN
    ticket_price := ticket_price;
  ELSIF loai_phong = '3D' THEN
    ticket_price := ticket_price + 20;
  ELSIF loai_phong = 'IMAX' THEN
    ticket_price := ticket_price + 25;
  ELSE
    RAISE EXCEPTION 'Invalid Loai_phong: %', loai_phong;
  END IF;

  NEW.Gia_ve := ticket_price;
  RETURN NEW;
END;
$$
LANGUAGE plpgsql;
--Trigger
CREATE TRIGGER tg_calculate_ticket_price
BEFORE INSERT ON Ve
FOR EACH ROW
EXECUTE FUNCTION calculate_ticket_price();
--Trigger and function to check if a seat availability
--Function
CREATE OR REPLACE FUNCTION check_seat_availability()
  RETURNS TRIGGER AS
$$
BEGIN
  IF EXISTS (
    SELECT 1 FROM Ve
    WHERE Ma_lich_chieu = NEW.Ma_lich_chieu
      AND Ma_ghe = NEW.Ma_ghe
  ) THEN
    RAISE NOTICE 'The seat is already taken.';
    RETURN NULL;
  END IF;

  RETURN NEW;
END;
$$
LANGUAGE plpgsql;
--Trigger
CREATE TRIGGER tg_check_seat_availability
  BEFORE INSERT ON Ve
  FOR EACH ROW
  EXECUTE FUNCTION check_seat_availability();


--cấp quyền cho khách hàng

create ROLE Khach_hang with login password 'Khach_hang';
--Quyền xem
grant select on all tables in schema public to Khach_hang;
REVOKE select on table Lich_lam_viec,Nhan_vien from Khach_hang;
-- Quyền sửa
grant update on table Khach_hang to Khach_hang;



--cấp quyền cho nhân viên

create role Nhan_vien with login password 'Nhan_vien';
--Quyền xem
GRANT SELECT ON ALL TABLES IN SCHEMA public TO Nhan_Vien;
REVOKE SELECT ON TABLE Lich_lam_viec FROM Nhan_Vien;
REVOKE SELECT ON TABLE Nhan_vien FROM Nhan_Vien;
--Quyền xóa
GRANT DELETE ON TABLE Khach_hang to Nhan_vien;
--Quyền sửa
GRANT update on TABLE Ve,Khach_hang to Nhan_vien;



--cấp quyền cho quản lí

create role Quan_li with login password 'Quan_li';
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO Quan_li;  

  --Data
  INSERT INTO Phong_chieu (Ma_phong, So_hang, So_cot, Loai_phong)
VALUES ('PC001', 15, 20,  '2D'),
('PC002', 20, 20, '3D'),
('PC003', 20, 20, 'IMAX'),
('PC004', 15, 15, '2D'),
('PC005', 15, 15, '2D')
;

-- Add Muc_hoi_vien values 0, 1, and 2 with corresponding Muc_giam_gia values to Hoi_vien table
INSERT INTO Hoi_vien (Muc_hoi_vien, Muc_giam_gia)
VALUES (0, 0),
       (1, 5),
       (2, 10);


-- Add Phim (Movie) record
INSERT INTO Phim (Ma_phim, Thoi_luong, Rating)
VALUES ('P001', '01:40:00', 'T16');

-- Add Phim_Ten_phim (Movie_Title) records
INSERT INTO Phim_Ten_phim (Ten_phim, Ma_phim)
VALUES ('Nhiệm Vụ: Bất Khả Thi Nghiệp Báo Phần Một', 'P001'),
       ('Mission: Impossible - Dead Reckoning Part One', 'P001');

-- Add Phim_The_loai (Movie_Genre) records
INSERT INTO Phim_The_loai (The_loai, Ma_phim)
VALUES ('Hành Động', 'P001'),
       ('Action', 'P001'),
       ('Phiêu Lưu', 'P001'),
       ('Adventure', 'P001'),
       ('Gay Cấn', 'P001'),
       ('Thriller', 'P001');

-- Add Phim_Dao_dien (Movie_Director) record
INSERT INTO Phim_Dao_dien (Dao_dien, Ma_phim)
VALUES ('Christopher McQuarrie', 'P001');

-- Add Phim_Dien_vien (Movie_Actor) records
INSERT INTO Phim_Dien_vien (Dien_vien, Ma_phim)
VALUES ('Tom Cruise', 'P001'),
       ('Rebecca Ferguson', 'P001'),
       ('Ving Rhames', 'P001'),
       ('Simon Pegg', 'P001'),
       ('Hayley Atwell', 'P001'),
       ('Vanessa Kirby', 'P001'),
       ('Esai Morales', 'P001');

-- Add Phim (Movie) record
INSERT INTO Phim (Ma_phim, Thoi_luong, Rating)
VALUES ('P002', '01:59:00', 'T13');

-- Add Phim_Ten_phim (Movie_Title) records
INSERT INTO Phim_Ten_phim (Ten_phim, Ma_phim)
VALUES ('Cô Thành Trong Gương', 'P002'),
       ('Lonely Castle In The Mirror', 'P002');

-- Add Phim_Dao_dien (Movie_Director) record
INSERT INTO Phim_Dao_dien (Dao_dien, Ma_phim)
VALUES ('hara keiichi', 'P002');

-- Add Phim_Dien_vien (Movie_Actor) records
INSERT INTO Phim_Dien_vien (Dien_vien, Ma_phim)
VALUES ('ami touma', 'P002'),
       ('Takumi Kitamura', 'P002'),
       ('ashida mana', 'P002');

-- Add Phim_The_loai (Movie_Genre) records
INSERT INTO Phim_The_loai (The_loai, Ma_phim)
VALUES ('Animation', 'P002');

-- Add Phim (Movie) record
INSERT INTO Phim (Ma_phim, Thoi_luong, Rating)
VALUES ('P003', '02:00:00', 'T13');

-- Add Phim_Ten_phim (Movie_Title) records
INSERT INTO Phim_Ten_phim (Ten_phim, Ma_phim)
VALUES ('INDIANA JONES & VÒNG QUAY ĐỊNH MỆNH', 'P003'),
       ('Indiana Jones and the Dial of Destiny', 'P003');

-- Add Phim_Dao_dien (Movie_Director) record
INSERT INTO Phim_Dao_dien (Dao_dien, Ma_phim)
VALUES ('James Mangold', 'P003');

-- Add Phim_Dien_vien (Movie_Actor) records
INSERT INTO Phim_Dien_vien (Dien_vien, Ma_phim)
VALUES ('Boyd Holbrook', 'P003'),
       ('Thomas Kretschmann', 'P003'),
       ('Mads Mikkelsen', 'P003'),
       ('Harrison Ford', 'P003'),
       ('Phoebe Waller-Bridge', 'P003'),
       ('Shaunette Renée Wilson', 'P003');

-- Add Phim_The_loai (Movie_Genre) records
INSERT INTO Phim_The_loai (The_loai, Ma_phim)
VALUES ('Action', 'P003'),
       ('Adventure', 'P003');

-- Add Phim (Movie) record
INSERT INTO Phim (Ma_phim, Thoi_luong, Rating)
VALUES ('P004', '01:40:00', 'T16');

-- Add Phim_Ten_phim (Movie_Title) records
INSERT INTO Phim_Ten_phim (Ten_phim, Ma_phim)
VALUES ('Transformers: Quái Thú Trỗi Dậy', 'P004'),
       ('Transformers: Rise Of The Beasts', 'P004');

-- Add Phim_Dao_dien (Movie_Director) record
INSERT INTO Phim_Dao_dien (Dao_dien, Ma_phim)
VALUES ('steven caple jr.', 'P004');

-- Add Phim_Dien_vien (Movie_Actor) records
INSERT INTO Phim_Dien_vien (Dien_vien, Ma_phim)
VALUES ('Anthony Ramos', 'P004'),
       ('dominique fishback', 'P004'),
       ('tobe nwigwe', 'P004'),
       ('Peter Cullen', 'P004'),
       ('Ron Perlman', 'P004');

-- Add Phim_The_loai (Movie_Genre) records
INSERT INTO Phim_The_loai (The_loai, Ma_phim)
VALUES ('Action', 'P004');

-- Add Phim (Movie) record
INSERT INTO Phim (Ma_phim, Thoi_luong, Rating)
VALUES ('P005', '02:30:00', 'T13');

-- Add Phim_Ten_phim (Movie_Title) records
INSERT INTO Phim_Ten_phim (Ten_phim, Ma_phim)
VALUES ('Oppenheimer', 'P005');

-- Add Phim_Dao_dien (Movie_Director) record
INSERT INTO Phim_Dao_dien (Dao_dien, Ma_phim)
VALUES ('Christopher Nolan', 'P005');

-- Add Phim_Dien_vien (Movie_Actor) records
INSERT INTO Phim_Dien_vien (Dien_vien, Ma_phim)
VALUES ('Cillian Murphy', 'P005'),
       ('Emily Blunt', 'P005'),
       ('Robert Downey Jr.', 'P005'),
       ('Matt Damon', 'P005'),
       ('florence pugh', 'P005'),
       ('rami malek', 'P005'),
       ('benny safdie', 'P005');

-- Add Phim_The_loai (Movie_Genre) records
INSERT INTO Phim_The_loai (The_loai, Ma_phim)
VALUES ('Crime', 'P005'),
       ('Action', 'P005'),
       ('Thriller', 'P005'),
       ('Biography', 'P005');

-- Add Lich_chieu (Showtime) records
-- Film: Nhiệm Vụ: Bất Khả Thi Nghiệp Báo Phần Một (P001)
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-09', 'Special', '08:00:00', 'P001', 'PC001');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-09', 'Special', '10:00:00', 'P001', 'PC001');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-09', 'Special', '14:00:00', 'P001', 'PC003');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-09', 'Special', '18:00:00', 'P001', 'PC002');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-09', 'Special', '22:00:00', 'P001', 'PC001');

INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-10', 'Normal', '08:00:00', 'P001', 'PC001');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-10', 'Normal', '10:00:00', 'P001', 'PC001');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-10', 'Normal', '14:00:00', 'P001', 'PC003');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-10', 'Normal', '18:00:00', 'P001', 'PC002');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-10', 'Normal', '22:00:00', 'P001', 'PC001');

INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-11', 'Normal', '08:00:00', 'P001', 'PC001');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-11', 'Normal', '10:00:00', 'P001', 'PC001');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-11', 'Normal', '14:00:00', 'P001', 'PC003');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-11', 'Normal', '18:00:00', 'P001', 'PC002');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-11', 'Normal', '22:00:00', 'P001', 'PC001');

-- Film: Cô Thành Trong Gương (P002)
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-09', 'Special', '08:00:00', 'P002', 'PC005');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-09', 'Special', '11:00:00', 'P002', 'PC005');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-09', 'Special', '14:00:00', 'P002', 'PC005');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-09', 'Special', '18:00:00', 'P002', 'PC005');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-09', 'Special', '22:00:00', 'P002', 'PC005');

INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-10', 'Normal', '08:00:00', 'P002', 'PC005');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-10', 'Normal', '11:00:00', 'P002', 'PC005');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-10', 'Normal', '14:00:00', 'P002', 'PC005');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-10', 'Normal', '18:00:00', 'P002', 'PC005');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-10', 'Normal', '22:00:00', 'P002', 'PC005');

INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-11', 'Normal', '08:00:00', 'P002', 'PC005');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-11', 'Normal', '11:00:00', 'P002', 'PC005');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-11', 'Normal', '14:00:00', 'P002', 'PC005');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-11', 'Normal', '18:00:00', 'P002', 'PC005');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-11', 'Normal', '22:00:00', 'P002', 'PC005');

-- Film: INDIANA JONES & VÒNG QUAY ĐỊNH MỆNH (P003)
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-09', 'Special', '08:00:00', 'P003', 'PC002');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-09', 'Special', '11:00:00', 'P003', 'PC002');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-09', 'Special', '14:00:00', 'P003', 'PC004');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-09', 'Special', '18:00:00', 'P003', 'PC004');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-09', 'Special', '22:00:00', 'P003', 'PC004');

INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-10', 'Special', '08:00:00', 'P003', 'PC002');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-10', 'Special', '11:00:00', 'P003', 'PC002');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-10', 'Special', '14:00:00', 'P003', 'PC004');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-10', 'Special', '18:00:00', 'P003', 'PC004');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-10', 'Special', '22:00:00', 'P003', 'PC004');

INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-11', 'Special', '08:00:00', 'P003', 'PC002');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-11', 'Special', '11:00:00', 'P003', 'PC002');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-11', 'Special', '14:00:00', 'P003', 'PC004');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-11', 'Special', '18:00:00', 'P003', 'PC004');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-11', 'Special', '22:00:00', 'P003', 'PC004');

-- Film: Transformers: Quái Thú Trỗi Dậy (P004)
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-09', 'Special', '08:00:00', 'P004', 'PC003');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-09', 'Special', '11:00:00', 'P004', 'PC003');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-09', 'Special', '14:00:00', 'P004', 'PC001');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-09', 'Special', '18:00:00', 'P004', 'PC001');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-09', 'Special', '22:00:00', 'P004', 'PC002');

INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-10', 'Normal', '08:00:00', 'P004', 'PC003');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-10', 'Normal', '11:00:00', 'P004', 'PC003');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-10', 'Normal', '14:00:00', 'P004', 'PC001');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-10', 'Normal', '18:00:00', 'P004', 'PC001');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-10', 'Normal', '22:00:00', 'P004', 'PC002');

INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-11', 'Normal', '08:00:00', 'P004', 'PC003');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-11', 'Normal', '11:00:00', 'P004', 'PC003');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-11', 'Normal', '14:00:00', 'P004', 'PC001');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-11', 'Normal', '18:00:00', 'P004', 'PC001');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-11', 'Normal', '22:00:00', 'P004', 'PC002');


-- Film: Oppenheimer (P005)
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-09', 'Special', '08:00:00', 'P005', 'PC004');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-09', 'Special', '11:00:00', 'P005', 'PC004');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-09', 'Special', '14:00:00', 'P005', 'PC002');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-09', 'Special', '18:00:00', 'P005', 'PC003');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-09', 'Special', '22:00:00', 'P005', 'PC003');

INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-10', 'Normal', '08:00:00', 'P005', 'PC004');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-10', 'Normal', '11:00:00', 'P005', 'PC004');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-10', 'Normal', '14:00:00', 'P005', 'PC002');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-10', 'Normal', '18:00:00', 'P005', 'PC003');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-10', 'Normal', '22:00:00', 'P005', 'PC003');

INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-11', 'Normal', '08:00:00', 'P005', 'PC004');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-11', 'Normal', '11:00:00', 'P005', 'PC004');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-11', 'Normal', '14:00:00', 'P005', 'PC002');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-11', 'Normal', '18:00:00', 'P005', 'PC003');
INSERT INTO Lich_chieu (Ngay_chieu, Loai_ngay, Gio_chieu, Ma_phim, Ma_phong)
VALUES ('2023-07-11', 'Normal', '22:00:00', 'P005', 'PC003');

--Thêm dữ liệu vào bảng "Lich_lam_viec":
INSERT INTO Lich_lam_viec (Ma_lich_lam_viec, Ngay_lam_viec, Gio_bat_dau, Gio_ket_thuc)
VALUES ('LLV001', '2,3,4,5', '07:00:00', '14:00:00'),
('LLV002', '2,3,4,5', '14:00:00', '22:00:00'),
('LLV003', '6,7,CN', '7:00:00', '14:00:00'),
('LLV004', '6,7,CN', '14:00:00', '22:00:00'),
('LLV005', '2,3,4,5', '07:00:00', '22:00:00'),
('LLV006', '6,7,CN', '07:00:00', '22:00:00'),
('LLV007', '2,3,4,5,6,7,CN', '07:00:00', '16:00:00');

--Thêm dữ liệu vào bảng "Nhan_vien":
INSERT INTO Nhan_vien (Ma_nhan_vien, Ten_nhan_vien, Chuc_vu, So_dien_thoai, Luong, Ma_lich_lam_viec)
VALUES ('NV001', 'Ngo Đuc Khanh', 'Quan ly', '0123456789', 10000, 'LLV007'),
('NV002', 'Vu Đuc Thinh', 'Nhan vien ban ve', '0987654321', 5000, 'LLV002'),
('NV003', 'Le Chi Dung', 'Nhan viên ban ve', '0123987456', 6000, 'LLV003'),
('NV004', 'Do Dai Quang', 'Bao ve', '0123987456', 6000, 'LLV006'),
('NV005', 'Me Le Chi', 'Ban hang', '0823973256', 6000, 'LLV004'),
('NV006', 'Thong Dao Chi', 'Bao ve', '0943114821', 5000, 'LLV005');

--Thêm dữ liệu vào bảng "Khach_hang":
INSERT INTO Khach_hang (Ma_khach_hang,Ten_khach_hang,Dia_chi,So_dien_thoai,Muc_hoi_vien)
VALUES ('0000','Pham Hoang Thanh','So 325 - Quan Hai Ba Trung - Ha Noi','0954859485','0'),
('0001','Pham Thanh Giang','So 64 - Quan Hai Ba Trung - Ha Noi','0954859485','0'),
('0002','Tran Nam Giang','So 23 - Quan 3 - Ho Chi Minh','0954859485','2'),
('0003','Nguyen Thanh Phong','So 5 - Quan 9 - Thu Duc - Ho Chi Minh','0954859485','1'),
('0004','Vu Kim Ngan','Xa Hoang Giang - Huyen Thanh My - Ha Noi','0954859485','0'),
('0005','Hoang Kieu Thuy','So 85 - Quan Hoan Kiem - Ha Noi','0954859485','2'),
('0006','Mac Van Khoa','So 32 - Quan My Duc - Ha Noi','0954859485','0'),
('0007','Tran Bao Quy','Xom 8 - Hoang Thanh - Nghe Tinh','0954859485','1');

INSERT INTO Khach_hang (Ma_khach_hang, Ten_khach_hang, Dia_chi, So_dien_thoai, Muc_hoi_vien)
VALUES 
  ('0008', 'Nguyen Van A', '123 Nguyen Du, Quan 1, TP. Ho Chi Minh', '0901234567', 1),
  ('0009', 'Tran Thi B', '456 Le Loi, Quan 2, TP. Ho Chi Minh', '0912345678', 2),
  ('0010', 'Le Van C', '789 Nguyen Trai, Quan 3, TP. Ho Chi Minh', '0923456789', 1),
  ('0011', 'Pham Thi D', '321 Le Duan, Quan 4, TP. Ho Chi Minh', '0934567890', 0),
  ('0012', 'Vo Van E', '567 Tran Hung Dao, Quan 5, TP. Ho Chi Minh', '0945678901', 2),
  ('0013', 'Truong Van F', '789 Le Van Sy, Quan 6, TP. Ho Chi Minh', '0956789012', 1),
  ('0014', 'Hoang Thi G', '234 Pham Ngu Lao, Quan 1, TP. Ho Chi Minh', '0967890123', 2),
  ('0015', 'Bui Van H', '567 Nguyen Thi Minh Khai, Quan 3, TP. Ho Chi Minh', '0978901234', 0),
  ('0016', 'Ngo Thi I', '890 Tran Quoc Thao, Quan 10, TP. Ho Chi Minh', '0989012345', 1),
  ('0017', 'Vu Van J', '123 Le Van Viet, Quan 7, TP. Ho Chi Minh', '0990123456', 2),
  ('0018', 'Nguyen Thi K', '456 Phan Xich Long, Quan Phu Nhuan, TP. Ho Chi Minh', '0912345678', 0),
  ('0019', 'Tran Van L', '789 Le Loi, Quan 5, TP. Ho Chi Minh', '0923456789', 1),
  ('0020', 'Le Thi M', '321 Tran Hung Dao, Quan 4, TP. Ho Chi Minh', '0934567890', 2),
  ('0021', 'Pham Van N', '567 Nguyen Dinh Chieu, Quan 3, TP. Ho Chi Minh', '0945678901', 0),
  ('0022', 'Vo Thi O', '890 Le Thanh Ton, Quan 1, TP. Ho Chi Minh', '0956789012', 1),
  ('0023', 'Truong Van P', '234 Cao Thang, Quan 10, TP. Ho Chi Minh', '0967890123', 2),
  ('0024', 'Hoang Van Q', '567 Ly Thai To, Quan 11, TP. Ho Chi Minh', '0978901234', 0),
  ('0025', 'Bui Thi R', '890 Nguyen Binh Khiem, Quan Phu Nhuan, TP. Ho Chi Minh', '0989012345', 1),
  ('0026', 'Ngo Van S', '123 Tran Quoc Toan, Quan 7, TP. Ho Chi Minh', '0990123456', 2),
  ('0027', 'Vu Thi T', '456 Pham Hong Thai, Quan 5, TP. Ho Chi Minh', '0912345678', 0),
  ('0028', 'Nguyen Van U', '789 Nguyen Hue, Quan 1, TP. Ho Chi Minh', '0923456789', 1);


--Thêm dữ liệu vào bảng "Ve":
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC1', 'PC001_A1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC1', 'PC001_A2', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC1', 'PC001_A3', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC1', 'PC001_A4', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC1', 'PC001_A5', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC1', 'PC001_A6', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC1', 'PC001_A7', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC1', 'PC001_A8', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC1', 'PC001_A9', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC1', 'PC001_A10', 0);

INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC1', 'PC001_B1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC1', 'PC001_B2', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC1', 'PC001_B3', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC1', 'PC001_B4', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC1', 'PC001_B5', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC1', 'PC001_B6', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (1, 'LC1', 'PC001_B7', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC1', 'PC001_B8', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC1', 'PC001_B9', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC1', 'PC001_B10', 0);

INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC1', 'PC001_C1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC1', 'PC001_C2', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC1', 'PC001_C3', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC1', 'PC001_C4', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC1', 'PC001_C5', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC1', 'PC001_C6', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (1, 'LC1', 'PC001_C7', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC1', 'PC001_C8', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC1', 'PC001_C9', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC1', 'PC001_C10', 0);

INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC2', 'PC001_A1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC2', 'PC001_A2', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC2', 'PC001_A3', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC2', 'PC001_A4', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC2', 'PC001_A5', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC2', 'PC001_A6', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC2', 'PC001_A7', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC2', 'PC001_A8', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC2', 'PC001_A9', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC2', 'PC001_A10', 0);

INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC2', 'PC001_B1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC2', 'PC001_B2', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC2', 'PC001_B3', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC2', 'PC001_B4', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC2', 'PC001_B5', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC2', 'PC001_B6', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (1, 'LC2', 'PC001_B7', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC2', 'PC001_B8', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC2', 'PC001_B9', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC2', 'PC001_B10', 0);

INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC2', 'PC001_C1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC2', 'PC001_C2', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC2', 'PC001_C3', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC2', 'PC001_C4', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC2', 'PC001_C5', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC2', 'PC001_C6', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC2', 'PC001_C7', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC2', 'PC001_C8', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC2', 'PC001_C9', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC2', 'PC001_C10', 0);

INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC19', 'PC001_A1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC19', 'PC001_A2', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC19', 'PC001_A3', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC19', 'PC001_A4', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC19', 'PC001_A5', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC19', 'PC001_A6', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC19', 'PC001_A7', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC19', 'PC001_A8', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC19', 'PC001_A9', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC19', 'PC001_A10', 0);

INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC19', 'PC001_B1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC19', 'PC001_B2', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC19', 'PC001_B3', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC19', 'PC001_B4', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC19', 'PC001_B5', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC19', 'PC001_B6', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (1, 'LC19', 'PC001_B7', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC19', 'PC001_B8', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC19', 'PC001_B9', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC19', 'PC001_B10', 0);

INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC19', 'PC001_C1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC19', 'PC001_C2', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC19', 'PC001_C3', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC19', 'PC001_C4', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC19', 'PC001_C5', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC19', 'PC001_C6', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC19', 'PC001_C7', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC19', 'PC001_C8', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC19', 'PC001_C9', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC19', 'PC001_C10', 0);

INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC20', 'PC001_A1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC20', 'PC001_A2', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC20', 'PC001_A3', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC20', 'PC001_A4', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC20', 'PC001_A5', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC20', 'PC001_A6', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC20', 'PC001_A7', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC20', 'PC001_A8', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC20', 'PC001_A9', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC20', 'PC001_A10', 0);

INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC20', 'PC001_B1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC20', 'PC001_B2', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC20', 'PC001_B3', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC20', 'PC001_B4', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC20', 'PC001_B5', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC20', 'PC001_B6', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (1, 'LC20', 'PC001_B7', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC20', 'PC001_B8', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC20', 'PC001_B9', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC20', 'PC001_B10', 0);

INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC20', 'PC001_C1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC20', 'PC001_C2', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC20', 'PC001_C3', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC20', 'PC001_C4', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC20', 'PC001_C5', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC20', 'PC001_C6', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC20', 'PC001_C7', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC20', 'PC001_C8', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC20', 'PC001_C9', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC20', 'PC001_C10', 0);

INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC33', 'PC001_C1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC33', 'PC001_C2', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC33', 'PC001_C3', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC33', 'PC001_C4', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC33', 'PC001_C5', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC33', 'PC001_C6', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC33', 'PC001_C7', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC33', 'PC001_C8', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC33', 'PC001_C9', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC33', 'PC001_C10', 0);

INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC35', 'PC001_A1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (1, 'LC35', 'PC001_A2', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC35', 'PC001_A3', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC35', 'PC001_A4', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC35', 'PC001_A5', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC35', 'PC001_A6', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC35', 'PC001_A7', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC35', 'PC001_A8', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC35', 'PC001_A9', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC35', 'PC001_A10', 0);

INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC35', 'PC001_B1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC35', 'PC001_B2', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC35', 'PC001_B3', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC35', 'PC001_B4', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC35', 'PC001_B5', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC35', 'PC001_B6', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC35', 'PC001_B7', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC35', 'PC001_B8', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC35', 'PC001_B9', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC35', 'PC001_B10', 0);

INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC35', 'PC001_C1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC35', 'PC001_C2', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC35', 'PC001_C3', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC35', 'PC001_C4', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC35', 'PC001_C5', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC35', 'PC001_C6', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC35', 'PC001_C7', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC35', 'PC001_C8', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC35', 'PC001_C9', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC35', 'PC001_C10', 0);

INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC42', 'PC001_A1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC42', 'PC001_A2', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC42', 'PC001_A3', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC42', 'PC001_A4', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC42', 'PC001_A5', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC42', 'PC001_A6', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC42', 'PC001_A7', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC42', 'PC001_A8', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC42', 'PC001_A9', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC42', 'PC001_A10', 0);

INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC42', 'PC001_B1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC42', 'PC001_B2', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC42', 'PC001_B3', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC42', 'PC001_B4', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC42', 'PC001_B5', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC42', 'PC001_B6', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (1, 'LC42', 'PC001_B7', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC42', 'PC001_B8', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC42', 'PC001_B9', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC42', 'PC001_B10', 0);

INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC42', 'PC001_C1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC42', 'PC001_C2', 2);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC42', 'PC001_C3', 2);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC42', 'PC001_C4', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC42', 'PC001_C5', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC42', 'PC001_C6', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC42', 'PC001_C7', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC42', 'PC001_C8', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC42', 'PC001_C9', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC42', 'PC001_C10', 0);

INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC48', 'PC001_A1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC48', 'PC001_A2', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC48', 'PC001_A3', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC48', 'PC001_A4', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC48', 'PC001_A5', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC48', 'PC001_A6', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC48', 'PC001_A7', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC48', 'PC001_A8', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (1, 'LC48', 'PC001_A9', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC48', 'PC001_A10', 0);

INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC48', 'PC001_B1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC48', 'PC001_B2', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC48', 'PC001_B3', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC48', 'PC001_B4', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC48', 'PC001_B5', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC48', 'PC001_B6', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (1, 'LC48', 'PC001_B7', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC48', 'PC001_B8', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC48', 'PC001_B9', 2);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC48', 'PC001_B10', 0);

INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC48', 'PC001_C1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC48', 'PC001_C2', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC48', 'PC001_C3', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC48', 'PC001_C4', 2);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC48', 'PC001_C5', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC48', 'PC001_C6', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC48', 'PC001_C7', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC48', 'PC001_C8', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (1, 'LC48', 'PC001_C9', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC48', 'PC001_C10', 0);

INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC65', 'PC001_A1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC65', 'PC001_A2', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC65', 'PC001_A3', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC65', 'PC001_A4', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC65', 'PC001_A5', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC65', 'PC001_A6', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC65', 'PC001_A7', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC65', 'PC001_A8', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC65', 'PC001_A9', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC65', 'PC001_A10', 0);

INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC65', 'PC001_B1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC65', 'PC001_B2', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC65', 'PC001_B3', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC65', 'PC001_B4', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC65', 'PC001_B5', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC65', 'PC001_B6', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (1, 'LC65', 'PC001_B7', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC65', 'PC001_B8', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC65', 'PC001_B9', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC65', 'PC001_B10', 1);

INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC65', 'PC001_C1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (2, 'LC65', 'PC001_C2', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC65', 'PC001_C3', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC65', 'PC001_C4', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC65', 'PC001_C5', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC65', 'PC001_C6', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC65', 'PC001_C7', 2);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC65', 'PC001_C8', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC65', 'PC001_C9', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC65', 'PC001_C10', 0);

INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC70', 'PC001_A1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC70', 'PC001_A2', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC70', 'PC001_A3', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC70', 'PC001_A4', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC70', 'PC001_A5', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC70', 'PC001_A6', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC70', 'PC001_A7', 1);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC70', 'PC001_A8', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC70', 'PC001_A9', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC70', 'PC001_A10', 0);

INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC70', 'PC001_B1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC70', 'PC001_B2', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC70', 'PC001_B3', 2);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC70', 'PC001_B4', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC70', 'PC001_B5', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC70', 'PC001_B6', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC70', 'PC001_B7', 2);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC70', 'PC001_B8', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC70', 'PC001_B9', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC70', 'PC001_B10', 0);

INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC70', 'PC001_C1', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC70', 'PC001_C2', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (3, 'LC70', 'PC001_C3', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC70', 'PC001_C4', 2);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC70', 'PC001_C5', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC70', 'PC001_C6', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC70', 'PC001_C7', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC70', 'PC001_C8', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (4, 'LC70', 'PC001_C9', 0);
INSERT INTO Ve (Danh_gia, Ma_lich_chieu, Ma_ghe, Muc_hoi_vien)
VALUES (5, 'LC70', 'PC001_C10', 1);