﻿CREATE DATABASE QuanLyBuffet
GO

USE QuanLyBuffet	
GO

-- Food
-- Table
-- FoodCategory 
-- Account
-- Bill
-- BillInfo

CREATE TABLE TableFood
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Bàn chưa có tên',
	status NVARCHAR(100) NOT NULL DEFAULT N'Trống' -- Trống || Có người
)
GO

CREATE TABLE Account
(
	UserName NVARCHAR(100) NOT NULL PRIMARY KEY,
	DisplayName NVARCHAR(100) NOT NULL DEFAULT N'CaptainzOverkill',
	PassWord NVARCHAR(1000) NOT NULL DEFAULT 0,
	Type INT NOT NULL DEFAULT 0-- 1: admin && 0: staff
)
GO

CREATE TABLE FoodCategory
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên'
)
GO	

CREATE TABLE Food
(
	id INT IDENTITY PRIMARY KEY,
	name NVARCHAR(100) NOT NULL DEFAULT N'Chưa đặt tên',
	idCategory INT NOT NULL,
	price FLOAT NOT NULL DEFAULT 0

	FOREIGN KEY (idCategory) REFERENCES dbo.FoodCategory(id)
)
GO

CREATE TABLE Bill
(
	id INT IDENTITY PRIMARY KEY,
	DateCheckIn DATE NOT NULL DEFAULT GETDATE(),
	DateCheckOut DATE,
	idTable INT NOT NULL,
	status INT NOT NULL DEFAULT 0 -- 1: đã thanh toán && 0: chưa thanh toán

	FOREIGN KEY (idTable) REFERENCES dbo.TableFood (id)
)
GO

CREATE TABLE BillInfo
(
	id INT IDENTITY PRIMARY KEY,
	idBill INT NOT NULL,
	idFood INT NOT NULL,
	count INT NOT NULL DEFAULT 0

	FOREIGN KEY (idBill) REFERENCES dbo.Bill (id),
	FOREIGN KEY (idFood) REFERENCES dbo.Food (id)
)
GO

INSERT INTO	dbo.Account
(
    UserName,
    DisplayName,
    PassWord,
    Type
)
VALUES
(   N'Manager', -- UserName - nvarchar(100)
    N'Manager', -- DisplayName - nvarchar(100)
    N'1', -- PassWord - nvarchar(1000)
    1    -- Type - int
    )
INSERT INTO	dbo.Account
(
    UserName,
    DisplayName,
    PassWord,
    Type
)
VALUES
(   N'Staff', -- UserName - nvarchar(100)
    N'Staff', -- DisplayName - nvarchar(100)
    N'1', -- PassWord - nvarchar(1000)
    0    -- Type - int
)
GO	

CREATE PROC USP_Login
@userName NVARCHAR(100), @passWord NVARCHAR(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE	UserName = @userName AND PassWord = @passWord
END
GO

DECLARE @i INT = 0
WHILE @i <= 10
BEGIN
	INSERT dbo.TableFood (name)
	VALUES
	(   
		N'Bàn ' + CAST(@i AS NVARCHAR(100)) -- name - nvarchar(100)
	)
END

SELECT * FROM dbo.TableFood
DELETE	FROM	dbo.TableFood