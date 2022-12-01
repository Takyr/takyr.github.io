--Tao database mang ten QLNH

create database QLNH;
GO

use QLNH;
GO

--Tạo CSDL

--Tạo bảng tài khoản người dùng UserAccount
CREATE TABLE UserAccount
(
	UserLoginID SMALLINT NOT NULL IDENTITY(1,1),
	UserLogin nvarchar(50) NOT NULL,
	UserPassword nvarchar(20) NOT NULL,
	CONSTRAINT pk_UA_UserLoginID PRIMARY KEY(UserLoginID)
);
GO

--Tạo bảng câu hỏi bảo mật SecurityQuestion

CREATE TABLE SecurityQuestion
(
	UserSecurityQuestionID TINYINT NOT NULL IDENTITY(1,1),
	UserSecurityQuestion nvarchar(50) NOT NULL,
	CONSTRAINT pk_SQ_UserSecurityQuestionID PRIMARY KEY(UserSecurityQuestionID)
);
GO


--Tạo bảng trạng thái tài khoản AccountType
CREATE TABLE AccountType
(
	AccountTypeID TINYINT NOT NULL IDENTITY(1,1),
	AccountTypeDescription nvarchar(30) NOT NULL,
	CONSTRAINT pk_AS_AccountTypeID PRIMARY KEY(AccountTypeID)
);
GO

--Tạo bảng lợi nhuận InterestRates

CREATE TABLE InterestRates
(
	InterestRatesID TINYINT NOT NULL IDENTITY(1,1),
	InterestRatesValue NUMERIC(9,2) NOT NULL, 
	InterestRatesDescription nvarchar(20) NOT NULL,
	CONSTRAINT pk_SIR_InterestRatesID PRIMARY KEY(InterestRatesID)
);
GO

--GO

--Tạo bảng loại tài khoản AccountStus
CREATE TABLE AccountStus
(
	AccountStusID TINYINT NOT NULL IDENTITY(1,1),
	AccountStusDescription nvarchar(30) NOT NULL,
	CONSTRAINT pk_AT_AccountStusID PRIMARY KEY(AccountStusID)
);
GO
--Tạo bảng log lỗi đăng nhập LoginErrorLog
CREATE TABLE LoginErrorLog
(
	ErrorLogID INT NOT NULL IDENTITY(1,1),
	ErrorTime DATETIME NOT NULL,
	FailedTransactionXML XML,
	CONSTRAINT pk_LEL_ErrorLogID PRIMARY KEY(ErrorLogID)
);
GO

--Creating table named Employee
CREATE TABLE Employee
(
	EmployeeID INT NOT NULL IDENTITY(1,1),
	EmployeeFirstName nvarchar(25) NOT NULL,
	EmployeeLastName nvarchar(25),
	EmployeeisManager BIT,
	CONSTRAINT pk_E_EmployeeID PRIMARY KEY(EmployeeID)
);
GO

--Tạo bảng loại giao dịch TransactionType
CREATE TABLE TransactionType
(
	TransactionTypeID TINYINT NOT NULL IDENTITY(1,1),
	TransactionTypeName CHAR(10) NOT NULL,
	TransactionTypeDescription nvarchar(50),
	TransactionFeeAmount SMALLMONEY,
	CONSTRAINT pk_TT_TransactionTypeID PRIMARY KEY(TransactionTypeID)
);
GO

--tạo bảng loại lỗi giao dịch FailedTransactionErrorType
CREATE TABLE FailedTransactionErrorType
(
	FailedTransactionErrorTypeID TINYINT NOT NULL IDENTITY(1,1),
	FailedTransactionErrorTypeDescription nvarchar(50) NOT NULL,
	CONSTRAINT pk_FTEID PRIMARY KEY(FailedTransactionErrorTypeID)
);
GO
--Select * from QLNH.dbo.FailedTransactionErrorType
--Tạo bảng loại lỗi giao dịch FailedTransactionLog
CREATE TABLE FailedTransactionLog
(
	FailedTransactionID INT NOT NULL IDENTITY(1,1),
	FailedTransactionErrorTypeID TINYINT NOT NULL,
	FailedTransactionErrorTime DATETIME,
	CONSTRAINT pk_FTL_FailedTransactionID PRIMARY KEY(FailedTransactionID),
	CONSTRAINT fk_FTL_FailedTransactionErrorTypeID FOREIGN KEY(FailedTransactionErrorTypeID) REFERENCES FailedTransactionErrorType(FailedTransactionErrorTypeID) 
);
GO
--Select * from QLNH.dbo.FailedTransactionErrorType
--Tạo bảng câu trả lời bảo mật UserSecurityAnswers
CREATE TABLE UserSecurityAnswers
(
	UserLoginID SMALLINT NOT NULL IDENTITY(1,1),
	UserSecurityAnswers nvarchar(25) NOT NULL,
	UserSecurityQuestionID TINYINT NOT NULL,
	CONSTRAINT pk_USA_UserLoginID PRIMARY KEY(UserLoginID), 
	CONSTRAINT fk_USA_UserLoginID FOREIGN KEY(UserLoginID) REFERENCES UserAccount(UserLoginID),
	CONSTRAINT fk_USA_UserSecurityQuestionID FOREIGN KEY(UserSecurityQuestionID) REFERENCES SecurityQuestion(UserSecurityQuestionID)
);
GO
--Tạo bảng tài khoản Account
CREATE TABLE Account
(
	AccountID INT NOT NULL IDENTITY(1,1),
	CurrentBalance INT NOT NULL,
	AccountTypeID TINYINT NOT NULL REFERENCES AccountType (AccountTypeID),
	AccountStusID TINYINT NOT NULL,
	InterestRatesID TINYINT NOT NULL,
	CONSTRAINT pk_A_AccountID PRIMARY KEY(AccountID),
	CONSTRAINT fk_A_AccountStusID FOREIGN KEY(AccountStusID) REFERENCES AccountStus(AccountStusID),
	CONSTRAINT fk_A_InterestRatesID FOREIGN KEY(InterestRatesID) REFERENCES InterestRates(InterestRatesID)
);
GO

--Tạo bảng khách hàng Customer
CREATE TABLE Customer
(
	CustomerID INT NOT NULL IDENTITY(1,1),
	AccountID INT NOT NULL,
	Address nvarchar(30) NOT NULL,
	CustomerFirstName  nvarchar(30) NOT NULL,
	CustomerLastName  nvarchar(30) NOT NULL,
	Email CHAR(40) NOT NULL,
	PhoneNumber nvarchar(10) NOT NULL,
	ID nvarchar(12) NOT NULL UNIQUE,
	--UserLoginID SMALLINT NOT NULL,
	CONSTRAINT pk_CustomerID PRIMARY KEY(CustomerID),
	CONSTRAINT fk_C_AccountID FOREIGN KEY(AccountID) REFERENCES Account(AccountID),
	--CONSTRAINT fk_C_UserLoginID FOREIGN KEY(UserLoginID) REFERENCES CustomerAccount(UserLoginID)  
);
GO

--Tạo bảng tài khoản khách hàng CustomerAccount
CREATE TABLE CustomerAccount
(
	UserLoginID SMALLINT NOT NULL,
	CustomerID INT NOT NULL,
	CONSTRAINT fk_CA_UserLoginID FOREIGN KEY(UserLoginID) REFERENCES UserAccount(UserLoginID),
	CONSTRAINT fk_CustomerID FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID)
);
GO


--Tạo bảng tài khoản nhân viên EmployeeAccount
CREATE TABLE EmployeeAccount
(
	UserLoginID SMALLINT NOT NULL,
	EmployeeID INT NOT NULL,
	CONSTRAINT fk_EA_UserLoginID FOREIGN KEY(UserLoginID) REFERENCES UserAccount(UserLoginID),
	CONSTRAINT fK_EA_EmployeeID FOREIGN KEY(EmployeeID) REFERENCES Employee(EmployeeID)
);
GO


--Tạo bảng TransactionLog
CREATE TABLE TransactionLog
(
	TransactionID INT NOT NULL IDENTITY(1,1),
	TransactionDate DATETIME NOT NULL,
	TransactionTypeID TINYINT NOT NULL,
	TransactionAmount Money NOT NULL,
	NewBalance Money NOT NULL,
	AccountID INT NOT NULL,
	CustomerID INT NOT NULL,
	EmployeeID INT NOT NULL,
	UserLoginID SMALLINT NOT NULL,
	CONSTRAINT pk_TL_TransactionID PRIMARY KEY(TransactionID),
	CONSTRAINT fk_TT_TL_TransactionTypeID FOREIGN KEY(TransactionTypeID) REFERENCES TransactionType(TransactionTypeID),
	CONSTRAINT fk_A_TL_AccountID FOREIGN KEY(AccountID) REFERENCES Account(AccountID),
	CONSTRAINT fk_C_TL_CustomerID FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID),
	CONSTRAINT fk_E_TL_EmployeeID FOREIGN KEY(EmployeeID) REFERENCES Employee(EmployeeID),
	CONSTRAINT fk_UL_TL_UserLoginID FOREIGN KEY(UserLoginID) REFERENCES UserAccount(UserLoginID)    
);
GO

select * from Account

--Tạo bảng nợ LoaningLog
CREATE TABLE Loaning
(
	AccountID INT NOT NULL IDENTITY(1,1),
	LoaningDate DATETIME NOT NULL,
	LoaningAmount Money NOT NULL,
	CONSTRAINT Pk_ODL_AccountID PRIMARY KEY(AccountID),
	CONSTRAINT fk_A_ODL_AccountID FOREIGN KEY(AccountID) REFERENCES Account(AccountID)
);
GO
 
/** Thêm dữ liệu thủ công **/

insert into UserAccount values('Admin1', 'Pass1');
insert into UserAccount values('Admin2', 'Pass2');
insert into UserAccount values('Admin3', 'Pass3');
insert into UserAccount values('Admin4', 'Pass4');
insert into UserAccount values('Admin5', 'Pass5');
insert into UserAccount values('User1', 'Pass1');
insert into UserAccount values('User2', 'Pass2');
insert into UserAccount values('User3', 'Pass3');
insert into UserAccount values('User4', 'Pass4');
insert into UserAccount values('User5', 'Pass5');
GO

insert into SecurityQuestion values('Bạn thích màu gì?');
insert into SecurityQuestion values('Bạn thích ăn gì?');
insert into SecurityQuestion values('Bạn thích uống gì?');
insert into SecurityQuestion values('Bạn thích số mấy?');
insert into SecurityQuestion values('Bạn đã từng học trường nào?');
GO

Insert into AccountType values('TermSaving');
Insert into AccountType values('Saving');
Insert into AccountType values('Loan');
--Insert into AccountType values('Employee');
GO

--5 loại lãi gửi tiết kiệm
insert into InterestRates values(0.1, 'low');
insert into InterestRates values(4.9, 'medium');
insert into InterestRates values(6.0, 'high');
insert into InterestRates values(7.5, 'very high');
insert into InterestRates values(16, 'Loan');
GO

select * from AccountStus;
insert into AccountStus values('Closed');
insert into AccountStus values('Active');
insert into AccountStus values('Passive');
insert into AccountStus values('Frozen');
--insert into AccountStus values('');
GO

insert into Employee values('Tran', 'Khac Tâm', '0');
insert into Employee values('Nguyen', 'Nhat Vu', '0');
insert into Employee values('Vo', 'Duy Nhat', '0');
insert into Employee values('Nguyen', 'Hoang Diep', '1');
GO

insert into UserSecurityAnswers values(N'Xanh', 1);
insert into UserSecurityAnswers values(N'Phở', 2);
insert into UserSecurityAnswers values(N'Nước ép', 3);
insert into UserSecurityAnswers values(N'SPKT', 4);
insert into UserSecurityAnswers values(N'10', 5);
GO

insert into Account values(120000000, 1, 1, 1);
insert into Account values(87500000, 1, 1, 1);
insert into Account values(50000000, 1, 1, 1);
insert into Account values(230000000, 1, 1, 1);
insert into Account values(27925000, 1, 1, 1);
GO

insert into Customer values(1, 'Nguyen Thi Minh Khai, Quan 1', 'Tran', 'Minh Chau', 'minhchau@email.com', '0112233445', '433236828001');
insert into Customer values(2, 'Vo Liem Son, Quan 8', 'Nguyen', 'Ngoc Han', 'Han@email.com', '0105960868', '193285937988');
insert into Customer values(3, 'Duong 33, Quan 2', 'le', 'Trung Dung', 'dung@email.com', '0908746859', '289204622765');
insert into Customer values(4, 'Hem 214, Quan 1', 'Tran', 'Minh Chau', 'minhchau@email.com', '0265051824', '556366193993');
insert into Customer values(5, 'Nguyen Thi Minh Khai, Quan 1', 'Tran', 'Minh Chau', 'minhchau@email.com', '0943717515', '203173343942');
GO

--DBCC CHECKIDENT ('[Customer]', RESEED, 1);
--GO

insert into EmployeeAccount values(1, 1);
insert into EmployeeAccount values(2, 2);
insert into EmployeeAccount values(3, 3);
insert into EmployeeAccount values(4, 4);
GO

insert into CustomerAccount values(6, 1);
insert into CustomerAccount values(7, 2);
insert into CustomerAccount values(8, 3);
insert into CustomerAccount values(9, 4);
insert into CustomerAccount values(10, 5);
GO


insert into FailedTransactionErrorType values('Withdraw limit reached');
insert into FailedTransactionErrorType values('Daily limit reached');
insert into FailedTransactionErrorType values('Not enough balance');
insert into FailedTransactionErrorType values('Invalid denomination');
insert into FailedTransactionErrorType values('ATM machine down');
insert into FailedTransactionErrorType values('Unavailable Account Transfer');
GO
/*
insert into LoginErrorLog values(TRY_CAST('2022/6/9 12:34:57' AS DATETIME), 'Invalid User');
insert into LoginErrorLog values(TRY_CAST('2022/4/5 02:14:00' AS DATETIME), 'Wrong Password');
insert into LoginErrorLog values(TRY_CAST('2022/10/12 08:34:15' AS DATETIME), 'Datacenter down');
GO

insert into TransactionType values('Balance', 'See money', '0');
insert into TransactionType values('Transfer', 'Send money', '450');
insert into TransactionType values('Receive', 'Get money', '300');
insert into TransactionType values('Paid', 'Paid to John', '45000');
insert into TransactionType values('Statement', 'Checked monthly transaction', '0');
GO

insert into FailedTransactionLog values(1, TRY_CAST('2015/6/4 07:30:56' AS DATETIME), 'First');
insert into FailedTransactionLog values(2, TRY_CAST('2018/6/9 12:34:57' AS DATETIME), 'Second');
insert into FailedTransactionLog values(3, TRY_CAST('2016/4/5 02:14:00' AS DATETIME), 'Third');
insert into FailedTransactionLog values(4, TRY_CAST('2014/7/5 05:56:59' AS DATETIME), 'Fourth');
insert into FailedTransactionLog values(5, TRY_CAST('2009/10/12 08:34:15' AS DATETIME), 'Fifth');
GO

insert into TransactionLog values('2015/6/4 07:30:56', 1,15000.7, 7869878, 1, 1, 1, 1);
insert into TransactionLog values('2018/6/9 12:34:57', 2,435435, 675687, 2, 2, 2, 2);
insert into TransactionLog values('2016/4/5 02:14:00', 3,855869.3, 34512356, 3, 3, 3, 3);
insert into TransactionLog values('2014/7/5 05:56:59', 4,1276303.6, 4643234, 4, 4, 4, 4);
insert into TransactionLog values('2009/10/12 08:34:15', 5,1696737.9, 325344, 5, 5, 5, 5);
GO

insert into LoaningLog values('2015/6/4 07:30:56', 0, 'Clear');
insert into LoaningLog values('2018/6/9 12:34:57', 5, 'Pending');
insert into LoaningLog values('2016/4/5 02:14:00', 10, 'Clear');
insert into LoaningLog values('2014/7/5 05:56:59', 15, 'Pending');
insert into LoaningLog values('2009/10/12 08:34:15', 20, 'Clear');
*/

-- PHASE II of project begins

--1. Tạo view cho những tài khoản tiết kiệm. 

--DROP VIEW VW_Customer;
--GO

CREATE VIEW VW_Customer AS
SELECT DISTINCT c.* FROM Customer c
JOIN Account a
ON c.AccountID = a.AccountId
JOIN AccountType at
ON a.AccountTypeID = at.AccountTypeID
WHERE at.AccountTypeDescription = 'Saving' or at.AccountTypeDescription = 'TernSaving'; -- and c.State = 'ON';
GO


--2.Tạo view cho những tài khoản có số dư lớn hơn 10,000,000(bao gồm tiền lãi). 

--DROP VIEW VW_Customer_AMT;
--GO
--select * from VW_Customer_ON;

CREATE VIEW VW_Customer_ON AS
SELECT c.CustomerLastName, SUM(a.CurrentBalance) AS Ac_Balance, SUM(a.CurrentBalance + (a.CurrentBalance * s.InterestRatesID)/100) AS Total_Ac_Balance 
FROM Customer c
JOIN Account a
ON c.AccountID = a.AccountId
JOIN InterestRates s
ON a.InterestRatesID = s.InterestRatesID 
GROUP BY c.CustomerLastName
HAVING SUM(a.CurrentBalance + (a.CurrentBalance * s.InterestRatesValue)/100) > 5000;
GO

--3. Tạo view đếm số lượng theo loại tài khoản. 

--DROP VIEW VW_Customer_ACC;
--GO
--select * from VW_Customer_ACC

CREATE VIEW VW_Customer_ACC 
AS
SELECT c.CustomerLastName, at.AccountTypeDescription, COUNT(*) AS Total_AC_Types FROM Customer c
JOIN Account a
ON c.AccountID = a.AccountId
JOIN AccountType at
ON a.AccountTypeID = at.AccountTypeID
GROUP BY c.CustomerLastName, at.AccountTypeDescription;
GO

--4. Tạo view để xem danh sách tài khoản & mật khẩu của khách hàng

--DROP VIEW VW_Account_UL;
--GO
--SELECT * FROM VW_Account_UL

CREATE VIEW VW_Account_UL 
AS
SELECT DISTINCT ua.UserLogin, ua.UserPassword
FROM UserAccount ua
JOIN CustomerAccount ca
ON ua.UserLoginID = ca.UserLoginID;
GO


--5. Tạo view để Loaning amount. 

--DROP VIEW VW_Customer_OD;
--GO

/*
CREATE VIEW VW_Customer_OD 
AS
SELECT DISTINCT c.CustomerFirstName, o.LoaningAmount
FROM LoaningLog o
JOIN Customer c
ON o.AccountID = c.AccountID;
GO
*/

--6. Tạo proc thêm User_ trước UserLogin của khách hàng. 

--DROP PROCEDURE sp_Update_Login;
--GO

CREATE PROCEDURE sp_Update_Login
AS
UPDATE ua
SET ua.UserLogin = Concat('User_', ua.UserLogin)
FROM UserAccount ua
JOIN CustomerAccount ca
on ua.UserLoginID = ca.UserLoginID
GO
--EXEC sp_Update_Login;
--GO


--7. Tạo procedure trả về đủ tên của khách hàng khi tìm kiếm theo tài khoản. 

--DROP PROCEDURE sp_Customer_Details;
--GO

CREATE PROCEDURE sp_Customer_Details @AccountID INT
AS
SELECT c.CustomerFirstName + ' ' + c.CustomerLastName AS Customer_Full_Name
FROM Customer c
JOIN Account a
ON c.AccountID = a.AccountId
WHERE a.AccountID = @AccountID;
GO

--EXEC sp_Customer_Details 2;
--GO
 
--8. Tạo proc để trả về error log trong 24 giờ. 

--DROP PROCEDURE sp_Errors_24;
--GO

CREATE PROCEDURE sp_Errors_24
AS
SELECT * FROM LoginErrorLog
WHERE ErrorTime BETWEEN DATEADD(hh, -24, GETDATE()) AND GETDATE();
GO

--EXEC sp_Errors_24;
--GO
 
--9. Tạo hàm để thêm tiền vào tài khoản của khách hàng.  

--DROP PROCEDURE sp_Update_cBalance_After_Deposit;
--GO

CREATE PROCEDURE sp_Update_cBalance_After_Deposit @AccountID INT, @Deposit INT
AS
UPDATE Account
SET CurrentBalance = CurrentBalance + @Deposit
where AccountID = @AccountID;
GO
--EXEC sp_Update_cBalance_After_Deposit 3, 300;
--GO

--10. Tạo thủ tục để chuyển tiền. 

--DROP PROCEDURE sp_Update_cBalance_After_Withdraw;
--GO
CREATE PROCEDURE sp_Update_cBalance_After_Withdraw @AccountID INT, @Withdraw INT
AS
UPDATE Account
SET CurrentBalance = CurrentBalance - @Withdraw
WHERE AccountID = @AccountID;
GO

--tạo trigger không cho chuyển tiền khi số dư kg đủ
--DROP TRIGGER trg_update;
--GO

CREATE TRIGGER trg_LimitCurBalance ON Account after update
AS 
	IF EXISTS (SELECT * FROM Account WHERE CurrentBalance < 0)
	BEGIN 
		INSERT INTO FailedTransactionLog values (3, CURRENT_TIMESTAMP);
		PRINT N'Số dư trong tài khoản không đủ để thực hiện hành động';
		ROLLBACK TRANSACTION
	END
GO
--EXEC sp_Update_cBalance_After_Withdraw 3, 900000;
--GO

--Tạo trigger kg cho chuyển tiền đến những tài khoản kg hợp lệ
CREATE TRIGGER trg_TransferToErrorAcc ON Account after update
AS
	IF EXISTS (SELECT * FROM Account WHERE (AccountStusID = 1 OR AccountStusID= 4 AND CurrentBalance < 
	(SELECT CurrentBalance FROM inserted)))
	BEGIN
		INSERT INTO FailedTransactionLog values (6, CURRENT_TIMESTAMP);
		PRINT N'Giao dịch thất bại, tài khoản bạn chuyển tiền đang không khả dụng'
		ROLLBACK TRANSACTION
	END
GO

--11. Create a stored procedure to remove all security questions for a particular login. 
/*
DROP PROCEDURE sp_Delete_Question;
GO

CREATE PROCEDURE sp_Delete_Question @UserLoginID SMALLINT
AS
DELETE SecurityQuestion
FROM SecurityQuestion uq
JOIN UserSecurityAnswers ua
ON ua.UserSecurityQuestionID = uq.UserSecurityQuestionID
JOIN UserAccount ul
ON ua.UserLoginID = ul.UserLoginID
WHERE ul.UserLoginID = @UserLoginID;
GO

EXEC sp_Delete_Question 5;
GO
*/

--12. Delete all error logs created in the last hour. 

--DROP PROCEDURE sp_Delete_Errors;
--GO

CREATE PROCEDURE sp_Delete_Errors
AS
delete FROM LoginErrorLog
WHERE  ErrorTime BETWEEN DATEADD(hh, -1, GETDATE()) AND GETDATE();
GO

--EXEC sp_Delete_Errors;
--GO

--13. Tạo thu tuc update thông tin của khách hàng. 

--DROP PROCEDURE sp_Update_Customer_Info;
--GO

CREATE PROCEDURE sp_Update_Customer_Info 
@accountID int,
@address nvarchar(30), @customerFirstName nvarchar(30), @customerLastName nvarchar(30), 
@email char(40), @phoneNumber varchar(10), @ID nvarchar(12)
AS
UPDATE c
SET Address = @address,
	CustomerFirstName = @customerFirstName,
	CustomerLastName = @customerLastName,
	Email = @email,
	PhoneNumber = @phoneNumber,
	ID = @ID
From Customer c
where c.AccountID=@accountID;
GO

--EXEC sp_Update_Customer_Info;
--GO


--14. tạo thủ tục login Procedure User Employee Login
CREATE PROCEDURE sp_User_Login
@userName nvarchar(50), @passWord nvarchar(20)
AS
BEGIN
Select ua.UserLogin,ua.UserPassword 
FROM UserAccount ua
Join EmployeeAccount ea
On ua.UserLoginID = ea.UserLoginID
WHERE ua.UserLogin = @userName and ua.UserPassword = @passWord;
END
GO

--drop proc sp_User_Login;

--exec sp_User_Login 'Admin1','Pass1';
--GO

--16.Tạo proc tìm khách hàng theo AccountId
CREATE PROCEDURE sp_Find_Customer_Account_by_AccountID
@accountId int
as
begin 
Select c.CustomerID, c.AccountID, c.Address, c.CustomerFirstName, c.CustomerLastName, c.Email,c.PhoneNumber, c.ID, a.CurrentBalance, atp.AccountTypeDescription, ast.AccountStusDescription
From Customer c
Join Account a
On c.AccountID = a.AccountID
join AccountType atp
ON a.AccountTypeID = atp.AccountTypeID
join AccountStus ast
on a.AccountStusID = ast.AccountStusID
WHERE c.AccountID = @accountId;
END
GO

--drop proc sp_Find_Customer_Account_by_AccountID
--go

--exec sp_Find_Customer_Account_by_AccountID 1;

--16.Tạo proc tìm khách hàng theo Name
CREATE PROCEDURE sp_Find_Customer_Account_by_Name
@customerName varchar(60)
as
begin 
Select c.CustomerID, c.AccountID, c.Address, c.CustomerFirstName, c.CustomerLastName, c.Email, c.ID, a.CurrentBalance, atp.AccountTypeDescription, ast.AccountStusDescription
From Customer c
Join Account a
On c.AccountID = a.AccountID
join AccountType atp
ON a.AccountTypeID = atp.AccountTypeID
join AccountStus ast
on a.AccountStusID = ast.AccountStusID
WHERE (CHARINDEX(@customerName, c.CustomerFirstName + c.CustomerLastName) > 0);
END
GO

--drop proc sp_Find_Customer_Account_by_Name
--GO

--exec sp_Find_Customer_Account_by_Name 'minh';

--17.Tạo proc tìm khách hàng theo ID
CREATE PROCEDURE sp_Find_Customer_Account_by_CustomerID
@customerID nvarchar(12)
as
begin 
Select c.CustomerID, c.AccountID, c.Address, c.CustomerFirstName, c.CustomerLastName, c.Email, c.PhoneNumber, c.ID, a.CurrentBalance, atp.AccountTypeDescription, ast.AccountStusDescription
From Customer c
Join Account a
On c.AccountID = a.AccountID
join AccountType atp
ON a.AccountTypeID = atp.AccountTypeID
join AccountStus ast
on a.AccountStusID = ast.AccountStusID
WHERE CHARINDEX(@customerID, c.ID) > 0;
END
GO

--drop proc sp_Find_Customer_Account_by_CustomerID
--go

--exec sp_Find_Customer_Account_by_CustomerID '33';

--17.Tạo proc tìm khách hàng theo SDT
CREATE PROCEDURE sp_Find_Customer_Account_by_PhoneNumber
@phoneNumber nvarchar(10)
as
begin 
Select c.CustomerID, c.AccountID, c.Address, c.CustomerFirstName, c.CustomerLastName, c.Email, c.PhoneNumber, c.ID, a.CurrentBalance, atp.AccountTypeDescription, ast.AccountStusDescription
From Customer c
Join Account a
On c.AccountID = a.AccountID
join AccountType atp
ON a.AccountTypeID = atp.AccountTypeID
join AccountStus ast
on a.AccountStusID = ast.AccountStusID
WHERE CHARINDEX(@phoneNumber, c.PhoneNumber) > 0;
END
GO

--drop proc sp_Find_Customer_Account_by_PhoneNumber
--GO

--exec sp_Find_Customer_Account_by_PhoneNumber '01';

--18.tạo hàm kiểm tra tài khoản có tồn tại không
CREATE FUNCTION Check_CustomerAcccount_is_Exist(@accountId int)
Returns bit
AS 
BEGIN
	Declare @exits bit
	Select @exits = CASE WHEN COUNT(*) > 0 THEN 1 else 0 end
	from Customer c
	where c.AccountID = @accountId
	return @exits
END
GO

--drop function Check_CustomerAcccount_is_Exist
--GO

--exec Check_CustomerAcccount_is_Exist 1;

--19.tạo function kiểm tra có phải là admin không
CREATE FUNCTION Check_UserAcccount_is_Admin(@userLogin nvarchar(50), @userPass nvarchar(20))
Returns bit
AS 
BEGIN
	Declare @isAdmin bit
	Select @isAdmin = CASE WHEN COUNT(*) > 0 THEN 1 else 0 end
	FROM Employee e
	join EmployeeAccount ea
	on e.EmployeeID = ea.EmployeeID 
	join UserAccount ua
	on ua.UserLoginID = ea.UserLoginID
	WHERE (ua.UserLogin = @userLogin and ua.UserPassword = @userPass) and
			(e.EmployeeisManager = 1)
	return @isAdmin
END
GO

--DROP FUNCTION Check_UserAcccount_is_Admin
--GO

/*
Declare @isAdmin as bit = dbo.Check_UserAcccount_is_Admin('Admin1' , 'Pass1');
if @isAdmin = 1
	BEGIN
	PRINT 'True';
	END
ELSE 
	begin
	Print 'false';
	end
*/

--20. Tạo procedure chuyển tiền dựa trên AccountID
CREATE PROC sp_Transfer_between_Account 
@sendAccountId int, @receiveAccountId int, @amount int
AS 
BEGIN
	exec sp_Update_cBalance_After_Deposit @receiveAccountId , @amount;
	exec sp_Update_cBalance_After_Withdraw @sendAccountId, @amount;
END
GO

--DROP PROC sp_Transfer_between_Account
--GO

--exec sp_Transfer_between_Account 1, 2, 50000
--GO


-- 21. Tao Procedure
