ânCREATE DATABASE QUANLYGIANGDAY
ON
(
	NAME = 'QuanLyGiangDay',
	FILENAME = 'D:\Learn\SQL\BTL_QuanLyDaoTao\QLGD_csharf.mdf',
	SIZE = 10
)


USE QUANLYGIANGDAY

-- Tạo bảng
CREATE TABLE tblTaiKhoan
(
	iMaTK int not null primary key identity,
	sUsername varchar(50) not null unique,
	sPassword varchar(50) not null,
	iPhanQuyen int null default 0
);

CREATE TABLE tblMonHoc
(
	sMaMon varchar(50) not null primary key,
	sMaKhoa varchar(50) not null references tblKhoa(sMaKhoa),
	sTenMon NVARCHAR(50),
	iSoTC int
);


CREATE TABLE tblKhoa
(
	sMaKhoa varchar(50) PRIMARY KEY,
	sTenKhoa NVARCHAR(50),
	sDiaChi nvarchar(50)
);


create table tblGiangVien
(
	sMaGV varchar(50) primary key,
	sTenGV nvarchar(50),
	sGioiTinh nvarchar(10),
	dNgaySinh datetime,
	sMaKhoa varchar(50) references tblKhoa(sMaKhoa)
);

CREATE TABLE tblLopHC
(
	sMaLop varchar(50) PRIMARY KEY,
	sTenLop VARCHAR(50) UNIQUE,
	sMaKhoa varchar(50) REFERENCES tblKhoa(sMaKhoa),
	sMaGV varchar(50) references tblGiangVien(sMaGV)
);


CREATE TABLE tblSinhVien
(
	sMaSV varchar(50) PRIMARY KEY,
	sTenSV NVARCHAR(50),
	dNgaySinh DATETIME,
	sDiaChi NVARCHAR(50),
	sGioiTinh NVARCHAR(10),
	sLopHC varchar(50) references tblLopHC(sMaLop),
	sSDT varchar(20)
)

create table tblHoc
(
	sMaGV varchar(50) not null,
	sMaMon varchar(50) not null,
	sMaSV varchar(50) not null,
	sMaDonViHocVu varchar(50) not null,
	fDiemCC float,
	fDiemGK float,
	fDiemThi float,
	fDiemKTHP float default 0,
	constraint PK_GIANGVIEN_MONHOC primary key(sMaGV, sMaMon, sMaSV, sMaDonViHocVu),
	constraint FK_giangvien foreign key(sMaGV) references tblGiangVien(sMaGV),
	constraint FK_Mon foreign key(sMaMon) references tblMonHoc(sMaMon),
	constraint FK_SV foreign key(sMaSV) references tblSinhVien(sMaSV),
	
	constraint FK_Hocvu foreign key(sMaDonViHocVu) references tblDonViHocVu(sMaDonViHocVu)
);


create table tblDonViHocVu
(
	sMaDonViHocVu varchar(50) primary key,
	iNamHoc int,
	iKyHoc int
)

-- Thêm ràng buộc
-- sinh viên vào học phải đủ 18 tuổi
alter table tblSinhVien
add constraint CK_SinhVien_tuoi check(datediff(day, dNgaySinh, getDate())/365 >= 18)
-- Giới tính chỉ nhận là Nam or Nữ
alter table tblSinhVien
add constraint CK_SinhVien_gioitinh check(sGioiTinh = N'Nam' or sGioiTinh = N'Nữ')

alter table tblGiangVien
add constraint CK_GiangVien_gioitinh check(sGioiTinh = N'Nam' or sGioiTinh = N'Nữ')

-- Điểm chỉ nhận giá trị >= 0 and <= 10
alter table tblHoc
add constraint CK_Hoc_DiemCC check(fDiemCC between 0 and 10),
constraint CK_Hoc_DiemGK check(fDiemGK between 0 and 10),
constraint CK_Hoc_DiemThi check(fDiemThi between 0 and 10)
-- Thêm dữ liệu

-- Thêm dữ liệu tài khoản
INSERT INTO tblTaiKhoan (sUsername, sPassword) 
VALUES('admin', '1')

-- Thêm dữ liệu bảng môn học
insert into tblMonHoc
(
	sMaMon,
	sMaKhoa,
	sTenMon,
	iSoTC
)
VALUES
(
	'm1',
	'k1',
	N'Cơ sở dữ liệu',
	3
),
(
	'm2',
	'k1',
	N'Cơ sở lập trình',
	3
),
(
	'm3',
	'k1',
	N'Cơ sở dữ liệu',
	3
),
(
	'm4',
	'k1',
	N'Lập trình hướng đối tượng',
	4
),
(
	'm5',
	'k1',
	N'HQL CSDL',
	4
),
(
	'm6',
	'k1',
	N'Xác suất thống kê',
	3
),
(
	'm7',
	'k2',
	N'Xác suất thống kê',
	3
),
(
	'm8',
	'k3',
	N'Xác suất thống kê',
	3
),
(
	'm9',
	'k4',
	N'Xác suất thống kê',
	3
),
(
	'm10',
	'k5',
	N'Xác suất thống kê',
	3
),
(
	'm11',
	'k1',
	N'Lập trình hướng sự kiện',
	4
),
(
	'm12',
	'k1',
	N'English basic',
	3
),
(
	'm13',
	'k2',
	N'English basic',
	3
),
(
	'm14',
	'k3',
	N'English basic',
	3
),
(
	'm15',
	'k4',
	N'English basic',
	3
),
(
	'm16',
	'k5',
	N'English basic',
	3
),
(
	'm17',
	'k6',
	N'English basic',
	3
),
(
	'm18',
	'k2',
	N'English basic 2',
	3
),
(
	'm19',
	'k1',
	N'English basic 2',
	3
),
(
	'm20',
	'k3',
	N'English basic 2',
	3
),
(
	'm21',
	'k4',
	N'English basic 2',
	3
),
(
	'm22',
	'k5',
	N'English basic 2',
	3
),
(
	'm23',
	'k6',
	N'English nâng cao',
	4
);

-- thêm dữ liệu bảng khoa
insert into tblKhoa
(
	sMaKhoa,
	sTenKhoa,
	sDiaChi
)
values
(
	'k1',
	N'CNTT',
	N'Hoàng Mai - Hà Nội'
),
(
	'k2',
	N'Kinh Tế',
	N'Thanh Xuân - Hà Nội'
),
(
	'k3',
	N'Điện tử thông tin',
	N'Vĩnh Hưng - Hà Nội'
),
(
	'k4',
	N'Tiếng Trung',
	N'Vĩnh Hưng - Hà Nội'
),
(
	'k5',
	N'Thiết Kế',
	N'Hoàng Mai - Hà Nội'
),
(
	'k6',
	N'Ngoại Ngữ',
	N'Đống Đa - Hà Nội'
)

--Thêm dữ liệu giảng viên
insert into tblGiangVien
(
	sMaGV,
	sTenGV,
	sGioiTinh,
	dNgaySinh,
	sMaKhoa
)
VALUES
(
	'gv1',
	N'Nguyễn Thị Tâm',
	N'Nữ',
	'1987-5-4',
	'k1'
),
(
	'gv2',
	N'Trịnh Thị Xuân',
	N'Nữ',
	'1977-5-4',
	'k1'
),
(
	'gv3',
	N'Mai Thúy Hà',
	N'Nữ',
	'1967-5-4',
	'k1'
),
(
	'gv4',
	N'Nguyễn Thu Trang',
	N'Nữ',
	'1997-5-4',
	'k1'
),
(
	'gv5',
	N'Trần Đức Sáng',
	N'Nam',
	'1967-5-4',
	'k1'
),
(
	'gv6',
	N'Nguyễn Ngân Trâm',
	N'Nữ',
	'1987-5-9',
	'k2'
),
(
	'gv7',
	N'Hà Vũ Tuấn',
	N'Nam',
	'1977-9-4',
	'k2'
),
(
	'gv8',
	N'Nguyễn Phúc Đức',
	N'Nam',
	'1974-8-2',
	'k2'
),
(
	'gv9',
	N'Nguyễn Hà Bảo Trang',
	N'Nữ',
	'1976-9-4',
	'k2'
),
(
	'gv10',
	N'Nguyễn Thu Trâm',
	N'Nữ',
	'1987-10-4',
	'k3'
),
(
	'gv11',
	N'Nguyễn Thị Loan',
	N'Nữ',
	'1978-5-4',
	'k3'
),
(
	'gv12',
	N'Võ Tú Tài',
	N'Nam',
	'1972-9-10',
	'k4'
),
(
	'gv13',
	N'Hà Huy Tập',
	N'Nam',
	'1967-10-3',
	'k4'
),
(
	'gv14',
	N'Nguyễn Thu Lan',
	N'Nữ',
	'1967-3-9',
	'k4'
),
(
	'gv15',
	N'Nguyễn Thị Hà Lan',
	N'Nữ',
	'1987-12-19',
	'k4'
),
(
	'gv16',
	N'Nguyễn Thị Bích Ngọc',
	N'Nữ',
	'1967-9-3',
	'k4'
),
(
	'gv17',
	N'Trần Thu Hiên',
	N'Nữ',
	'1947-2-28',
	'k5'
),
(
	'gv18',
	N'Vũ Tuấn Anh',
	N'Nam',
	'1977-4-12',
	'k5'
),
(
	'gv19',
	N'Nguyễn Vũ Duy Trường',
	N'Nam',
	'1977-4-30',
	'k5'
),
(
	'gv20',
	N'Tạ Quang Duy',
	N'Nam',
	'1987-4-12',
	'k2'
),
(
	'gv21',
	N'Nguyễn Thị Bích Loan',
	N'Nữ',
	'1977-4-30',
	'k3'
);

--Thêm dữ liệu lớp hành chính

insert into tblLopHC
(
	sMaLop,
	sTenLop,
	sMaKhoa,
	sMaGV
)
values
(
	'lp1',
	N'1910A01',
	'k1',
	'gv1'
),
(
	'lp2',
	N'1910A02',
	'k1',
	'gv1'
),
(
	'lp3',
	N'1910A03',
	'k1',
	'gv2'
),
(
	'lp4',
	N'1910A04',
	'k1',
	'gv2'
),
(
	'lp5',
	N'1910A05',
	'k1',
	'gv3'
),
(
	'lp6',
	N'2010A01',
	'k1',
	'gv3'
),
(
	'lp7',
	N'2010A02',
	'k2',
	'gv6'
),
(
	'lp8',
	N'2010A03',
	'k2',
	'gv6'
),
(
	'lp9',
	N'2010A04',
	'k2',
	'gv7'
),
(
	'lp10',
	N'2010A05',
	'k2',
	'gv7'
),
(
	'lp11',
	N'2110A05',
	'k1',
	'gv4'
),
(
	'lp12',
	N'2110A01',
	'k3',
	'gv10'
),
(
	'lp13',
	N'2110A02',
	'k3',
	'gv10'
),
(
	'lp14',
	N'2110A03',
	'k3',
	'gv11'
),
(
	'lp15',
	N'2110B03',
	'k3',
	'gv11'
),
(
	'lp16',
	N'2110A04',
	'k4',
	'gv12'
),
(
	'lp17',
	N'2110A06',
	'k4',
	'gv12'
),
(
	'lp18',
	N'2110A07',
	'k4',
	'gv13'
),
(
	'lp19',
	N'k15',
	'k4',
	'gv13'
)

-- Thêm dữ liệu bảng giảng viên - môn học
/*
insert into tblGiangVien_MonHoc
(
	sMaGV,
	sMaMon
)
VALUES
(
	'gv1',
	'm1'
),
(
	'gv1',
	'm2'
),
(
	'gv3',
	'm1'
),
(
	'gv3',
	'm4'
),
(
	'gv4',
	'm1'
),
(
	'gv5',
	'm4'
),
(
	'gv6',
	'm2'
),
(
	'gv6',
	'm1'
),
(
	'gv7',
	'm2'
),
(
	'gv7',
	'm6'
),
(
	'gv11',
	'm1'
),
(
	'gv11',
	'm7'
),
(
	'gv13',
	'm2'
),
(
	'gv13',
	'm6'
),
(
	'gv9',
	'm3'
),
(
	'gv9',
	'm2'
),
(
	'gv10',
	'm3'
),
(
	'gv10',
	'm1'
)
*/
-- Thêm dữ liệu sinh viên

insert into tblSinhVien
(
	sMaSV,
	stensv,
	dngaysinh,
	sdiachi,
	sgioitinh,
	sLopHC,
	ssdt
)
values
('19IT01','nguyen manh hung','2000-4-15', 'Hà Nội',N'Nam','lp15','04567878'),
('19IT02','nguyen thuy trang','2000-5-26','Bắc Ninh', N'Nữ','lp2','014252369'),
('19IT03','pham minh chung','2002-8-30', 'Bắc Ninh', N'Nữ','lp1','0963445741'),
('19IT04','dinh chung hoang','2003-08-08', 'Hà Nội', N'Nam','lp3','075d4453486'),
('19IT05','nguyen hoang long','1999-3-6', 'Hà Nội', N'Nam','lp1','0942382442'),
('19IT06','le phuong hoa','2000-12-12', 'Hà Nội', N'Nữ','lp2','096424784'),
('19IT07','vu quynh kim anh','2003-9-24', 'Hà Nội', N'Nữ','lp2','09646787'),
('19IT08','doan quoc huy','2000-8-9', 'Bắc Ninh', N'Nam','lp5','096244454'),
('19IT09','dinh quang anh','2002-2-4', 'Thanh Hóa', N'Nữ','lp5','09632242554'),
('19IT10','dinh quang anh','2001-9-29', 'Thanh Hóa', N'Nữ','lp5','09632242554'),
('20IT01','le duc hoan','2001-5-5', 'Thanh Hóa', N'Nam','lp10','0123456789'),
('20IT02','nguyen manh truong','2002-5-16', 'Hà Nội', N'Nam','lp8','0456789123'),
('20IT03','nguyen thi c','2000-1-26', 'Hà Nội', N'Nữ','lp6','0147852369'),
('20IT04','pham thi d','2001-10-30', 'Hà Nội', N'Nữ','lp9','0963258741'),
('20IT05','dinh quang minh','2001-2-12', 'Hà Nội', N'Nam','lp10','0753159486'),
('20IT06','nguyen can d','2003-3-2', 'Hà Nội', N'Nam','lp9','09632582442'),
('20IT07','le phuong linh','2001-12-3', 'Hà Nội', N'Nữ','lp6','09636784'),
('20IT08','vu quynh huong','2003-3-24', 'Hà Nội', N'Nữ','lp10','096325787'),
('20IT09','doan van hau','2001-7-1', 'Bắc Giang', N'Nữ','lp8','096325454'),
('20IT10','dinh dieu thuy','2001-7-29', 'Bắc Giang', N'Nữ','lp7','09632554'),
('21IT01','le minh hiep','2002-5-10', 'Bắc Giang', N'Nam','lp15','01234242'),
('21IT02','nguyen manh hai','2003-12-15', 'Bắc Giang', N'Nam','lp13','045624242'),
('21IT03','nguyen thi ut','2000-11-26', 'Bắc Giang', N'Nữ','lp11','0147824424'),
('21IT04','pham thi cuc','1999-12-30', 'Hà Nội', N'Nữ','lp14','0963246542'),
('21IT05','dinh quang minh','2000-8-9', 'Hà Nội', N'Nam','lp15','075312424'),
('21IT06','nguyen can gio','2001-8-3', 'Hà Nội', N'Nam','lp14','09632242'),
('21IT07','le phuong han','2000-12-1', 'Hà Nội', N'Nữ','lp11','09242543878'),
('21IT08','vu kim anh','2001-4-12', 'Cao Bằng', N'Nữ','lp15','0963257454'),
('21IT09','doan chung','2000-8-9', 'Cao Bằng', N'Nữ','lp13','09633464556'),
('21IT10','dinh dieu hoang mai','2001-2-11', 'Cao Bằng', N'Nữ','lp12','096567464')

-- thêm dữ liệu bảng donvihoc vu
insert into tblDonViHocVu
(
	sMaDonViHocVu, iNamHoc, iKyHoc
)
values
(
	'1-2020:2021',
	2020,
	1
),
(
	'2-2020:2021',
	2020,
	2
),
(
	'3-2020:2021',
	2020,
	3
),
(
	'1-2021:2022',
	2021,
	1
),
(
	'2-2021:2022',
	2021,
	2
),
(
	'3-2021:2022',
	2021,
	3
);

-- thêm dữ liệu bảng học
insert into tblHoc
(
	sMaGV, sMaMon, sMaSV, sMaDonViHocVu, fDiemCC, fDiemGK, fDiemThi
)
values
(
	'gv1',
	'm1',
	'19IT03',
	'1-2020:2021',
	10,
	8,
	8
),
(
	'gv1',
	'm1',
	'19IT04',
	'1-2020:2021',
	7,
	9,
	8
),
(
	'gv2',
	'm3',
	'19IT01',
	'1-2020:2021',
	10,
	9,
	9
),
(
	'gv2',
	'm3',
	'19IT03',
	'1-2020:2021',
	9,
	9,
	10
),
(
	'gv2',
	'm3',
	'19IT08',
	'2-2020:2021',
	9,
	9,
	6
),
(
	'gv2',
	'm3',
	'20IT01',
	'2-2020:2021',
	8,
	7,
	9
),
(
	'gv3',
	'm4',
	'20IT01',
	'2-2020:2021',
	10,
	8,
	8
),
(
	'gv3',
	'm6',
	'20IT01',
	'2-2020:2021',
	9,
	10,
	7
),
(
	'gv3',
	'm5',
	'20IT06',
	'3-2020:2021',
	9,
	10,
	6
),
(
	'gv3',
	'm5',
	'20IT07',
	'3-2020:2021',
	10,
	8,
	8
),
(
	'gv7',
	'm5',
	'20IT06',
	'3-2020:2021',
	9,
	9,
	9
),
(
	'gv7',
	'm5',
	'20IT07',
	'3-2020:2021',
	9,
	8,
	10
),
(
	'gv7',
	'm2',
	'20IT09',
	'1-2021:2022',
	9,
	10,
	10
),
(
	'gv7',
	'm3',
	'20IT09',
	'1-2021:2022',
	7,
	9,
	10
),
--
(
	'gv10',
	'm1',
	'21IT01',
	'1-2021:2022',
	7,
	8,
	9
),
(
	'gv10',
	'm1',
	'21IT02',
	'1-2021:2022',
	8,
	9,
	10
),
(
	'gv10',
	'm5',
	'21IT03',
	'2-2021:2022',
	9,
	10,
	5
),
(
	'gv10',
	'm5',
	'21IT01',
	'2-2021:2022',
	10,
	10,
	9
),
(
	'gv9',
	'm3',
	'21IT02',
	'2-2021:2022',
	8,
	9,
	9
),
(
	'gv9',
	'm3',
	'20IT03',
	'2-2021:2022',
	10,
	8,
	7
),
(
	'gv9',
	'm3',
	'20IT04',
	'2-2021:2022',
	9,
	10,
	10
),
(
	'gv10',
	'm1',
	'20IT04',
	'3-2021:2022',
	8,
	10,
	10
),
--
(
	'gv11',
	'm6',
	'21IT05',
	'3-2021:2022',
	8,
	10,
	2
),
(
	'gv9',
	'm6',
	'21IT05',
	'3-2021:2022',
	8,
	9,
	9
),
(
	'gv12',
	'm3',
	'21IT04',
	'3-2021:2022',
	10,
	8,
	7
),
(
	'gv9',
	'm5',
	'20IT04',
	'3-2021:2022',
	9,
	10,
	10
),
(
	'gv11',
	'm5',
	'21IT03',
	'1-2021:2022',
	8,
	10,
	10
);

-- Select các bảng
select * from tblGiangVien
select * from tblHoc
select * from tblKhoa
select * from tblLopHC
select * from tblMonHoc
select * from tblSinhVien

-- Tạo View
-- VIEW
/*
-	Tạo view tính tổng số môn học đã học của từng sinh viên
-	Tạo view thống kê số học sinh nam của từng môn học
-	Tạo view thống kê top 3 sinh viên có điểm cao nhất của Môn Học X
-	Tạo view tính điểm trung bình của sinh viên trong từng môn học
-	Tạo view thống kê môn học có số TC > 3
*/
--	Tạo view tính số môn học đã học của từng sinh viên
create view v_tongsomonhoccuatungsinhvien
as
select tblHoc.sMaSV, sTenSV, count(distinct sMaMon) as [Số lượng môn đã học]
from tblHoc
left join tblSinhVien
on tblSinhVien.sMaSV = tblHoc.sMaSV
group by tblHoc.sMaSV, sTenSV
--

-- Tạo view thống kê số sinh viên nam đã học của từng môn
create view v_sosinhviennamcuatungmon
as
select tblHoc.sMaMon, sTenMon, count(distinct tblHoc.sMaSV) as [Số lượng sinh viên nam học]
from tblMonHoc, tblHoc, tblSinhVien
where tblMonHoc.sMaMon = tblHoc.sMaMon
and tblSinhVien.sMaSV = tblHoc.sMaSV
and sGioiTinh = N'Nam'
group by tblHoc.sMaMon, sTenMon

-- Tạo view thống kê top 3 sinh viên có điểm KTHP cao nhất của Môn Học Cơ sở dữ liệu
create view v_top3sinhviencodiemmaxcuamon
as
select top 3 tblHoc.sMaSV, sTenSV, fDiemKTHP
from tblSinhVien
inner join tblHoc
on tblSinhVien.smasv = tblHoc.smasv
inner join tblMonHoc
on tblMonHoc.sMaMon = tblHoc.sMaMon
where tblHoc.smamon = tblMonHoc.smamon
and sTenMon = N'Cơ sở dữ liệu'
order by fDiemKTHP desc

-- Tạo view tính điểm trung bình của sinh viên trong từng môn học
create view v_dtbTungMonHoc
as
select tblMonHoc.sMaMon, sTenMon, avg(fDiemKTHP) as [Trung bình điểm môn]
from tblMonHoc, tblHoc
where tblMonHoc.sMaMon = tblHoc.sMaMon
group by tblMonHoc.sMaMon, sTenMon


--	Tạo view thống kê môn học có số TC > 3

create view v_thongkemhsotclonhon3
as
select *
from tblMonHoc
where isotc > 3

/*
-	Thống kê danh sách giảng viên nữ của Khoa CNTT
-	Tính tuổi trung bình của các giảng viên
-	Cho biết giảng viên có tuổi cao nhất
-	Thống kê số giảng viên nam trên 50 tuổi
-	Tính số giảng viên dạy trên 5 môn
*/

--	Thống kê danh sách giảng viên nữ của Khoa CNTT
create view v_dsgvnucuakhoacntt
as
select sMaGV, sTenGV, sGioiTinh, dNgaySinh
from tblGiangVien, tblKhoa
where tblGiangVien.smakhoa = tblKhoa.sMaKhoa
and stenkhoa = N'CNTT'
and sgioitinh = N'Nữ'

--	Tính tuổi trung bình của các giảng viên
create view v_tuoitbtatcagiangvien
as
select avg(datediff(day, dNgaySinh, getdate())/365) as [Tuổi TB của Giảng Viên]
from tblGiangVien

--	Cho biết giảng viên có tuổi cao nhất
create view v_tuoimax
as
select top 1 with ties sTenGV, datediff(day, dNgaySinh, getdate())/365 as [Tuổi]
from tblGiangVien
order by datediff(day, dNgaySinh, getdate())/365 desc

--	Thống kê số giảng viên nam trên 50 tuổi
create view v_thongkegiangviennamtren50tuoi
as
select count(smagv) as [Số lượng giảng viên nam > 50 tuổi]
from tblGiangVien
where datediff(day, dNgaySinh, getdate())/365 > 50
and sgioitinh = N'Nam'

---	Tính số giảng viên dạy trên 5 môn
-- Thiếu dưẽ liệu
create view v_sogiangviendaytren5mon
as
select tblGiangvien.sMaGV, sTenGV, count(distinct sMaMon) as [Số môn dạy]
from tblGiangVien, tblHoc
where tblGiangvien.sMaGV = tblHOc.smagv
group by tblGiangvien.sMaGV, sTenGV
having count(distinct sMaMon) > 2


/*
-	Thống kê số lượng môn của từng khoa quản lý
-	Cho biết các môn học của Khoa X quản lý
-	Cho biết môn English Basic có bao nhiêu khoa cung cấp
-	Cho biết tổng số tín chỉ môn học của từng khoa cung cấp
*/

--	Thống kê số lượng môn của từng khoa quản lý
create view v_somonkhoaquanly
as
select tblKhoa.sMaKhoa, sTenKhoa, count(sMaMon) as [Cung cấp số môn]
from tblKhoa, tblMonHoc
where tblKhoa.sMaKhoa = tblMonHoc.sMaKhoa
group by tblKhoa.sMaKhoa, sTenKhoa

--	Cho biết các môn học của Khoa X quản lý
-- x: Khoa Ngoại ngữ
create view v_khoangoainguquanlymon
as
select sTenMon
from tblKhoa, tblMonHoc
where tblKhoa.smakhoa = tblMonHoc.smakhoa
and sTenKhoa = N'Ngoại Ngữ'
group by sTenMon, sMaMon

--	Cho biết môn English Basic có bao nhiêu khoa cung cấp
create view v_monenglishcosokhoacungcap
as
select sTenMon, count(tblMonHoc.sMakhoa) as [Số khoa cung cấp]
from tblMonHoc, tblKhoa
where tblMonHoc.sMakhoa = tblkhoa.smakhoa
and sTenMon = N'English Basic'
group by stenmon

--	Cho biết tổng số tín chỉ môn học của từng khoa cung cấp
create view v_sotccuatungkhoacungcap
as
select sTenkhoa, sum(isotc) as [Cung cấp số tín chỉ]
from tblKhoa, tblMonHoc
where tblKhoa.sMakhoa = tblMonHoc.sMaKhoa
group by sTenKhoa


/*
-	Cho biết giảng viên dạy Môn X của Khoa Y
-	Thống kê số sinh viên của từng lớp hành chính
-	Thống kê sinh viên đã từng phải học lại ít nhất 2 lần
-	Thống kê Sinh Viên có địa chỉ ở Bắc Ninh
-	Cho biết danh sách sinh viên có điểm KTHP > 9 của môn CSDL
*/

--	Cho biết giảng viên dạy Môn X của Khoa Y
-- X: English basic, Y: Khoa Điện tử thông tin
create view v_truyvangiangvien
as
select distinct tblGiangVien.sMaGV, sTenGV, sTenMon as [Dạy môn], sTenKhoa as [Thuộc khoa]
from tblGiangVien, tblKhoa, tblMonHoc, tblHoc
where tblGiangVien.sMaGV = tblHoc.sMaGV
and tblHoc.sMaMon = tblMonHoc.sMaMon
and tblGiangVien.sMakhoa = tblKhoa.sMakhoa
and tblMonHoc.sMaKhoa = tblKhoa.sMakhoa
and sTenMon = N'English basic'
and sTenKhoa = N'Điện tử thông tin'


--	Thống kê số sinh viên của từng lớp hành chính
create view v_thongkesoluongsvcuatunglophc
as
select sTenLop, count(sMaSV) as[Sĩ số]
from tblLopHC, tblSinhVien
where tblLopHC.sMaLop = tblSinhVien.sLopHC
group by tblSinhVien.sLopHC, stenlop

--	Thống kê những sinh viên đã từng phải học lại ít nhất 2 lần
create view v_thongkesvhoclai
as
select tblSinhVien.sMaSV, count(tblMonHoc.sMaMon) as [Số lần học lại]
from tblSinhVien
inner join tblHoc
on tblSinhVien.sMaSV = tblHoc.sMaSV
inner join tblMonHoc
on tblHoc.sMaMon = tblMonHoc.sMaMon
group by tblMonHoc.sMaMon, tblSinhVien.sMaSV, sTenMon
having count(tblMonHoc.sMaMon) > 1


--Thống kê Sinh Viên có địa chỉ ở Bắc Ninh
create view v_thongkesvcodiachiBN
as
select sTenSV, sDiaChi
from tblSinhVien
where sDiaChi = N'Bắc Ninh'

---	Cho biết danh sách sinh viên có điểm KTHP > 9 của môn CSDL
create view v_dssvcodiemlonhon9
as
select sTenSV, fDiemKTHP
from tblSinhVien, tblHoc, tblMonHoc
where tblSinhVien.sMaSV = tblHoc.sMaSV
and tblHoc.sMaMon = tblMonHoc.sMaMon
and fDiemKTHP > 9
and sTenMon = N'Cơ sở dữ liệu'


/*
-	Cho biết danh sách sinh viên do giảng viên X chủ nhiệm
-	Thống kê sinh viên có năm sinh là 2002
-	Thống kê sinh viên học khóa 19A
-	Thống kê sinh viên lớp X của khoa CNTT
-	Thống kê số sinh viên của từng lớp hành chính
-	Cho biết những sinh viên đã tích lũy được trên 12 TC
-	Thống kê Số sinh viên đi học không đầy đủ (Điểm CC < 10) của môn CSDL
*/

--	Cho biết danh sách sinh viên do giảng viên X chủ nhiệm
create view v_sv_gvchunhiem
as
select sMaSV, sTenSV
from tblSinhVien, tblGiangVien, tblLopHC
where tblSinhVien.sLopHC = tblLopHC.sMaLop
and  tblGiangVien.sMaGV = tblLopHC.sMaGV
and sTenGV = N'Trịnh Thị Xuân'

--	Thống kê số sinh viên có năm sinh là 2002
create view v_svnam2002
as
select count(sMaSV) as [Số lượng sv năm 2002]
from tblSinhVien
where year(dNgaySinh) = 2002

---	Thống kê sinh viên học khóa 19
create view v_svkhoa19
as
select *
from tblSinhVien
where sMaSV like '%19%'

--	Thống kê danh sách sinh viên lớp X của khoa CNTT
create view v_dssv_khoacntt
as
select tblSinhVien.sMaSV, sTenSV
from tblSinhVien, tblLopHC, tblKhoa
where tblSinhVien.sLopHC = tblLopHC.sMaLop
and tblLopHC.sMaKhoa = tblKhoa.sMaKhoa
and sTenKhoa = N'CNTT'
and sMaLop = 'lp2'

--	Thống kê số sinh viên của từng lớp hành chính
create view v_sosvlophc
as
select tblLopHC.sMaLop, sTenLop, count(sMaSV) as [Số lượng sinh viên]
from tblLopHC, tblSinhVien
where sMaLop = sLopHC
group by tblLopHC.sMaLop, sTenLop

--	Cho biết những sinh viên đã tích lũy được trên 12 TC
create view v_xemmon
as
select distinct tblMonHoc.sMaMon, sMaSV, iSoTC
from tblHoc, tblMonHoc
where tblHoc.smamon = tblMonHoc.sMaMon

create view v_sotctichluy
as
select sTenSV, sum(iSoTC)
from tblSinhVien, v_xemmon
where tblSinhVien.sMaSV = v_xemmon.sMaSV
group by tblSinhVien.sMaSV, sTenSV


--	Thống kê Số sinh viên đi học không đầy đủ (Điểm CC < 10) của môn CSDL
create view v_svdihockdaydu
as
select count(tblSinhVien.sMaSV)
from tblSinhVien, tblHoc, tblMonHoc
where tblSinhVien.sMaSV = tblHoc.sMaSV
and tblMonHoc.sMaMon = tblHoc.sMaMon
and sTenMon = N'Cơ sở dữ liệu'
and fDiemCC < 10

select * from tblMonHoc

-- TẠO THỦ TỤC (STORED PROCEDURE)
/*
-	Tạo thủ tục thêm sinh viên
-	Tạo thủ tục sửa tên sinh viên theo mã sinh viên
-	Sửa tên lớp hc của sinh viên để chuyên sang lớp khác thông qua mã sinh viên được truyền vào
-	Sửa địa chỉ của sinh viên thong qua mã sinh viên truyền vào
-	Cho biết danh sách môn (tên môn) của sinh viên đã học, với mã sinh viên là tham số truyền vào
*/

--	Tạo thủ tục thêm sinh viên
create proc insertSV
@masv varchar(50), @ten nvarchar(50), @ngaysinh datetime, @diachi nvarchar(50), @gt nvarchar(10), @malop varchar(50), @sdt varchar(10)
as
insert into tblSinhVien (sMaSV, sTenSV, dNgaySinh, sDiaChi, sGioiTinh, sLopHC, sSDT)
values (@masv, @ten, @ngaysinh, @diachi, @gt, @malop, @sdt)

exec insertSV
@masv = '21A100100141', @ten = N'Tạ Đức Hoàn', @ngaysinh = '2003-5-5', @diachi = N'Bắc Ninh', @gt = N'Nam', @malop = 'lp6', @sdt = '0321532432'


--	Tạo thủ tục sửa tên sinh viên theo mã sinh viên
create proc updateTenSV
@ma varchar(50), @ten nvarchar(50)
as
update tblSinhVien
set sTenSV = @ten
where sMaSV = @ma

exec updateTenSV
@ma = '20IT07', @ten = N'Lê Phương Linh'


--	Sửa tên lớp hc của sinh viên để chuyên sang lớp khác thông qua mã sinh viên, mã lớp được truyền vào
create proc chuyenLop
@masv varchar(50), @malop varchar(50)
as
update tblSinhVien
set sLopHC = @malop
where sMaSV = @masv

exec chuyenlop
@masv = '21IT09', @malop = 'lp4'

--	Sửa địa chỉ của sinh viên thong qua mã sinh viên truyền vào
create proc updateDiaChiSV
@ma varchar(50), @dc nvarchar(50)
as
update tblSinhVien
set sDiaChi = @dc
where sMaSV = @ma

exec updateDiaChiSV
@ma = '19IT02', @dc = N'Hưng Yên'


--	Cho biết danh sách môn (tên môn) của sinh viên đã học, với mã sinh viên là tham số truyền vào
create proc montichluy
@masv varchar(50)
as
select distinct sTenMon
from tblSinhVien, tblHoc, tblMonHoc
where tblSinhVien.sMaSV = tblHoc.sMaSV
and tblHoc.sMaMon = tblMonHoc.sMaMon
and tblSinhVien.sMaSV = @masv

exec montichluy
@masv = '21IT01'


/*
-	Tạo thủ tục chèn thêm 1 giáo viên mới(kiểm tra thỏa mãn điều kiện)
-	Tạo thủ tục cho danh sách các giáo viên nam thuộc khoa nào với tên khoa là tham số truyền vào
-	Tạo thủ tục cho danh sách các giáo viên sinh năm nào đó với năm là tham số truyền vào
-	Tạo thủ tục cho biết tên giáo viên quản lí lớp hành chính với lớp hành chính là tham số truyền vào
-	Tạo thủ tục cho biết tổng số lượng giảng viên nữ của 1 khoa với khoa là tham số truyền vào
*/

--	Tạo thủ tục chèn thêm 1 giáo viên mới(kiểm tra thỏa mãn điều kiện)
create proc insertGV
@ma varchar(50), @ten nvarchar(50), @gt nvarchar(10), @date date, @mak varchar(50)
as
insert into tblGiangVien (sMaGV, sTenGV, sGioiTinh, dNgaySinh, sMaKhoa)
values (@ma, @ten, @gt, @date, @mak)

exec insertGV
@ma = 'gv20', @ten = N'Vũ Duy Cường', @gt = N'Nam', @date = '1978-1-12', @mak = 'k3'

--	Tạo thủ tục cho danh sách các giáo viên nam thuộc khoa nào với tên khoa là tham số truyền vào
create proc dsgvnamthuockhoa
@tenk nvarchar(50)
as
select sTenGV, sGioiTinh
from tblGiangVien, tblKhoa
where tblGiangVien.sMaKhoa = tblKhoa.sMaKhoa
and sTenKhoa = @tenk
and sGioiTinh = N'Nam'

exec dsgvnamthuockhoa
@tenk = N'Kinh tế'

--	Tạo thủ tục cho danh sách các giáo viên sinh năm nào đó với năm là tham số truyền vào
create proc indsgvtheonamsinh
@nam int
as
select sTenGV, dNgaySinh
from tblGiangVien
where year(dngaySinh) = @nam

exec indsgvtheonamsinh
@nam = 1967

--	Tạo thủ tục cho biết tên giáo viên quản lí lớp hành chính với lớp hành chính là tham số truyền vào
create proc quanlylop
@mal varchar(50)
as
select tblGiangVien.sMaGV, sTenGV
from tblGiangVien, tblLopHC
where tblGiangVien.sMaGV = tblLopHC.sMaGV
and sMaLop = @mal

exec quanlylop
@mal = 'lp100'

--	Tạo thủ tục cho biết tổng số lượng giảng viên nữ của 1 khoa với khoa là tham số truyền vào
create proc demsogvnu
@mak varchar(50)
as
begin
	if exists (select * from tblKhoa where sMaKhoa = @mak)
	begin
		select count(sMaGV) as [Số lượng giảng viên nữ]
		from tblGiangVien
		where sGioiTinh = N'Nữ' and sMaKhoa = @mak
	end
	else
	begin
		print N'MÃ KHOA KHÔNG TỒN TẠI'
		return
	end
end

exec demsogvnu
@mak = 'k2'

/*
-	Tạo thủ tục thêm 1 khoa
-	Tạo thủ tục sửa mã khoa của 1 môn theo mã môn được truyền vào
-	Tạo thủ tục trích ra các sinh viên là sinh viên của @maKhoa, @maKhoa là tham số tuyền vào
-	Tạo thủ tục trích ra các sinh viên học @maMon, @maMon là tham số tuyền vào
-	Tạo thủ tục trích ra các sinh viên của @lop, @lop là tham số tuyền và
*/

--	Tạo thủ tục thêm 1 khoa
create proc insertKhoa
@mak varchar(50), @tenk nvarchar(50), @dc nvarchar(50)
as
insert into tblKhoa (sMaKhoa, sTenKhoa, sDiaChi)
values (@mak, @tenk, @dc)

exec insertKhoa
@mak = 'k7', @tenk = N'Mỹ Thuật', @dc = N'Cầu Giấy'

--	Tạo thủ tục sửa mã khoa của 1 môn theo mã môn được truyền vào
create proc doimakhoacungcap
@mam varchar(50), @mak varchar(50)
as
update tblMonHoc
set sMaKhoa = @mak
where sMaMon = @mam

exec doimakhoacungcap
@mam = 'm9', @mak = 'k5'

--	Tạo thủ tục trích ra các sinh viên là sinh viên của @maKhoa, @maKhoa là tham số tuyền vào
create proc thongkesvthuockhoa
@mak varchar(50)
as
begin
	if exists (select * from tblKhoa where sMaKhoa = @mak)
	begin
		select sTenSV
		from tblSinhVien, tblLopHC, tblKhoa
		where tblSinhVien.sLopHC = tblLopHC.sMaLop
		and tblLopHC.sMaKhoa = tblKhoa.sMaKhoa
		and tblKhoa.sMaKhoa = @mak
	end
	else
	begin
		print N'MÃ KHOA KHÔNG TỒN TẠI'
		return;
	end
end


exec thongkesvthuockhoa
@mak = 'k100'

--	Tạo thủ tục trích ra các sinh viên học @maMon, @maMon là tham số tuyền vào
create proc svhocmon
@maM varchar(50)
as
begin
	if exists (select * from tblMonHoc where sMaMon = @maM)
	begin
		select distinct sTenSV
		from tblSinhVien, tblHoc
		where tblSinhVien.sMaSV = tblHoc.sMaSV
		and sMaMon = @maM
	end
	else
	begin
		print N'MÃ MÔN KHÔNG TỒN TẠI'
		return
	end
end

exec svhocmon
@maM = 'm6'
/* Tạo thủ tục Thống kê sinh viên đã từng phải học lại ít nhất 2 lần theo môn, 
với mã môn là tham số truyền vào
*/
CREATE PROC spDanhSachHocLai (@maMon varchar(50)) AS
BEGIN
	IF @maMon IN (SELECT tblMonHoc.sMaMon FROM tblMonHoc)
		BEGIN
			SELECT tblSinhVien.sMaSV AS [Mã SV], tblSinhVien.sTenSV [Tên SV]
			FROM tblSinhVien, tblMonHoc, tblHoc
			WHERE @maMon = tblMonHoc.sMaMon AND
				tblSinhVien.sMaSV = tblHoc.sMaSV AND tblMonHoc.sMaMon = tblHoc.sMaMon
			GROUP BY tblSinhVien.sMaSV, tblSinhVien.sTenSV
			HAVING COUNT(tblHoc.dNgayBatDau) >= 2
		END
	ELSE
		RAISERROR(N'Mã môn này không tồn tại', 16, 10)
END

EXEC spDanhSachHocLai @maMon = 'm5'

/*
-	Thêm một sinh viên: đã tạo
-	Update lớp hành chính của sinh viên, với mã sinh viên, mã lớp là tham số truyền vào: đã tạo
-	Hiện sinh viên có số tín chỉ tích lũy trong khoảng x-y, x và y là tham số truyền vào
-	Tìm ds sinh viên thuộc (được quản lý bởi) lớp hành chính, với mã lớp được truyền vào
-	Tìm tên sinh viên có tổng môn lớn hơn tổng số môn đc truyền và
*/
--	Thêm một sinh viên: đã tạo

--	Hiện sinh viên có số tín chỉ tích lũy trong khoảng x-y, x và y là tham số truyền vào
-- tạo view đếm số tín chỉ tích lũy của sinh viên
create view demsotctichluy
as
select distinct tblHoc.sMaMon, tblSinhVien.sMaSV, sTenSV, iSoTC
from tblSinhVien, tblHoc, tblMonHoc
where tblSinhVien.sMaSV = tblHoc.sMasv
and tblHoc.sMaMon = tblMonHoc.sMaMon
group by tblSinhVien.sMaSV, sTenSV, tblHoc.sMaMon, iSoTC

alter proc hiensotctichluy
@x int, @y int
as
if(@x > @y)
begin
	print N'X phải nhỏ hơn Y. MỜI BẠN NHẬP LẠI'
	return
end
else
begin
	select demsotctichluy.sTenSV, sum(demsotctichluy.iSoTC) as [Số TC tích lũy]
	from demsotctichluy
	group by demsotctichluy.sTenSV, demsotctichluy.sTenSV
	having sum(demsotctichluy.iSoTC) between @x and @y
end


exec hiensotctichluy
@x = 10, @y = 15

/*
-	Tạo thủ tục thêm mới một môn học
-	Tạo thủ tục, thay đổi cố vấn học tập(giảng viên chủ nhiệm) quản lý lớp hành chính, với mã giảng viên, mã lớp là tham số truyền vào
-	Tạo thủ tục tính số tiền học phải đóng của sinh viên, với mã sinh viên là tham số truyền vào, số lượng tín chỉ tích lũy của sinh viên đó là trả về. Biết 1 TC là 378.000
-	Tạo thủ tục lấy số lượng sinh viên nam và nữ trong 1 khoa, với mã khoa là tham số truyền vào, số lượng là tham số output
-	Tạo thủ tục cho biết danh sách giảng viên trên số tuổi, với số tuổi là tham số truyền vào
*/

--	Tạo thủ tục thêm mới một môn học
create proc insertMonHoc
@ma varchar(50), @mak varchar(50), @tenm nvarchar(50), @sotc int
as
begin
	if exists (select * from tblMonHoc where sMaMon = @ma)
	begin
		print N'MÃ MÔN ĐÃ TỒN TẠI'
		return;
	end
	else
	begin
		insert into tblMonHoc (sMaMon, sMaKhoa, sTenMon, iSoTC)
		values (@ma, @mak, @tenm, @sotc)
	end
end

exec insertMonHoc
@ma = 'm24', @mak = 'k2' , @tenm = N'Lập trình mạng', @sotc = 4

/*Tạo thủ tục, thay đổi cố vấn học tập(giảng viên chủ nhiệm) quản lý lớp hành chính,
với mã giảng viên, mã lớp là tham số truyền vào*/
CREATE proc editCVHT
@mal varchar(50), @magv varchar(50)
as
begin
	if exists (select * from tblLopHC where sMaLop = @mal)
	begin
		if exists (select * from tblGiangVien where sMaGV = @magv)
		begin
			update tblLopHC
			set sMaGV = @magv
			where sMaLop = @mal

			print N'CẬP NHẬT THÀNH CÔNG'
		end
		else
		begin
			print N'MÃ GIẢNG VIÊN KHÔNG TỒN TẠI'
			return;
		end
	end
	else
	begin
		print N'MÃ LỚP KHÔNG TỒN TẠI'
		return;
	end
end

exec editCVHT
@mal = 'lp2', @magv = 'gv2'

/* -	Tạo thủ tục tính số tiền học phải đóng của sinh viên, 
với mã sinh viên là tham số truyền vào, số lượng tín chỉ của sinh viên đó là trả về. 
Biết 1 TC là 378.000 */
CREATE PROC tinhTienHocCuaSinhVien
@masv varchar(50), @soluong int output
as
begin
	if exists (select * from tblSinhVien where sMaSV = @masv)
	begin
		select @soluong = sum(iSoTC)
		from tblSinhVien, tblHoc, tblMonHoc
		where tblSinhVien.sMaSV = tblHoc.sMaSV
		and tblHoc.sMaMon = tblMonHoc.sMaMon
		and tblSinhVien.sMaSV = @masv
		group by tblSinhVien.sMaSV
	end
	else
	begin
		print N'KHÔNG TÌM THẤY SINH VIÊN'
		return
	end
end

declare @sl int
exec tinhTienHocCuaSinhVien
@masv = '21IT03', @soluong = @sl output
select (@sl * 378000) as [Số tiền sinh viên phải đóng]

--	Tạo thủ tục lấy số lượng sinh viên nam và nữ trong 1 khoa, với mã khoa là tham số truyền vào, số lượng là tham số output
create proc demslgsvnamnu
@mak varchar(50), @nam int output, @nu int output
as
begin
	if exists (select * from tblKhoa where sMaKhoa = @mak)
	begin
		set @nam = 0
		set @nu = 0
		select @nam = count(*)
		from tblSinhVien, tblLopHC, tblKhoa
		where tblSinhVien.sLopHC = tblLopHC.sMaLop
		and tblKhoa.sMaKhoa = tblLopHC.sMaKhoa
		and sGioiTinh = N'Nam'
		and tblKhoa.sMaKhoa = @mak;
		select @nu = count(*)
		from tblSinhVien, tblLopHC, tblKhoa
		where tblSinhVien.sLopHC = tblLopHC.sMaLop
		and tblKhoa.sMaKhoa = tblLopHC.sMaKhoa
		and sGioiTinh = N'Nữ'
		and tblKhoa.sMaKhoa = @mak;
	end
	else
	begin
		print N'KHÔNG TÌM THẤY KHOA'
		return
	end
end

declare @slnam int, @slnu int
exec demslgsvnamnu
@mak = 'k1', @nam = @slnam output, @nu = @slnu output
select @slnam as[Số lượng sinh viên nam], @slnu as [Số lượng sinh viên nữ]

--	Tạo thủ tục cho biết danh sách giảng viên trên số tuổi, với số tuổi là tham số truyền vào
create PROC tuoigv
@tuoi int
as
select sTenGV, datediff(day, dNgaySinh, getdate())/365 as [Tuổi]
from tblGiangVien
where datediff(day, dNgaySinh, getdate())/365 > @tuoi

exec tuoigv
@tuoi = 57

-- TRIGGER
-- Hoàn
/*
- Tạo trigger check sinh viên không được học lại quá 3 lần trên 1 môn
- Thêm cột sĩ số trong bảng tblLopHC, tạo trigger tự động tăng giảm cột sĩ số trong lớp hành chính
- Tạo trigger check số tín chỉ mà khoa cung cấp không được vượt quá 50 tín chỉ
- Tạo trigger cập nhật điểm kết thúc học phần với fDiemKTHP = 0.1*fDiemCC + 0.2*fDiemGK + 0.7*fDiemThi
- Tạo trigger giới hạn số lượng giảng viên nữ của 1 khoa không được vượt quá 20
- Tạo trigger check số lượng môn học mà giảng viên dạy không được vượt quá 10
- Tạo trigger sao cho mỗi khi giảng viên đó dạy thêm một môn học thì tổng số môn học mà giảng viên dạy được tăng lên tương ứng
- Thêm cột iTongSoGV(mặc định = 0) vào bảng tblKhoa.
Tạo trigger sao cho mỗi khi thêm một giảng viên thì tổng số giảng viên được tăng tương ứng với số lượng được nhập vào
Bảng giảng viên với bảng học

*/

-- Tạo trigger check sinh viên không được học lại quá 3 lần trên 1 môn
create view v_svhoclai
as
select tblSinhVien.sMaSV, tblMonHoc.sMaMon, count(tblMonHoc.sMaMon) as [Số lần học lại]
from tblSinhVien
inner join tblHoc
on tblSinhVien.sMaSV = tblHoc.sMaSV
inner join tblMonHoc
on tblHoc.sMaMon = tblMonHoc.sMaMon
group by tblMonHoc.sMaMon, tblSinhVien.sMaSV, sTenMon
having count(tblMonHoc.sMaMon) > 2


create trigger insert_solanhoclai
on tblHoc
for insert, update
as
begin
	if (update (sMaMon) or update (sMaSV))
	begin
		declare @masv varchar(50), @mamon varchar(50)
		select @masv = sMaSV, @mamon = sMaMon from inserted
		if exists (select * from v_svhoclai where sMaSV = @masv and sMaMon = @mamon)
		begin
			print N'SINH VIÊN ĐÃ HỌC LẠI TRÊN 2 LẦN. KHÔNG ĐƯỢC PHÉP THAM GIA MÔN HỌC NÀY NỮA'
			rollback tran
		end
	end
end


-- Thêm cột sĩ số trong bảng tblLopHC, tạo trigger tự động tăng giảm cột sĩ số trong lớp hành chính
alter table tblLopHC
add iSiSo int default 0

create view v_siso
as
select sLopHC, count(sMaSV) as [SiSo]
from tblSinhVien
group by sLopHC

update tblLopHC
set iSiSo = (select SiSo from v_siso where tblLopHC.sMaLop = v_siso.sLopHC)
where tblLopHC.sMaLop in (select sLopHC from v_siso)


alter trigger autoI_siso
on tblSinhVien
for insert
as
begin
	if update(sLopHC)
	begin
		declare @masv varchar(50), @malop varchar(50)
		select @masv = sMaSV, @malop = sLopHC from inserted
		update tblLopHC
		set iSiSo = iSiSo + 1
		where sMaLop = @malop
	end
end


create trigger autoU_siso
on tblSinhVien
for update
as
begin
	if update(sLopHC)
	begin
		declare @malopmoi varchar(50), @malopcu varchar(50)
		select @malopmoi = sLopHC from inserted
		select @malopcu = sLopHC from deleted
		update tblLopHC
		set iSiSo = iSiSo + 1
		where sMaLop = @malopmoi
		update tblLopHC
		set iSiSo = iSiSo - 1
		where sMaLop = @malopcu
	end
end

create trigger autoD_siso
on tblSinhVien
for delete
as
begin
	declare @malop varchar(50)
	select @malop = sLopHC from deleted
	update tblLopHC
	set iSiSo = iSiSo - 1
	where sMaLop = @malop
end

select * from tblLopHC


-- Tạo trigger check số tín chỉ mà khoa cung cấp không được vượt quá 50 tín chỉ
create trigger checkI_sotckhoacc
on tblMonHoc
for insert
as
begin
	declare @mak varchar(50), @tongtc int
	select @mak = sMaKhoa from inserted
	select @tongtc =  (select SUM(iSoTC) from tblMonHoc where sMaKhoa = @mak)
	if(@tongtc <= 50)
	begin
		print N'THÊM THÀNH CÔNG' 
	end
	else
	begin
		print N'SO TC TOI DA LA 50'
		rollback tran
	end
end


insert into tblMonHoc
(sMaMon, sMaKhoa, iSoTC)
values
('m1011', 'k3', 11)


create trigger checkU_sotckhoacc
on tblMonHoc
for update
as
begin
	if (update(iSoTC) or update(sMaKhoa))
	declare @mak varchar(50), @tongtc int
	select @mak = sMaKhoa from inserted
	select @tongtc = (select sum(iSoTC) from tblMonHoc where sMaKhoa = @mak)
	if(@tongtc > 50)
	begin
		print N'SỐ TC KHOA CUNG CẤP TỐI ĐA 50 TC'
		rollback tran
	end
	else
	begin
		print N'THÊM THÀNH CÔNG'
	end
end

-- Tạo trigger cập nhật điểm kết thúc học phần với fDiemKTHP = 0.1*fDiemCC + 0.2*fDiemGK + 0.7*fDiemThi
alter trigger capnhatdiemkthp
on tblHoc
for insert, update
as
begin
	if (update(fDiemCC) or update(fDiemGK) or update(fDiemThi))
	begin
		declare @magv varchar(50), @mamon varchar(50), @masv varchar(50)
		declare @ngaybd datetime, @diemcc float, @diemgk float, @diemthi float
		select @magv = sMaGV, @mamon = sMaMon, @masv = sMaSV,
		@ngaybd = dNgayBatDau, @diemcc = fDiemCC, @diemgk = fDiemGK, @diemthi = fDiemThi from inserted
	
		update tblHoc
		set fDiemKTHP = 0.1*@diemcc + 0.2*@diemgk + 0.7*@diemthi
		where sMaGV = @magv and sMaMon = @mamon and sMaSV = @masv and dNgayBatDau = @ngaybd
	end
end


select * from tblHoc


-- Tạo trigger giới hạn số lượng giảng viên nữ của 1 khoa không được vượt quá 20
create trigger gh_sogvnu
on tblGiangVien
for insert, update
as
begin
	if (update(sMaKhoa) or update(sGioiTinh))
	begin
		declare @mak varchar(50), @solggvnu int
		select @mak = sMaKhoa from inserted
		set @solggvnu = (select count(sMaGV) from tblGiangVien where sMaKhoa = @mak and sGioiTinh = N'Nữ' group by sMaKhoa)
		if(@solggvnu > 20)
		begin
			print N'SỐ LƯỢNG GIẢNG VIÊN NỮ KHÔNG ĐƯỢC VƯỢT QUÁ 20'
			rollback tran
		end
	end
end

-- Tạo trigger check số lượng môn học mà giảng viên dạy không được vượt quá 10
create trigger ghmonhoc
on tblHoc
for insert, update
as
begin
	if (update(sMaGV) or update(sMaMon))
	begin
		declare @magv varchar(50), @slgmon int
		select @magv = sMaGV from inserted
		set @slgmon = (select count(distinct sMaMon) from tblHoc where sMaGV = @magv group by sMaGV)
		if(@slgmon > 10)
		begin
			print N'SỐ LƯỢNG MÔN DẠY CỦA GIẢNG VIÊN KHÔNG ĐƯỢC VƯỢT QUÁ 10'
			rollback tran
		end
	end
end

--Tạo trigger sao cho mỗi khi giảng viên đó dạy thêm một môn học thì tổng số môn học mà giảng viên dạy được tăng lên tương ứng
--Bảng giảng viên với bảng học
alter table tblGiangVien
add iSoMonDay int default 0

update tblGiangVien
set iSoMonDay = (select count(distinct sMaMon) from tblHoc where tblHoc.sMaGV = tblGiangVien.sMaGV group by sMaGV)
where sMaGV in (select sMaGV from tblHoc)

create trigger auto_soluongdaymon
on tblHoc
for insert
as
begin
	declare @magv varchar(50), @solgmonday int
	select @magv = sMaGV from inserted
	set @solgmonday = (select count(distinct sMaMon) from tblHoc where sMaGV = @magv group by sMaGV)
	if(@solgmonday > (select iSoMonDay from tblGiangVien where sMaGV = @magv))
	begin
		update tblGiangVien
		set iSoMonDay += 1
		where sMaGV = @magv
	end
end

create trigger autoU_soluongdaymon
on tblHoc
for update
as
begin
	if update(sMaGV) or update(sMaMon)
	begin
		declare @magvnew varchar(50), @magvold varchar(50), @slgmon1 int, @slgmon2 int
		select @magvnew = sMaGv from inserted
		select @magvold = sMaGV from deleted
		set @slgmon1 = (select count(distinct sMaMon) from tblHoc where sMaGV = @magvnew group by sMaGV)
		set @slgmon2 = (select count(distinct sMaMon) from tblHoc where sMaGv = @magvold group by sMaGV)
		if(@slgmon1 > (select iSoMonDay from tblGiangVien where sMaGV = @magvnew))
		begin
			update tblGiangVien
			set iSoMonDay += 1
			where sMaGV = @magvnew
		end
		if(@slgmon2 < (select iSoMonDay from tblGiangVien where sMaGV = @magvold))
		begin
			update tblGiangVien
			set iSoMonDay -= 1
			where sMaGV = @magvold
		end
	end
end


create trigger autoD_soluongdaymon
on tblHoc
for delete
as
begin
	declare @magv varchar(50)
	select @magv = sMaGV from deleted
	update tblGiangVien
	set iSoMonDay -= 1
	where sMaGV = @magv
end

-- Thêm cột iTongSoGV(mặc định = 0) vào bảng tblKhoa.
-- Tạo trigger sao cho mỗi khi thêm một giảng viên thì tổng số giảng viên được tăng tương ứng với số lượng được nhập vào
alter table tblKhoa
add iTongSoGV int default 0

update tblKhoa
set iTongSoGV = (select count(sMaGV) from tblGiangVien where tblGiangVien.sMaKhoa = tblKhoa.sMaKhoa group by sMaKhoa)
where sMaKhoa in (select sMaKhoa from tblGiangVien)

alter trigger I_auto_sogvkhoa
on tblGiangVien
for insert
as
begin
	declare @mak varchar(50)
	select @mak = sMaKhoa from inserted
	update tblKhoa
	set iTongSoGV += 1
	where sMaKhoa = @mak
end

create trigger U_auto_sogvkhoa
on tblGiangVien
for update
as
begin
	if update(sMaKhoa)
	begin
		declare @maknew varchar(50), @makold varchar(50)
		select @maknew = sMaKhoa from inserted
		select @makold = sMaKhoa from deleted
		update tblKhoa
		set iTongSoGV += 1
		where sMaKhoa = @maknew

		update tblKhoa
		set iTongSoGV -= 1
		where sMaKhoa = @makold
	end
end

create trigger D_auto_sogvkhoa
on tblGiangVien
for delete
as
begin
	declare @mak varchar(50)
	select @mak = sMaKhoa from deleted
	update tblKhoa
	set iTongSoGV -= 1
	where sMaKhoa = @mak
end




-- Tạo tài khoản: create login
-- và phân quyền
-- tạo tài khoản admin
create login admin_hoan
with password = '123',
check_expiration = on

create user admin_hoan
for login admin_hoan
with default_schema = QUANLYGIANGDAY

-- phân toàn quyền cho admin
grant all
on tblGiangVien
to admin_hoan

grant all
on tblHoc
to admin_hoan

grant all
on tblKhoa
to admin_hoan

grant all
on tblLopHC
to admin_hoan

grant all
on tblMonHoc
to admin_hoan

grant all
on tblSinhVien
to admin_hoan

-- tạo tài khoản vinh
--
--
create login vinh
with password = '123',
check_expiration = on

create user vinh
for login vinh
with default_schema = QUANLYGIANGDAY

-- phân quyền thêm, sửa, select trên bảng môn học, bảng học, bảng sinh viên
grant insert, update, select
on tblMonHoc
to vinh

grant insert, update, select
on tblHoc
to vinh

grant insert, update, select
on tblSinhVien
to vinh

-- tạo tài khoản tuan
create login tuan
with password = '123',
check_expiration = on

create user tuan
for login tuan
with default_schema = QUANLYGIANGDAY

-- phân quyền: cấp all cho tài khoản tuan tren bảng giảng viên, bảng lớp hành chính
grant all
on tblGiangVien
to tuan

grant all
on tblLopHC
to tuan

-- TẠO TÀI KHOẢN TRƯỜNG
--
create login truong
with password = '123',
check_expiration = on

create user truong
for login truong
with default_schema = QUANLYGIANGDAY

-- phân quyền cho tk truong: select, delete, insert trên bảng tblKhoa, tblMonHoc
grant select, delete, insert
on tblKhoa
to truong

grant select, delete, insert
on tblMonHoc
to truong

-- tạo tài khoản hưng
create login hung
with password = '123',
check_expiration = on

create user hung
for login hung
with default_schema = QUANLYGIANGDAY

--phân quyền cho tk hung: select, update tren bang tblSinhVien, tblLopHC, tblHoc, tblMonHoc
grant select, update
on tblSinhVien
to hung

grant select, update
on tblLopHC
to hung

grant select, update
on tblHoc
to hung

grant select, update
on tblMonHoc
to hung


-- Thu hồi và cấm quyền
-- Thu hồi quyền delete trên 2 bảng tblGiangVien, tblLopHC của login 'tuan'
revoke delete
on tblGiangVien
to tuan

revoke delete
on tblLopHC
to tuan

-- Cấm update trên bảng tblMonHoc của login hung
deny update
on tblMonHoc
to tuan





-- Phân tán cơ sở dữ liệu
-- Phân tán ngang
--
/*
- Phân tán giới tính trên bảng tblSinhVien. Những sinh viên nam ở trên server1 (Máy thật),
Sinh Viên còn lại nằm ở trên server2 (Máy ảo)
-- Tạo login sử dụng bên máy thật, làm việc trên database GIANG_DAY_MAY1, cấp quyền cho user
-- Tạo linked server
*/

/*
	Thực hiện phân tán ngang bảng tblGiangVien, 
	điều kiện giảng viên có địa chỉ ở Hà Nội thì ở Server 1(Máy thật), 
	giảng viên có địa chỉ khác Hà Nội thì đặt ở bên Server 2(Máy ảo)
*/

/*
-- Thực hiện phân tán dọc
-- Thực hiện phân tán dọc tblThongTin
*/
Create DATABASE GIANG_DAY_MAY1 collate Vietnamese_CI_AS

USE GIANG_DAY_M1;

CREATE TABLE tblSinhVien
(
	sMaSV varchar(50) PRIMARY KEY,
	sTenSV NVARCHAR(50),
	dNgaySinh DATETIME,
	sDiaChi NVARCHAR(50),
	sGioiTinh NVARCHAR(10) check(sGioiTinh = N'Nam')
)

alter table tblSinhVien
add sLopHC varchar(50) references tblLopHC(sMaLop)

create table tblGiangVien
(
	sMaGV varchar(50) primary key,
	sTenGV nvarchar(50),
	sGioiTinh nvarchar(10),
	dNgaySinh datetime,
	sDiaChi nvarchar(50) check(sDiaChi = N'Hà Nội')
);

CREATE TABLE tblLopHC
(
	sMaLop varchar(50) PRIMARY KEY,
	sTenLop VARCHAR(50) unique,
	sMaGV varchar(50) references tblGiangVien(sMaGV)
);

CREATE LOGIN m1
WITH PASSWORD = '123',
CHECK_EXPIRATION = ON

CREATE USER m11
FOR LOGIN m1
WITH DEFAULT_SCHEMA = GIANG_DAY_M1

GRANT ALL
ON tblSinhVien
TO m11

GRANT ALL
ON tblGiangVien
TO m11

GRANT ALL
ON tblLopHC
TO m11
/* 
Tạo thủ tục insert thêm 1 sinh viên. Nếu sinh viên nam thì thêm vào bảng sinh viên 
của bên máy 1 (máy thật) và ngược lại sinh viên nữ thì thêm vào bảng sinh viên của bên máy 2 (máy ảo)
*/

-- Thêm dữ liệu bảng sinh viên
insert into tblSinhVien
(sMaSV, sTenSV, dNgaySinh, sDiaChi, sGioiTinh)
values
('19IT01',N'Nguyễn Mạnh Hùng','2000-4-15', N'Hà Nội',N'Nam'),
('19IT04',N'Đinh Chung Hoàng','2003-08-08', N'Hà Nội', N'Nam'),
('19IT05',N'Nguyễn Hoàng Long','1999-3-6', N'Hà Nội', N'Nam'),
('21IT05',N'dinh quang minh','2000-8-9', N'Hà Nội', N'Nam'),
('21IT06',N'nguyen can gio','2001-8-3', 'Hà Nam', N'Nam');

-- Thêm dữ liệu bảng tblGiangVien
insert into tblGiangVien
(
	sMaGV,
	sTenGV,
	sGioiTinh,
	dNgaySinh,
	sDiaChi
)
VALUES
(
	'gv1',
	N'Nguyễn Thị Tâm',
	N'Nữ',
	'4/5/1987',
	N'Hà Nội'
),
(
	'gv2',
	N'Trịnh Thị Xuân',
	N'Nữ',
	'4/5/1977',
	N'Hà Nội'
),
(
	'gv3',
	N'Mai Thúy Hà',
	N'Nữ',
	'4/5/1967',
	N'Hà Nội'
),
(
	'gv4',
	N'Nguyễn Thu Trang',
	N'Nữ',
	'4/5/1997',
	N'Hà Nội'
),
(
	'gv5',
	N'Trần Đức Sáng',
	N'Nam',
	'4/5/1967',
	N'Hà Nội'
),
(
	'gv6',
	N'Nguyễn Ngân Trâm',
	N'Nữ',
	'4/5/1987',
	N'Hà Nội'
);

-- Thêm dữ liệu bảng tblLopHC
insert into tblLopHC
(
	sMaLop,
	sTenLop,
	sMaGV
)
values
(
	'lp1',
	N'1910A01',
	'gv1'
),
(
	'lp2',
	N'1910A02',
	'gv1'
),
(
	'lp3',
	N'1910A03',
	'gv2'
),
(
	'lp4',
	N'1910A04',
	'gv3'
),
(
	'lp5',
	N'1910A05',
	'gv3'
),
(
	'lp6',
	N'2010A01',
	'gv6'
)


-- Thủ tục thêm sinh viên
CREATE PROC insertSV
@ma varchar(50), @ten nvarchar(50), @date datetime, @dc nvarchar(50), @gt nvarchar(10)
as
begin
	if exists (select * from M2.GIANG_DAY_MAY2.dbo.tblSinhVien where sMaSV = @ma)
	begin
		print N'MÃ SINH VIÊN ĐÃ TỒN TẠI BÊN SERVER 2'
		return
	end
	else
	begin
		if(@gt = N'Nam')
		begin
			insert into tblSinhVien (sMaSV, sTenSv, dNgaySinh, sDiaChi, sGioiTinh)
			values (@ma, @ten, @date, @dc, @gt)
		end
		else
		begin
			insert into M2.GIANG_DAY_MAY2.DBO.tblSinhVien (sMaSV, sTenSv, dNgaySinh, sDiaChi, sGioiTinh)
			values (@ma, @ten, @date, @dc, @gt)
		end
		print N'THÊM DỮ LIỆU THÀNH CÔNG...'
	end
end


EXEC insertSV
@ma = '20IT01', @ten = N'Chu Văn An', @date = '2001-7-8', @dc = N'Từ Sơn-BN', @gt = N'Nữ'


-- Tạo trigger check mã sinh viên khi insert và update
create trigger insert_checkMaSV_M1
on tblSinhVien
for insert
as
begin
	declare @ma varchar(50)
	select @ma = sMaSV from inserted
	if exists (select * from M2.giang_day_may2.dbo.tblSinhVien where sMaSV = @ma)
	begin
		print N'MÃ SINH VIÊN ĐÃ TỒN TẠI'
		rollback tran
	end
end

-- check update
create trigger update_checkMaSV_M1
on tblSinhVien
for update
as
begin
	if update(sMaSV)
	begin
		declare @ma varchar(50)
		select @ma = sMaSV from inserted
		if exists (select * from M2.giang_day_may2.dbo.tblSinhVien where sMaSV = @ma)
		begin
			print N'MÃ SINH VIÊN ĐÃ TỒN TẠI'
			rollback tran
		end
	end
end


--Tạo view Lấy dữ liệu sinh viên trên 2 bảng
create view dataSV
as
select * from M2.GIANG_DAY_MAY2.dbo.tblSinhVien
union
select * from tblSinhVien


-- Lấy danh sách sinh viên có địa chỉ ở Hà Nội
select *
from tblSinhVien
where sDiaChi = N'Hà Nội'
union
select *
from m2.giang_day_may2.dbo.tblSinhVien
where sDiaChi = N'Hà Nội'

-- Tạo View Cho biết những sinh viên khóa 2003
create view v_svnam2003
as
select *
from tblSinhVien
where year(dNgaySinh) = 2003
union
select *
from m2.giang_day_may2.dbo.tblsinhvien
where year(dNgaysinh) = 2003

-- Tạo thủ tục update địa chỉ của sinh viên, với mã sinh viên và địa chỉ là tham số truyền vào
create proc updatediachisv
@ma varchar(50), @dc nvarchar(50)
as
begin
	if exists (select * from dataSV where sMaSV = @ma)
	begin
		if @ma in (select sMaSV from tblSinhVien)
		begin
			update tblSinhVien
			set sDiaChi = @dc
			where sMaSV = @ma
		end
		else
		begin
			update m2.giang_day_may2.dbo.tblSinhVien
			set sDiaChi = @dc
			where sMaSV = @ma
		end
	end
	else
	begin
		print N'KHÔNG TỒN TẠI SINH VIÊN CÓ MÃ' + @ma
		return
	end
end

exec c2_updatediachisv
@ma = '21IT12', @dc = N'Bình Dương'

-- Xử lí giảng viên
-- Thủ tục thêm giảng viên
create proc insert_GV
@magv varchar(50), @ten nvarchar(50), @gt nvarchar(10), @date datetime, @dc nvarchar(50)
as
begin
	if exists (select * from tblGiangVien where sMaGV = @magv)
	begin
		print N'MÃ GV ĐÃ TỒN TẠI'
		return
	end
	else
	begin
		if exists (select * from M2.giang_day_may2.dbo.tblGiangVien where sMaGV = @magv)
		begin
			print N'MÃ ĐÃ TỒN TẠI Ở SERVER KHÁC'
			return
		end
		else
		begin
			if(@dc = N'Hà Nội')
			begin
				insert into tblGiangVien
				values (@magv, @ten, @gt, @date, @dc)
			end
			else
			begin
				insert into m2.giang_day_may2.dbo.tblGiangVien
				values (@magv, @ten, @gt, @date, @dc)
			end
		end
	end
end

exec insert_GV
@magv = 'gv8', @ten = N'Nguyễn Thúy Mùi', @gt = N'Nữ', @date = '1978-9-12', @dc = N'Bắc Giang'

-- Tạo trigger check mã giảng viên
create trigger check_magv
on tblGiangVien
for insert, update
as
begin
	if update(sMaGV)
	begin
		declare @magv varchar(50)
		select @magv = sMaGV from inserted
		if exists (select * from m2.giang_day_may2.dbo.tblGiangVien where sMaGV = @magv)
		begin
			print N'MÃ GV ĐÃ TỒN TẠI'
			rollback tran
		end
	end
end


-- Xử lí lớp hành chính
-- Tạo thủ tục thêm lớp hành chính
create synonym ThongTinLopHC
for m2.giang_day_may2.dbo.tblThongTinLopHC

create proc insert_LopHC
@mal varchar(50), @tenlop nvarchar(50), @magv varchar(50)
as
begin
	if exists (select * from tblLopHC where sMaLop = @mal)
	begin
		print N'LỚP HÀNH CHÍNH ĐÃ TỒN TẠI'
		return
	end
	else
	begin
		insert into tblLopHC (sMaLop, sTenLop, sMaGV)
		values
		(@mal, @tenlop, @magv)
		insert into ThongTinLopHC (sMaLop)
		values(@mal)
	end
end

exec insert_LopHC
@mal = 'lp7', @tenlop = N'2010A02', @magv = 'gv6'

exec insert_LopHC
@mal = 'lp8', @tenlop = N'2010A03', @magv = 'gv4'


-- Truy vấn
-- Tạo triggerr cập nhật sĩ số của tblThongTinLopHC khi sinh viên được thêm vào hoặc bỏ đi
-- Không chạy được
create trigger capnhap_siso
on tblSinhVien
for insert
as
begin
	declare @lophc varchar(50)
	select @lophc = sLopHC from inserted
	update m2.giang_day_may2.dbo.tblThongTinLopHC
	set iSiSo = iSiSo + 1
	where sMaLop = @lophc
end


create trigger update_siso
on tblSinhVien
for update
as
begin
	declare @malnew varchar(50), @malold varchar(50)
	select @malnew = sLopHC from inserted
	select @malold = sLopHC from deleted
	if exists (select * from m2.giang_day_may2.dbo.tblThongTinLopHC where sMaLop = @malnew)
	begin
		update m2.giang_day_may2.dbo.tblThongTinLopHC
		set iSiSo = iSiSo + 1
		where sMaLop = @malnew

		update m2.giang_day_may2.dbo.tblThongTinLopHC
		set iSiSo = iSiSo - 1
		where sMaLop = @malold
	end
	else
	begin
		print N'KHÔNG TỒN TẠI LỚP HC'
		rollback tran
	end
end

insert into tblSinhVien (sMaSV, sLopHC)
values ('20IT03', 'lp6')


-- Phân tán: Truy vấn
-- VIEW
/*
- Tạo view thống kê danh sách sinh viên được quản lý bởi giảng viên X
- Tạo view thống kê giảng viên có tuổi lớn nhất
- 
*/

-- Tạo view thống kê danh sách sinh viên được quản lý bởi giảng viên X
create view v_qlsinhvien
as
select sMaSV, sTenSV
from tblSinhVien, tblLopHC, tblGiangVien
where tblSinhVien.sLopHC = tblLopHC.sMaLop
and tblLopHC.sMaGV = tblGiangVien.sMaGV
and tblGiangVien.sMaGV = 'gv1'

-- Tạo view thống kê giảng viên có tuổi lớn nhất
create view v_gvtuoimax
as
select sMaGV, sTenGV, (datediff(day, dNgaySinh, getdate())/365) as [Tuoi]
from tblGiangVien
union
select sMaGV, sTenGV, datediff(day, dNgaySinh, getdate()) / 365 as [Tuoi]
from m2.giang_day_may2.dbo.tblGiangVien

create view v_tuoilonnhatcuagv
as
select top 1 with ties *
from v_gvtuoimax
order by Tuoi desc

/*
-- Ôn lại
-- VIEW
/*
-	Tạo view tính tổng số môn học đã học của từng sinh viên
-	Tính tuổi trung bình của các giảng viên
-	Cho biết giảng viên có tuổi cao nhất
-	Cho biết tổng số tín chỉ môn học của từng khoa cung cấp
-	Thống kê sinh viên đã từng phải học lại ít nhất 2 lần
*/

--	Tạo view tính tổng số môn học đã học của từng sinh viên
create view tongmon_sv
as
select sTenSV, count(distinct sMaMon) as [Số môn học]
from tblSinhVien, tblHoc
where tblSinhVien.sMaSV = tblHoc.smaSV
group by tblSinhVien.sMaSV, sTenSV

--	Tính tuổi trung bình của các giảng viên
create view v_tuoitb
as
select AVG(datediff(day, dNgaySinh, getdate())/365) as [Tuổi trung bình]
from tblGiangVien

--	Cho biết giảng viên có tuổi cao nhất
create view v_tuoicaonhat
as
select top 1 with ties sTenGV, datediff(day, dNgaySinh, getdate())/365 as [Tuổi]
from tblGiangVien
order by datediff(day, dNgaySinh, getdate())/365 desc

--	Cho biết tổng số tín chỉ môn học của từng khoa cung cấp
create view tongtc_khoacc
as
select sTenKhoa, sum(iSoTC) as [Số tc cc]
from tblKhoa, tblMonHoc
where tblKhoa.sMaKhoa = tblMonHoc.sMaKhoa
group by tblKhoa.sMaKhoa, sTenKhoa

--	Thống kê sinh viên đã từng phải học lại ít nhất 2 lần
create view sv_hoclaiitnhat2lan
as
select sMaSV, sMaMon, count(sMaMon) as [Số lần học lại]
from tblHoc
group by sMaSV, sMaMon
having count(sMaMon) >= 2

-- PROCEDURE
/*
-	Sửa tên lớp hc của sinh viên để chuyên sang lớp khác thông qua mã sinh viên, mã lớp được truyền vào
-	Cho biết danh sách môn (tên môn) của sinh viên đã học, với mã sinh viên là tham số truyền vào
-	Tạo thủ tục thống kê danh sách sinh viên đã từng phải học lại ít nhất 2 lần theo môn học nào đó, 
với mã môn là tham số truyền vào
-	Hiện sinh viên có số tín chỉ trong khoảng x-y, x và y là tham số truyền vào
-	Tạo thủ tục tính số tiền học phải đóng của sinh viên, với mã sinh viên là tham số truyền vào, 
số lượng tín chỉ tích lũy của sinh viên đó là trả về. Biết 1 TC là 378.000
*/

--	Sửa tên lớp hc của sinh viên để chuyên sang lớp khác thông qua mã sinh viên, mã lớp được truyền vào
create proc pro_chuyenlop
@masv varchar(50), @malop varchar(50)
as
begin
	if exists (select * from tblSinhVien where sMaSV = @masv)
	begin
		if exists (select * from tblLopHC where sMaLop = @malop)
		begin
			update tblSinhVien
			set sLopHC = @malop
			where sMaSV = @masv
		end
		else
		begin
			print N'LỚP KHÔNG TỒN TẠI'
			return
		end
	end
	else
	begin
		print N'KHÔNG TỒN TẠI SINH VIÊN'
		return
	end
end

exec pro_chuyenlop
@masv = '19IT02', @malop = 'lp2'

--	Cho biết danh sách môn (tên môn) của sinh viên đã học, với mã sinh viên là tham số truyền vào
create proc svhocmonhoc
@masv varchar(50)
as
begin
	if exists (select * from tblSinhVien where sMaSV = @masv)
	begin
		select distinct tblMonHoc.sMaMon, sTenMon
		from tblHoc, tblMonHoc
		where tblHoc.sMaMon = tblMonHoc.sMaMon
		and sMaSV = @masv
	end
	else
	begin
		print N'KHÔNG TỒN TẠI SINH VIÊN'
		return
	end
end

exec svhocmonhoc
@masv = '21IT05'

--	Tạo thủ tục thống kê danh sách sinh viên đã từng phải học lại ít nhất 2 lần theo môn học nào đó, 
--với mã môn là tham số truyền vào
create proc hoclaiitnhat2lan
@mamon varchar(50)
as
begin
	if exists (select * from tblMonHoc where smaMon = @mamon)
	begin
		select tblSinhVien.sMaSV, sTenSV, count(sMaMon) as [Số lần học]
		from tblSinhVien, tblHoc
		where sMaMon = @mamon
		and tblSinhVien.sMaSV = tblHoc.sMaSV
		group by tblSinhVien.sMaSV, sTenSV, sMaMon
		having count(sMaMon) >= 2
	end
	else
	begin
		print N'KHÔNG TỒN TẠI MÔN HỌC'
		return
	end
end

exec hoclaiitnhat2lan
@mamon = 'm6'

--	Hiện sinh viên có số tín chỉ trong khoảng x-y, x và y là tham số truyền vào
create view loc1lan
as
select distinct sMaMon, sMaSV
from tblHoc


create proc hiensotcxy
@x int, @y int
as
begin
	select tblSinhVien.sMaSV, sTenSV, sum(iSoTC)
	from tblSinhVien, loc1lan, tblMonHoc
	where tblSinhVien.sMaSV = loc1lan.sMaSV
	and loc1lan.sMaMon = tblMonHoc.sMaMon
	group by tblSinhVien.sMaSV, sTenSV
	having sum(iSoTC) between @x and @y
end

exec hiensotcxy
@x = 7, @y = 14

*/

/*
Kiểm tra
*/
--CAu 1
create login hoan
with password = '123',
check_expiration = on

create user hoan
for login hoan
with default_schema = QUANLYGIANGDAY

grant select
on tblSinhVien(sMaSV, sTenSV, sLopHC)
to hoan

create role sl_sinhvien

grant all
on tblSinhVien
to sl_sinhvien


exec sp_addrolemember 'sl_sinhvien', 'hoan'

revoke select
on tblSinhVien(dNgaySinh, sDiaChi, sGioiTinh, sLopHC, sSDT)
from hoan

select * from tblSinhVien
-- Cau 2
create view check_svhoclai
as
select sMaSV, sMaMon, count(sMaMon) as[SoLanHoc]
from tblHoc
group by sMaSV, sMaMon
having count(sMaMon) > 2

create trigger I_hockhongqua3lan
on tblHoc
for insert, update
as
begin
	if (update(sMaMon) or update(sMaSV))
	begin
		declare @masv varchar(50), @magv varchar(50), @mamon varchar(50), @ngaybatdau varchar(50)
		select @masv = sMaSV, @magv = sMaGV, @mamon = sMaMon, @ngaybatdau = dNgayBatDau from inserted
		if exists (select * from check_svhoclai  where sMaSV = @masv and sMaMon = @mamon)
		begin
			print N'SINH VIÊN ĐÃ HỌC LẠI MÔN HỌC TRÊN 2 LẦN, KHÔNG ĐƯỢC HỌC THÊM NỮA'
			rollback tran
		end
	end
end

-- CÂu 3
-- viết thủ tục có tham số truyền vào(gioi tinh), có tính toán(tính số lớp đang quản lý), có sắp xếp(Tuoi), dữ liệu được lấy trên 2 trạm
--viết thủ tục có tham số truyền vào(magv), có tính toán(tính si so 1 lop), có sắp xếp(theo so lop), dữ liệu được lấy trên 2 trạm
create proc getdatasoluongsv
@magv varchar(50)
as
begin
	select tblLopHC.sMaLop, count(sMaSV) as [SoSV]
	from tblSinhVien, tblLopHC
	where tblSinhVien.sLopHC = tblLopHC.sMaLop
	group by tblLopHC.sMaLop
	union
	select sMaLop, count(sMaSV) as [SoSV]
	from m2.giang_day_may2.dbo.tblSinhVien
	group by sMaLop
	order by count(sMaSV) desc
end


select sLopHC, count(sMaSV)
from tblSinhVien
group by sLopHC


select sMaLop
from m2.giang_day_may2.dbo.tblThongTinLopHC


alter proc dem
@gt nvarchar(50)
as
begin
	select sMaGV, sTenGV, datediff(day, dNgaySinh, getdate())/365 as[Tuoi], sDiaChi
	from tblGiangVien
	where sGioiTinh = @gt
	union
	select sMaGV, sTenGV, datediff(day, dNgaySinh, getdate())/365 as[Tuoi], sDiaChi
	from m2.giang_day_may2.dbo.tblGiangVien
	where sGioiTinh = @gt
	order by 3 desc
end


exec dem
@gt = 'Nam'

select * from tblGiangVien



select * from tblSinhVien
revoke all
on tblSinhVien
to sl_sinhvien





/*
end
*/
-- Tạo store proc cho bang giang vien
create proc selectwhere_tblGiangVien
@magv varchar(50)
as
select *
from tblGiangVien
where sMaGV = @magv

exec selectwhere_tblGiangVien
@magv = 'gv10'

--Tao store pro cho bang mon hoc
create proc selectwhere_tblMonHoc
@mamon varchar(50)
as
select *
from tblMonHoc
where sMaMon = @mamon

exec selectwhere_tblMonHoc
'm1'


-- Tao store pro cho bang sinh vien
create proc selectwhere_tblSinhVien
@masv varchar(50)
as
select *
from tblSinhVien
where sMaSV = @masv



-- Tạo store proc cho bảng tblHoc
Create proc select_tblHoc
as
select * from tblHoc

exec select_tblHoc

create proc selectwhere_tblHoc
@magv varchar(50), @mamon varchar(50), @masv varchar(50), @ngaybd datetime
as
select * from tblHoc
where sMaGV = @magv and sMaMon = @mamon and sMaSV = @masv and dNgayBatDau = @ngaybd


exec selectwhere_tblHoc
@magv = 'gv10', @mamon = 'm1', @masv = '20IT04', @ngaybd = '2021-03-20'

select * from tblHoc
where sMaGV = 'gv10' and sMaMon = 'm1' and sMaSV = '20IT04' and dNgayBatDau = '2021-03-20'

-- insert
create proc insert_tblHoc
@magv varchar(50),
@mamon varchar(50),
@masv varchar(50),
@ngaybd datetime,
@diemcc float,
@diemgk float,
@diemthi float,
@diemkthp float
as
insert into tblHoc values(@magv, @mamon, @masv, @ngaybd, @diemcc, @diemgk, @diemthi, @diemkthp)

-- delete
create proc delete_tblHoc
@magv varchar(50), @mamon varchar(50), @masv varchar(50), @ngaybd datetime
as
delete from tblHoc
where sMaGV = @magv and sMaMon = @mamon and sMaSV = @masv and dNgayBatDau = @ngaybd

exec delete_tblHoc
'gv1', 'm1', '19IT03', '2020-03-30'

select * from tblHoc

--update 
create proc update_tblHoc
@magv varchar(50), @mamon varchar(50), @masv varchar(50), @ngaybd datetime, @diemcc float, @diemgk float, @diemthi float, @diemkthp float
as
update tblHoc
set fDiemCC = @diemcc, fDiemGK = @diemgk, fDiemThi = @diemthi, fDiemKTHP = @diemkthp
where sMaGV = @magv and sMaMon = @mamon and sMaSV = @masv and dNgayBatDau = @ngaybd

exec update_tblHoc
'gv1', 'm1', '19IT04', '2020-03-30', 10, 10, 10, 10











--- Create proc 
--
--
--


-- tạo proc cho sinh viên
alter proc select_sinhvien
as
begin
	select * from tblSinhVien
end

alter table tblSinhVien
add sCMND varchar(50)




alter proc insert_sinhvien
@masv varchar(50), @tensv nvarchar(50), @ngaysinh datetime, @diachi nvarchar(50), @gioitinh nvarchar(50), @lophc varchar(50), @sdt varchar(50),@cmnd varchar(50)
as
begin
	insert into tblSinhVien
	values(@masv, @tensv, @ngaysinh, @diachi, @gioitinh, @lophc, @sdt,@cmnd)
end

exec insert_sinhvien 'it21','vinh','01-01-2002','ha  noi','nam','lp11','4564654646'


create proc delete_sinhvien
@masv varchar(50)
as
begin
	delete from tblHoc
	where sMaSV = @masv

	delete from tblSinhVien
	where sMaSV = @masv
end

exec delete_sinhvien @masv = '19IT01'

select * from tblLopHC

exec select_lophc

select * from tblHoc where sMaSV = '19IT01'

alter proc update_sinhvien
@masv varchar(50), @tensv nvarchar(50), @ngaysinh datetime, @diachi nvarchar(50), @gioitinh nvarchar(50), @lophc varchar(50), @sdt varchar(50),@cmnd varchar(50)
as
begin
	update tblSinhVien
	set sTenSV = @tensv, dNgaySinh = @ngaysinh, sDiaChi = @diachi, sGioiTinh = @gioitinh, sLopHC = @lophc, sSDT = @sdt ,sCMND =@cmnd
	where sMaSV = @masv
end

alter proc search_sinhvien
@keysearch varchar(100)
as
begin
	select * from tblSinhVien
	where sMaSV like '%' + @keysearch + '%'
	or sTenSV like '%' + @keysearch + '%'
end

select * from tblSinhVien

exec search_sinhvien @masv = 'hoa', @tensv = 'hoa'

select * from tblHoc

create proc GetDSSV_LopHC
@malop varchar(50)
as
select * from tblSinhVien
where sLopHC = @malop

create proc searchSV_LopHC
@malop varchar(50), @key varchar(100)
as
begin
	if(@key is NULL)
	begin
		select * from tblSinhVien
		where sLopHC = @malop
	end
	else
	begin
		select * from tblSinhVien
		where sLopHC = @malop
		and (sMaSV like '%' + @key + '%' or sTenSV like '%' + @key + '%')	
	end
end


exec searchSV_LopHC 'lp1', null
select * from tblSinhVien where sLopHC = 'lp1'


create proc check_masv
@masv varchar(50)
as
begin
	select * from tblSinhVien where sMaSV = @masv
end

exec check_masv @masv


-- CREATE PROC CHO LOPMON
alter proc select_LopMon
as
select hoc.sMaSV, sTenSV, hoc.sMaMon, sTenMon, hoc.sMaGV, sTenGV, sMaDonViHocVu, fDiemCC, fDiemGK, fDiemThi
from tblHoc as hoc
inner join tblSinhVien as sv
on hoc.sMaSV = sv.sMaSV
inner join tblMonHoc as mon
on hoc.sMaMon = mon.sMaMon
inner join tblGiangVien as gv
on hoc.sMaGV = gv.sMaGV

exec select_LopMon


alter proc selectSV_lopmon
@mamon varchar(50), @magv varchar(50), @donvihocvu varchar(50)
as
begin
	select hoc.sMaSV, sTenSV, hoc.sMaMon, sTenMon, hoc.sMaGV, sTenGV, sMaDonViHocVu, fDiemCC, fDiemGK, fDiemThi, fDiemKTHP
	from tblHoc as hoc, tblSinhVien as sv, tblMonHoc as mon, tblGiangVien as gv
	where hoc.sMaSV = sv.sMaSV
	and hoc.sMaMon = mon.sMaMon
	and hoc.sMaGV = gv.sMaGV
	and hoc.sMaMon = @mamon
	and hoc.sMaGV = @magv
	and sMaDonViHocVu = @donvihocvu
end

exec selectSV_lopmon 'm1', 'gv1' , '1-2020:2021'

select * from tblDonViHocVu
select * from tblHoc


create proc Select_SinhVien_Hoc
as
begin
	select hoc.sMaSV, sTenSV, fDiemCC, fDiemGK, fDiemThi
	from tblHoc as hoc, tblSinhVien as sv
	where hoc.sMaSV = sv.sMaSV
end

exec selectSV_lopmon @mamon = 'm3' , @magv = 'gv2'

alter proc Update_LopMon
@masv varchar(50), @mamon varchar(50), @magv varchar(50),
@dvhv varchar(50), @diemcc float, @diemgk float, @diemthi float, @diemKTHP float
as
begin
	update tblHoc
	set fDiemCC = @diemcc,
	fDiemGK = @diemgk,
	fDiemThi = @diemthi,
	fDiemKTHP = @diemKTHP
	where sMaSV = @masv
	and sMaMon = @mamon
	and sMaGV = @magv
	and sMaDonViHocVu = @dvhv
end

exec Update_LopMon @masv , @mamon , @magv , @dvhv , @diemcc , @diemgk , @diemthi

select * from tblHoc
-- CREATE PROC MON HOC
create proc select_Mon_hoc
as
select distinct mon.sMaMon, sMaKhoa, sTenMon, iSoTC
from tblMonHoc as mon
inner join tblHoc as hoc
on mon.sMaMon = hoc.sMaMon

-- CREATE PROC CHO GIANG VIEN
create proc select_giangvien
as
select * from tblGiangVien

create proc select_giangvien_khoa
as
select gv.sMaGV, sTenGV, sGioiTinh, dNgaySinh, gv.sMaKhoa, sTenKhoa
from tblGiangVien as gv
inner join tblKhoa as khoa
on gv.sMaKhoa = khoa.sMaKhoa

exec select_giangvien_khoa


create proc select_GiangVien_hoc
@mamon varchar(50)
as
begin
	select distinct gv.sMaGV, sTenGV, sGioiTinh, dNgaySinh, sMaKhoa
	from tblGiangVien as gv
	inner join tblHoc as hoc
	on gv.sMaGV = hoc.sMaGV
	where sMaMon = @mamon
end


exec select_GiangVien_hoc @mamon


create proc insert_giangvien
@magv varchar(50), @ten nvarchar(50), @gt nvarchar(50), @ngaysinh datetime, @makhoa varchar(50)
as
begin
	insert into tblGiangVien
	values (@magv, @ten, @gt, @ngaysinh, @makhoa)
end

exec insert_giangvien @magv , @ten , @gt , @ngaysinh , @makhoa


create proc selectwhere_giangvien
@ma varchar(50)
as
begin
	select * from tblGiangVien
	where sMaGV = @ma
end

create proc delete_giangvien
@ma varchar(50)
as
begin
	delete from tblGiangVien
	where sMaGV = @ma
end

create proc update_giangvien
@ma varchar(50), @ten nvarchar(50), @gt nvarchar(50), @ngaysinh datetime, @makhoa varchar(50)
as
begin
	update tblGiangVien
	set sTenGV = @ten,
	sGioiTinh = @gt,
	dNgaySinh = @ngaysinh,
	sMaKhoa = @makhoa
	where sMaGV = @ma
end

create proc search_giangvien
@key nvarchar(50)
as
begin
	select gv.sMaGV, sTenGV, sGioiTinh, dNgaySinh, gv.sMaKhoa, sTenKhoa
	from tblGiangVien as gv
	inner join tblKhoa as khoa
	on gv.sMaKhoa = khoa.sMaKhoa
	where gv.sMaGV like '%' + @key + '%'
	or sTenGV like '%' + @key + '%'
end

exec search_giangvien 'gv'

select * from tblGiangVien

create proc GetGiangVien_Khoa
@mak varchar(50)
as
select * from tblGiangVien
where sMaKhoa = @mak

exec GetGiangVien_Khoa 'k1'

create proc CheckGV_Hoc
@magv varchar(50)
as
select * from tblHoc
where sMaGV = @magv

exec CheckGV_Hoc @magv
-- CREATE PROC LOPHC
create proc select_lophc
as
select * from tblLopHC

create proc select_lopHC_Khoa_GV
@mak varchar(50), @magv varchar(50)
as
select * from tblLopHC
where sMaKhoa = @mak and sMaGV = @magv;

exec select_lopHC_Khoa_GV 'k1', 'gv1'
select * from tblLopHC


create proc lophc_siso
@malop varchar(50)
as
select count(sMaSV) as iSiSo
from tblSinhVien
where sLopHC = @malop
group by sLopHC

exec lophc_siso 'lp1'

create proc search_lophc
@malop varchar(50), @key varchar(100)
as
select 

-- Create proc tai khoan
create proc selectwhere_taikhoan
@username varchar(50), @password varchar(50)
as
select * from tblTaiKhoan
where sUsername = @username
and sPassword = @password

exec selectwhere_taikhoan 'admin', '1'


-- CREATE PROC CHO DON VI HOC VU
create proc select_donvihocvu
as
select * from tblDonViHocVu


create proc select_dvhocvu_hoc
@mamon varchar(50), @magv varchar(50)
as
select distinct dvhv.sMaDonViHocVu, iNamHoc, iKyHoc
from tblDonViHocVu as dvhv
inner join tblHoc as hoc
on dvhv.sMaDonViHocVu = hoc.sMaDonViHocVu
where sMaMon = @mamon
and sMaGV = @magv

exec select_dvhocvu_hoc 'm1', 'gv1'

select * from tblHoc

exec selectSV_lopmon null, null, null


-- create proc cho khoa
alter proc select_khoa
as
select * from tblKhoa

update tblHoc
set fDiemKTHP = fDiemCC * 0.1 + fDiemGK * 0.2 + fDiemThi * 0.7

select * from tblHoc


-- create proc Tài khoản

create proc update_taikhoan
@username varchar(50), @password varchar(50)
as
begin
	update tblTaiKhoan
	set sPassword = @password
	where sUsername = @username
end	


-- create proc crystalreport
-- cho bảng điểm
create proc thongtin_sv
@masv varchar(50)
as
begin
	select sv.sMaSV 
	from tblSinhVien as sv, tblLopHC as lop
	where sv.sMaSV = lop.sMaLop
end



alter proc baocao_bangdiem
as
begin
	select sv.sMaSV, sv.sTenSV, sv.dNgaySinh, sv.sGioiTinh, sv.sSDT, lop.sMaLop, lop.sTenLop, mon.sMaMon, mon.sTenMon, mon.iSoTC, gv.sMaGV, gv.sTenGV, hoc.fDiemCC, hoc.fDiemGK, fDiemThi, fDiemKTHP
	from tblSinhVien as sv, tblLopHC as lop, tblHoc as hoc, tblMonHoc as mon, tblGiangVien as gv
	where sv.sMaSV = hoc.sMaSV
	and hoc.sMaMon = mon.sMaMon
	and hoc.sMaGV = gv.sMaGV
	and sv.sLopHC = lop.sMaLop
end

create proc thongkesearch_sinhvien
select sv.sMaSV, sv.sTenSV, sv.dNgaySinh, sv.sGioiTinh, sv.sSDT, lop.sMaLop, lop.sTenLop, mon.sMaMon, mon.sTenMon, mon.iSoTC, gv.sMaGV, gv.sTenGV, hoc.fDiemCC, hoc.fDiemGK, fDiemThi, fDiemKTHP
	from tblSinhVien as sv, tblLopHC as lop, tblHoc as hoc, tblMonHoc as mon, tblGiangVien as gv
	where sv.sMaSV = hoc.sMaSV
	and hoc.sMaMon = mon.sMaMon
	and hoc.sMaGV = gv.sMaGV
	and sv.sLopHC = lop.sMaLop
	group by smASV,sTenSV,dNgaySinh,sGioiTinh,sSDT,sMaLop,sTenMon,sMaMon
	having count
create proc thongke
select sv.sMaSV,sv.sTenSV ,mon.sMaMon,mon.sTenMon
from tblSinhVien as sv ,tblHoc as hoc , tblMonHoc as mon 
where sv.sMaSV =hoc.sMaSV
and hoc.sMaMon=mon.sMaMon
group by sv.sMaSV,sv.sTenSV ,mon.sMaMon,mon.sTenMon
having count (mon.sMaMon)>3


select * from tblHoc where sMaSV = '20IT04'

select * from tblMonHoc

exec baocao_bangdiem '19IT03'
select * from tblSinhVien
 
create proc baocao_bangdiem_lopmon
as
begin
	select hoc.sMaMon, sTenMon, hoc.sMaGV, sTenGV, dvhv.sMaDonViHocVu, hoc.sMaSV, sTenSV, fDiemCC, fDiemGK, fDiemThi, fDiemKTHP
	from tblHoc as hoc, tblSinhVien as sv, tblMonHoc as mon, tblGiangVien as gv, tblDonViHocVu as dvhv
	where hoc.sMaSV = sv.sMaSV
	and hoc.sMaMon = mon.sMaMon
	and hoc.sMaGV = gv.sMaGV
	and hoc.sMaDonViHocVu = dvhv.sMaDonViHocVu
end


create proc baocao_lophc
as
begin
	select lop.sMaLop, lop.sTenLop, gv.sMaGV, gv.sTenGV, sv.sMaSV, sv.sTenSV, sv.dNgaySinh, sv.sDiaChi, sv.sGioiTinh, sSDT
	from tblLopHC as lop, tblGiangVien as gv, tblSinhVien as sv
	where lop.sMaGV = gv.sMaGV
	and lop.sMaLop = sv.sLopHC
end

create proc thongke
as begin 
select tblSinhVien.*
from tblSinhVien
