create database koperasi;
use koperasi;

create table login (
id_user int auto_increment primary key,
username varchar(50) not null unique,
password varchar(255) not null,
role enum('petugas','anggota') not null,
id_petugas int,
id_anggota int,
foreign key (id_petugas) references petugas (id_petugas),
foreign key (id_anggota) references anggota (id_anggota)
);

create table petugas (
id_petugas int auto_increment primary key,
nama varchar(100) not null,
jabatan varchar(50),
no_telepon varchar(20),
username varchar(50) unique,
password varchar(255)
);

create table anggota (
id_anggota int auto_increment primary key,
nama varchar(100) not null,
no_telepon varchar(20),
alamat text,
tanggal_daftar date not null
);

create table jenis_simpanan (
id_jenis_simpanan int auto_increment primary key,
nama_jenis varchar(50) not null,
deskripsi text
);

create table simpanan (
id_simpanan int auto_increment primary key,
id_anggota int not null,
id_jenis_simpanan int not null,
id_petugas int not null,
tanggal date not null,
jumlah decimal(15,2) not null,
foreign key (id_anggota) references anggota (id_anggota),
foreign key (id_jenis_simpanan) references jenis_simpanan (id_jenis_simpanan),
foreign key (id_petugas) references petugas (id_petugas)
);

create table jenis_transaksi (
id_jenis_transaksi int auto_increment primary key,
nama_transaksi varchar(50) not null
);

create table transaksi (
id_transaksi int auto_increment primary key,
id_anggota int not null,
id_petugas int not null,
id_jenis_transaksi int not null,
tanggal date not null,
jumlah decimal(15,2) not null,
keterangan text,
foreign key (id_anggota) references anggota (id_anggota),
foreign key (id_petugas) references petugas (id_petugas),
foreign key (id_jenis_transaksi) references jenis_transaksi (id_jenis_transaksi)
);

create table pinjaman (
id_pinjaman int auto_increment primary key,
id_anggota int not null,
id_petugas int not null,
tanggal date not null,
jumlah decimal(15,2) not null,
bunga decimal(15,2) not null,
lama_angsuran int not null,
status enum('lunas','belum lunas') not null,
foreign key (id_anggota) references anggota (id_anggota),
foreign key (id_petugas) references petugas (id_petugas)
);

create table angsuran (
id_angsuran int auto_increment primary key,
id_pinjaman int not null,
id_petugas int not null,
id_transaksi int not null,
tanggal_angsuran date not null,
jumlah decimal(15,2) not null,
foreign key (id_pinjaman) references pinjaman (id_pinjaman),
foreign key (id_petugas) references petugas (id_petugas),
foreign key (id_transaksi) references transaksi (id_transaksi)
);

create table notifikasi (
id_notifikasi int auto_increment primary key,
id_anggota int not null,
judul varchar(100),
pesan text,
tanggal date,
foreign key (id_anggota) references anggota (id_anggota)
);

insert into petugas (nama, jabatan, no_telepon, username, password) values
('Dian Prasetyo', 'Manajer', '081234567890', 'dian', 'pass123'),
('Rina Marlina', 'Staff Simpanan', '081298765432', 'rina', 'pass456'),
('Budi Santoso', 'Kasir', '082112345678', 'budi', 'pass789'),
('Eka Widya', 'Admin', '083112233445', 'eka', 'pass321'),
('Farhan Yusuf', 'Staff Pinjaman', '084433221100', 'farhan', 'pass654');

insert into anggota (nama, no_telepon, alamat, tanggal_daftar) values
('Ahmad Fauzi', '082233445566', 'Jl. Merdeka No. 10', '2025-01-10'),
('Siti Aminah', '081245678900', 'Jl. Kenanga No. 15', '2025-02-15'),
('Rudi Hartono', '085566778899', 'Jl. Melati No. 3', '2025-03-05'),
('Lilis Suryani', '086677889900', 'Jl. Anggrek No. 8', '2025-04-01'),
('Teguh Wibowo', '087788990011', 'Jl. Mawar No. 12', '2025-04-10'),
('Bayu Pramana', '089912345678', 'Jl. Cendana No. 5', '2025-05-05');  -- TANPA simpanan

insert into login (username, password, role, id_petugas, id_anggota) values
('dian', 'pass123', 'petugas', 1, null),
('rina', 'pass456', 'petugas', 2, null),
('ahmad', '1234', 'anggota', null, 1),
('siti', '5678', 'anggota', null, 2),
('rudi', 'abcd', 'anggota', null, 3);

insert into jenis_simpanan (nama_jenis, deskripsi) values
('Simpanan Pokok', 'Simpanan wajib setiap anggota saat mendaftar'),
('Simpanan Wajib', 'Simpanan bulanan wajib anggota'),
('Simpanan Sukarela', 'Simpanan bebas sesuai kemampuan anggota'),
('Simpanan Pendidikan', 'Simpanan khusus untuk biaya pendidikan'),
('Simpanan Hari Raya', 'Disimpan untuk keperluan hari besar keagamaan');

insert into simpanan (id_anggota, id_jenis_simpanan, id_petugas, tanggal, jumlah) values
(1, 1, 2, '2025-03-01', 100000.00),
(2, 2, 3, '2025-03-10', 150000.00),
(3, 3, 2, '2025-03-15', 50000.00),
(4, 1, 1, '2025-04-01', 100000.00),
(5, 2, 5, '2025-04-05', 150000.00);

insert into jenis_transaksi (nama_transaksi) values
('Pembayaran Angsuran'),
('Penarikan Simpanan'),
('Pembayaran Pinjaman'),
('Setoran Simpanan'),
('Pembayaran Denda');

insert into transaksi (id_anggota, id_petugas, id_jenis_transaksi, tanggal, jumlah, keterangan) values
(1, 2, 1, '2025-04-10', 50000.00, 'Angsuran ke-1'),
(2, 3, 2, '2025-04-15', 30000.00, 'Penarikan sukarela'),
(3, 4, 4, '2025-04-20', 70000.00, 'Setoran bulanan'),
(4, 1, 3, '2025-04-25', 100000.00, 'Pembayaran pertama'),
(5, 5, 5, '2025-05-01', 10000.00, 'Denda keterlambatan');

insert into pinjaman (id_anggota, id_petugas, tanggal, jumlah, bunga, lama_angsuran, status) values
(1, 1, '2025-03-15', 1000000.00, 100000.00, 10, 'belum lunas'),
(2, 2, '2025-03-20', 2000000.00, 200000.00, 12, 'belum lunas'),
(3, 3, '2025-04-01', 1500000.00, 150000.00, 6, 'lunas'),
(4, 4, '2025-04-05', 1200000.00, 120000.00, 8, 'belum lunas'),
(5, 5, '2025-04-10', 1800000.00, 180000.00, 9, 'belum lunas');

insert into angsuran (id_pinjaman, id_petugas, id_transaksi, tanggal_angsuran, jumlah) values
(1, 2, 1, '2025-04-10', 50000.00),
(2, 3, 2, '2025-04-15', 100000.00),
(3, 4, 3, '2025-04-20', 150000.00),
(4, 1, 4, '2025-04-25', 120000.00),
(5, 5, 5, '2025-05-01', 180000.00);

insert into notifikasi (id_anggota, judul, pesan, tanggal) values
(1, 'Jatuh Tempo Angsuran', 'Angsuran ke-2 jatuh tempo 10 Mei', '2025-05-01'),
(2, 'Saldo Simpanan Bertambah', 'Penambahan simpanan Rp150.000', '2025-04-10'),
(3, 'Pinjaman Disetujui', 'Pinjaman Anda telah disetujui', '2025-04-01'),
(4, 'Denda Keterlambatan', 'Anda terkena denda Rp10.000', '2025-05-01'),
(5, 'Pembayaran Lunas', 'Pinjaman Anda telah lunas', '2025-05-02');

select 
    a.id_anggota,
    a.nama as nama_anggota,
    s.id_simpanan,
    s.jumlah
from anggota a
left join simpanan s on a.id_anggota = s.id_anggota;

select 
    a.id_anggota,
    a.nama as nama_anggota,
    s.id_simpanan,
    s.jumlah
from anggota a
right join simpanan s on a.id_anggota = s.id_anggota;

select 
    a.id_anggota,
    a.nama as nama_anggota,
    s.id_simpanan,
    s.jumlah,
    s.tanggal
from anggota a
inner join simpanan s on a.id_anggota = s.id_anggota;

select 
    a.id_anggota,
    a.nama as nama_anggota,
    s.id_simpanan,
    s.jumlah,
    s.tanggal
from anggota a
left join simpanan s on a.id_anggota = s.id_anggota
union
select 
    a.id_anggota,
    a.nama as nama_anggota,
    s.id_simpanan,
    s.jumlah,
    s.tanggal
from anggota a
right join simpanan s on a.id_anggota = s.id_anggota;

-- Alias dan Operator, Function, Grouping, Sorting
-- Alias --
SELECT 
    a.nama AS nama_anggota, 
    s.jumlah AS jumlah_simpanan, 
    js.nama_jenis AS jenis_simpanan
FROM simpanan s
JOIN anggota a ON s.id_anggota = a.id_anggota
JOIN jenis_simpanan js ON s.id_jenis_simpanan = js.id_jenis_simpanan;

-- Operator
SELECT 
    a.nama AS nama_anggota,
    p.jumlah + p.bunga AS total_pinjaman,
    p.jumlah - p.bunga AS pokok_pinjaman
FROM pinjaman p
JOIN anggota a ON p.id_anggota = a.id_anggota
WHERE p.status = 'belum lunas';

-- Function
SELECT 
    UPPER(nama) AS nama_anggota_besar,
    LENGTH(alamat) AS panjang_alamat
FROM anggota;

-- Grouping
SELECT 
    id_anggota,
    SUM(jumlah) AS total_simpanan,
    COUNT(*) AS jumlah_transaksi
FROM simpanan
GROUP BY id_anggota;

-- Sorting
SELECT 
    a.nama AS nama_anggota,
    s.jumlah AS jumlah_simpanan
FROM simpanan s
JOIN anggota a ON s.id_anggota = a.id_anggota
ORDER BY s.jumlah DESC;

-- nested query 
SELECT 
    a.id_anggota,
    a.nama AS nama_anggota,
    SUM(s.jumlah) AS total_simpanan
FROM anggota a
JOIN simpanan s ON a.id_anggota = s.id_anggota
GROUP BY a.id_anggota, a.nama
HAVING SUM(s.jumlah) > (
    SELECT AVG(total)
    FROM (
        SELECT id_anggota, SUM(jumlah) AS total
        FROM simpanan
        GROUP BY id_anggota
    ) AS rata_simpanan
);

-- Trigger 
DELIMITER $$

CREATE TRIGGER after_insert_simpanan
AFTER INSERT ON simpanan
FOR EACH ROW
BEGIN
    DECLARE nama_jenis VARCHAR(50);
    
    -- Ambil nama jenis simpanan
    SELECT nama_jenis 
    INTO nama_jenis
    FROM jenis_simpanan
    WHERE id_jenis_simpanan = NEW.id_jenis_simpanan;

    -- Masukkan notifikasi
    INSERT INTO notifikasi (id_anggota, judul, pesan, tanggal)
    VALUES (
        NEW.id_anggota,
        'Simpanan Baru Ditambahkan',
        CONCAT('Anda menambahkan simpanan jenis ', nama_jenis, ' sebesar Rp', NEW.jumlah),
        CURDATE()
    );
END$$

DELIMITER ;

SELECT * FROM notifikasi ORDER BY id_notifikasi DESC;

-- mengecek trigger Misalnya kita menambahkan simpanan baru
INSERT INTO simpanan (id_anggota, id_jenis_simpanan, id_petugas, tanggal, jumlah)
VALUES (6, 3, 2, CURDATE(), 75000.00);
SELECT * FROM notifikasi WHERE id_anggota = 6 ORDER BY id_notifikasi DESC;

-- VIEW TRANSAKSI LENGKAP : Menampilkan seluruh transaksi beserta nama petugas dan anggota. --
create view v_transaksi_lengkap as
select 
    t.id_transaksi,
    a.nama as nama_anggota,
    p.nama as nama_petugas,
    j.nama_transaksi,
    t.tanggal,
    t.jumlah,
    t.keterangan
from transaksi t
join anggota a on t.id_anggota = a.id_anggota
join petugas p on t.id_petugas = p.id_petugas
join jenis_transaksi j on t.id_jenis_transaksi = j.id_jenis_transaksi;


select * FROM v_transaksi_lengkap;

-- VIEW ANGSURAN LENGKAP : Menampilkan detail angsuran beserta data petugas dan pinjaman.

create view v_angsuran_lengkap as
select 
    ag.id_angsuran,
    a.nama as nama_anggota,
    p.nama as nama_petugas,
    ag.tanggal_angsuran,
    ag.jumlah,
    pin.jumlah as total_pinjaman
from angsuran ag
join pinjaman pin on ag.id_pinjaman = pin.id_pinjaman
join anggota a on pin.id_anggota = a.id_anggota
join petugas p on ag.id_petugas = p.id_petugas;

select * FROM v_angsuran_lengkap;

-- VIEW NOTIFIKASI ANGGOTA : Menampilkan notifikasi berdasarkan anggota.--

create view v_notifikasi_anggota as
select 
    n.id_notifikasi,
    a.nama,
    n.judul,
    n.pesan,
    n.tanggal
from notifikasi n
join anggota a on n.id_anggota = a.id_anggota;

select * FROM v_notifikasi_anggota;

-- SP TAMBAH SIMPANAN : Untuk menambah simpanan baru.--
delimiter //
create procedure sp_tambah_simpanan(
    in p_id_anggota int,
    in p_id_jenis_simpanan int,
    in p_id_petugas int,
    in p_tanggal date,
    in p_jumlah decimal(15,2)
)
begin
    insert into simpanan(id_anggota, id_jenis_simpanan, id_petugas, tanggal, jumlah)
    values(p_id_anggota, p_id_jenis_simpanan, p_id_petugas, p_tanggal, p_jumlah);
end //
delimiter ;
call sp_tambah_simpanan(1, 2, 3, '2025-05-07', 250000.00);

-- SP TAMBAH TRANSAKSI : Untuk mencatat transaksi baru.--
delimiter //
create procedure sp_tambah_transaksi(
    in p_id_anggota int,
    in p_id_petugas int,
    in p_id_jenis_transaksi int,
    in p_tanggal date,
    in p_jumlah decimal(15,2),
    in p_keterangan text
)
begin
    insert into transaksi(id_anggota, id_petugas, id_jenis_transaksi, tanggal, jumlah, keterangan)
    values(p_id_anggota, p_id_petugas, p_id_jenis_transaksi, p_tanggal, p_jumlah, p_keterangan);
end //
delimiter ;
call sp_tambah_transaksi(1, 2, 4, '2025-05-07', 100000.00, 'Setoran tambahan');


-- SP LAPORAN SIMPAN PER ANGGOTA : Menampilkan total simpanan per anggota.--
delimiter //
create procedure sp_laporan_simpanan_per_anggota()
begin
    select 
        a.id_anggota,
        a.nama,
        ifnull(sum(s.jumlah), 0) as total_simpanan
    from anggota a
    left join simpanan s on a.id_anggota = s.id_anggota
    group by a.id_anggota;
end //
delimiter ;
call sp_laporan_simpanan_per_anggota();


-- SP LAPORAN PINJAMAN LUNAS : Menampilkan data pinjaman yang sudah lunas.--
delimiter //
create procedure sp_laporan_pinjaman_lunas()
begin
    select 
        p.id_pinjaman,
        a.nama,
        p.jumlah,
        p.bunga,
        p.lama_angsuran,
        p.status
    from pinjaman p
    join anggota a on p.id_anggota = a.id_anggota
    where p.status = 'lunas';
end //
delimiter ;
call sp_laporan_pinjaman_lunas();

-- SP KIRIM NOTIFIKASI : Menambah notifikasi baru.--
delimiter //
create procedure sp_kirim_notifikasi(
    in p_id_anggota int,
    in p_judul varchar(100),
    in p_pesan text,
    in p_tanggal date
)
begin
    insert into notifikasi(id_anggota, judul, pesan, tanggal)
    values(p_id_anggota, p_judul, p_pesan, p_tanggal);
end //
delimiter ;
call sp_kirim_notifikasi(1, 'Simpanan Baru', 'Anda telah menambah simpanan sebesar Rp250.000', '2025-05-07');

-- SP DETAIL ANGSURAN BY PINJAMAN : Menampilkan angsuran berdasarkan ID pinjaman.--
delimiter //
create procedure sp_detail_angsuran_by_pinjaman(in p_id_pinjaman int)
begin
    select 
        ag.id_angsuran,
        ag.tanggal_angsuran,
        ag.jumlah,
        p.nama as nama_petugas
    from angsuran ag
    join petugas p on ag.id_petugas = p.id_petugas
    where ag.id_pinjaman = p_id_pinjaman;
end //
delimiter ;
call sp_detail_angsuran_by_pinjaman(1);

-- SP DATA LOGIN user : Melihat data login berdasarkan username.--
delimiter //
create procedure sp_data_login_user(in p_username varchar(50))
begin
    select * from login where username = p_username;
end //
delimiter ;
call sp_data_login_user('ahmad');

-- DCL--

-- Buat user anggota/petugas (hak terbatas)
CREATE USER 'app_user'@'localhost' IDENTIFIED BY 'user123_';

GRANT SELECT, INSERT, UPDATE ON koperasi.login TO 'app_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON koperasi.simpanan TO 'app_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON koperasi.transaksi TO 'app_user'@'localhost';
GRANT SELECT, INSERT ON koperasi.pinjaman TO 'app_user'@'localhost';
GRANT SELECT ON koperasi.notifikasi TO 'app_user'@'localhost';

-- Buat user admin (akses penuh)
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'admin123_';
GRANT ALL PRIVILEGES ON koperasi.* TO 'admin_user'@'localhost' WITH GRANT OPTION;

-- Terapkan perubahan hak akses
FLUSH PRIVILEGES;

SELECT user, host FROM mysql.user;






















