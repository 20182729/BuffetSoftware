﻿CREATE DATABASE QuanLyBuffet
GO

USE BuffetManagement	
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

--Thêm bàn
DECLARE @i INT = 0
WHILE @i <= 10
BEGIN
	INSERT dbo.TableFood (name)
	VALUES
	(   
		N'Bàn ' + CAST(@i AS NVARCHAR(100)) -- name - nvarchar(100)
	)
	SET @i = @i + 1
END
GO 

CREATE PROC USP_GetTableList
AS SELECT * FROM dbo.TableFood
GO

UPDATE dbo.TableFood SET status = N'Có người' WHERE id = 9

EXEC dbo.USP_GetTableList
GO	

-- Thêm category
INSERT dbo.FoodCategory
	(name)
VALUES
	(N'Combo Buffet' -- name - nvarchar(100)
	)
INSERT dbo.FoodCategory
	(name)
VALUES
	(N'Đồ ăn thêm')
INSERT dbo.FoodCategory
	(name)
VALUES
	(N'Nước giải khát')

-- Thêm món ăn
INSERT dbo.Food
(
    name, idCategory, price
)
VALUES
(   
	N'Buffet người lớn chiều 99k', -- name - nvarchar(100)
    1,   -- idCategory - int
    99000  -- price - float
)
INSERT dbo.Food
(
    name, idCategory, price
)
VALUES
(   
	N'Buffet trẻ em chiều 69k', -- name - nvarchar(100)
    1,   -- idCategory - int
    69000  -- price - float
)
INSERT dbo.Food
(
    name, idCategory, price
)
VALUES
(   
	N'Buffet người lớn tối 129k', -- name - nvarchar(100)
    1,   -- idCategory - int
    129000  -- price - float
)
INSERT dbo.Food
(
    name, idCategory, price
)
VALUES
(   
	N'Buffet trẻ em tối 99k', -- name - nvarchar(100)
    1,   -- idCategory - int
    99000  -- price - float
)
INSERT dbo.Food
(
    name, idCategory, price
)
VALUES
(   
	N'Buffet coca 29k', -- name - nvarchar(100)
    1,   -- idCategory - int
    29000  -- price - float
)
INSERT dbo.Food
(
    name, idCategory, price
)
VALUES
(   
	N'Takoyaki',2, 25000
)
INSERT dbo.Food
(
    name, idCategory, price
)
VALUES
(   
	N'Gà rán',2, 36000
)
INSERT dbo.Food
(
    name, idCategory, price
)
VALUES
(   
	N'Chân gà xả tắc',2, 30000
)
INSERT dbo.Food
(
    name, idCategory, price
)
VALUES
(   
	N'Tokbokki lắc phô mai',2, 30000
)
INSERT dbo.Food
(
    name, idCategory, price
)
VALUES
(   
	N'Gà lắc phô mai',2, 30000
)
INSERT dbo.Food
(
    name, idCategory, price
)
VALUES
(   
	N'Trà quất nha đam',3, 15000
)
INSERT dbo.Food
(
    name, idCategory, price
)
VALUES
(   
	N'Trà đào cam sả',3, 20000
)
INSERT dbo.Food
(
    name, idCategory, price
)
VALUES
(   
	N'Bia lon',3, 30000
)
INSERT dbo.Food
(
    name, idCategory, price
)
VALUES
(   
	N'Trà chanh',3, 15000
)

--Thêm bill
INSERT dbo.Bill
(
    DateCheckIn,
    DateCheckOut,
    idTable,
    status
)
VALUES
(   GETDATE(), -- DateCheckIn - date
    NULL, -- DateCheckOut - date
    1,         -- idTable - int
    0          -- status - int
)
INSERT dbo.Bill
(
    DateCheckIn,
    DateCheckOut,
    idTable,
    status
)
VALUES
(   GETDATE(), -- DateCheckIn - date
    NULL, -- DateCheckOut - date
    2,         -- idTable - int
    0          -- status - int
)
INSERT dbo.Bill
(
    DateCheckIn,
    DateCheckOut,
    idTable,
    status
)
VALUES
(   GETDATE(), -- DateCheckIn - date
    GETDATE(), -- DateCheckOut - date
    3,         -- idTable - int
    1          -- status - int
)

--Thêm billinfo
INSERT dbo.BillInfo
(
    idBill,
    idFood,
    count
)
VALUES
(   1, -- idBill - int
    1, -- idFood - int
    2  -- count - int
)
INSERT dbo.BillInfo
(
    idBill,
    idFood,
    count
)
VALUES
(   1, -- idBill - int
    3, -- idFood - int
    4  -- count - int
)
INSERT dbo.BillInfo
(
    idBill,
    idFood,
    count
)
VALUES
(   1, -- idBill - int
    5, -- idFood - int
    1  -- count - int
)
INSERT dbo.BillInfo
(
    idBill,
    idFood,
    count
)
VALUES
(   2, -- idBill - int
    1, -- idFood - int
    6  -- count - int
)
INSERT dbo.BillInfo
(
    idBill,
    idFood,
    count
)
VALUES
(   2, -- idBill - int
    6, -- idFood - int
    2  -- count - int
)
INSERT dbo.BillInfo
(
    idBill,
    idFood,
    count
)
VALUES
(   3, -- idBill - int
    5, -- idFood - int
    2  -- count - int
)
INSERT dbo.BillInfo
(
    idBill,
    idFood,
    count
)
VALUES
(   3, -- idBill - int
    1, -- idFood - int
    2  -- count - int
)
INSERT dbo.BillInfo
(
    idBill,
    idFood,
    count
)
VALUES
(   3, -- idBill - int
    10, -- idFood - int
    1  -- count - int
)
GO	

CREATE PROC USP_InsertBill
@idTable INT
AS
BEGIN
    INSERT dbo.Bill
    (
        DateCheckIn,
        DateCheckOut,
        idTable,
        status,
		discount
    )
    VALUES
    (   GETDATE(), -- DateCheckIn - date
        NULL, -- DateCheckOut - date
        @idTable,         -- idTable - int
        0,          -- status - int
		0
	)
END
GO

CREATE PROC USP_InsertBillInfo
@idBill INT, @idFood INT, @count INT
AS
BEGIN
	
	DECLARE @isExitsBillInfo INT
	DECLARE @foodCount INT = 1

	SELECT @isExitsBillInfo = b.id, @foodCount = b.count FROM dbo.BillInfo AS b WHERE idBill = @idBill AND idFood = @idFood

	IF(@isExitsBillInfo > 0)
	BEGIN
		DECLARE @newCount INT = @foodCount + @count
		IF(@newCount > 0)
			UPDATE dbo.BillInfo SET	count = @foodCount + @count WHERE idFood = @idFood
		ELSE	
			DELETE dbo.BillInfo WHERE idBill = @idBill AND idFood = @idFood 
			
	END
	ELSE
	BEGIN
	    INSERT dbo.BillInfo
		(
			idBill,
			idFood,
			count
		)
		VALUES
		(   
			@idBill, -- idBill - int
			@idFood, -- idFood - int
			@count  -- count - int
		)
	END

END
GO

GO	

CREATE TRIGGER UTG_UpdateBillInfo
ON dbo.BillInfo FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @idBill INT

	SELECT @idBill = idBill FROM Inserted

	DECLARE @idTable INT

	SELECT @idTable = idTable FROM dbo.Bill WHERE id = @idBill AND status = 0

	DECLARE @count INT
	SELECT @count = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idBill

	IF(@count > 0)
		UPDATE dbo.TableFood SET status = N'Có người' WHERE id = @idTable
	ELSE
		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable

END
GO	

CREATE TRIGGER UTG_UpdateBill
ON dbo.Bill FOR UPDATE
AS
BEGIN
	DECLARE @idBill INT

	SELECT @idBill = id FROM Inserted

	DECLARE @idTable INT

	SELECT @idTable = idTable FROM dbo.Bill WHERE id = @idBill

	DECLARE @count INT = 0

	SELECT @count = COUNT(*) FROM dbo.Bill WHERE idTable = @idTable AND status = 0

	IF(@count = 0)
		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable
END
GO

ALTER TABLE dbo.Bill ADD discount INT 

UPDATE dbo.Bill SET discount = 0
GO

CREATE PROC	USP_SwitchTable
@idTable1 INT, @idTable2 int 
AS
BEGIN

	DECLARE @idFirstBill INT
	DECLARE @idSecondBill INT

	DECLARE @isFirstTableEmpty INT = 1
	DECLARE @isSecondTableEmpty INT = 1

	SELECT @idSecondBill = id FROM dbo.Bill WHERE idTable = @idTable2 AND status = 0
	SELECT @idFirstBill = id FROM dbo.Bill WHERE idTable = @idTable1 AND status = 0

	PRINT @idFirstBill
	PRINT @idSecondBill
	PRINT '------------'

	IF(@idFirstBill IS NULL)
	BEGIN
		PRINT '0000001'
	    INSERT INTO dbo.Bill
	    (
	        DateCheckIn,
	        DateCheckOut,
	        idTable,
	        status,
	        totalPrice,
	        discount
	    )
	    VALUES
	    (   GETDATE(), -- DateCheckIn - date
	        NULL, -- DateCheckOut - date
	        @idTable1,         -- idTable - int
	        0,         -- status - int
	        0.0,       -- totalPrice - float
	        0          -- discount - int
	        )
		SELECT @idFirstBill = MAX(id) FROM dbo.Bill WHERE idTable = @idTable1 AND status = 0

	END
	
	SELECT @isFirstTableEmpty = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idFirstBill

	IF(@idSecondBill IS NULL)
	BEGIN
		PRINT '0000002'
	    INSERT INTO dbo.Bill
	    (
	        DateCheckIn,
	        DateCheckOut,
	        idTable,
	        status,
	        totalPrice,
	        discount
	    )
	    VALUES
	    (   GETDATE(), -- DateCheckIn - date
	        NULL, -- DateCheckOut - date
	        @idTable2,         -- idTable - int
	        0,         -- status - int
	        0.0,       -- totalPrice - float
	        0          -- discount - int
	        )
		SELECT @idSecondBill = MAX(id) FROM dbo.Bill WHERE idTable = @idTable2 AND status = 0
	END

	SELECT @isSecondTableEmpty = COUNT(*) FROM dbo.BillInfo WHERE idBill = @idSecondBill

    SELECT id INTO IDBillInfoTable FROM	dbo.BillInfo WHERE idBill = @idSecondBill

	UPDATE dbo.BillInfo SET	idBill = @idSecondBill WHERE idBill = @idFirstBill

	UPDATE dbo.BillInfo SET idBill = @idFirstBill WHERE id IN (SELECT * FROM dbo.IDBillInfoTable)

	DROP TABLE dbo.IDBillInfoTable

	IF(@isFirstTableEmpty = 0)
		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable2

	IF(@isSecondTableEmpty = 0)
		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable1
END
GO	

ALTER TABLE dbo.Bill ADD totalPrice FLOAT

DELETE dbo.BillInfo
DELETE dbo.Bill

GO 

CREATE PROC USP_GetListBillByDate
@checkIn date, @checkOut date
AS
BEGIN
    SELECT t.name AS [Tên bàn], b.totalPrice [Tổng tiền], DateCheckIn AS [Ngày vào], DateCheckOut AS [Ngày ra], discount AS [Giảm giá]
	FROM dbo.Bill AS b, dbo.TableFood AS t
	WHERE b.DateCheckIn >= @checkIn AND b.DateCheckOut <= @checkOut AND b.status = 1 AND	t.id = b.idTable
END
GO

CREATE PROC USP_UpdateAccount
@userName NVARCHAR(100), @displayName NVARCHAR(100), @passWord NVARCHAR(100), @newPassword NVARCHAR(100)
AS
BEGIN
	DECLARE @isRightPass INT = 0
	
	SELECT @isRightPass = COUNT(*) FROM dbo.Account WHERE UserName = @userName AND PassWord = @passWord

	IF(@isRightPass = 1)
	BEGIN
	    IF(@newPassword = NULL OR @newPassword = '')
		BEGIN
		    UPDATE dbo.Account SET DisplayName = @displayName WHERE UserName = @userName
		END
		ELSE 
			UPDATE dbo.Account SET DisplayName = @displayName, PassWord = @newPassword WHERE UserName = @userName
	END
END
GO

CREATE TRIGGER UTG_DeleteBillInfo
ON dbo.BillInfo FOR	DELETE
AS
BEGIN
	DECLARE @idBillInfo INT
	DECLARE @idBill INT
	SELECT @idBillInfo = id, @idBill = Deleted.idBill  FROM Deleted

	DECLARE @idTable INT
	SELECT @idTable = idTable FROM	dbo.Bill WHERE id = @idBill

	DECLARE @count INT = 0

	SELECT @count = COUNT(*) FROM dbo.BillInfo AS bi, dbo.Bill AS b WHERE b.id = bi.idBill AND b.id = @idBill AND b.status = 0

	IF(@count = 0)
		UPDATE dbo.TableFood SET status = N'Trống' WHERE id = @idTable
END
GO	

CREATE FUNCTION [dbo].[fuConvertToUnsign1] ( @strInput NVARCHAR(4000) ) RETURNS NVARCHAR(4000) AS BEGIN IF @strInput IS NULL RETURN @strInput IF @strInput = '' RETURN @strInput DECLARE @RT NVARCHAR(4000) DECLARE @SIGN_CHARS NCHAR(136) DECLARE @UNSIGN_CHARS NCHAR (136) SET @SIGN_CHARS = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệế ìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵý ĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍ ÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ' +NCHAR(272)+ NCHAR(208) SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeee iiiiiooooooooooooooouuuuuuuuuuyyyyy AADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIII OOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD' DECLARE @COUNTER int DECLARE @COUNTER1 int SET @COUNTER = 1 WHILE (@COUNTER <=LEN(@strInput)) BEGIN SET @COUNTER1 = 1 WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1) BEGIN IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) ) BEGIN IF @COUNTER=1 SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1) ELSE SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER) BREAK END SET @COUNTER1 = @COUNTER1 +1 END SET @COUNTER = @COUNTER +1 END SET @strInput = replace(@strInput,' ','-') RETURN @strInput END
GO

SELECT * FROM	dbo.Account
SELECT * FROM	dbo.Bill
SELECT * FROM	dbo.BillInfo
SELECT * FROM	dbo.Food
SELECT * FROM	dbo.FoodCategory
SELECT * FROM	dbo.IDBillInfoTable
SELECT * FROM	dbo.TableFood
