--Câu 1: Tháng nào là tháng bận rộn nhất của chi nhánh Đà Nẵng (có nhiều giao dịch nhất).

--Cách thường:
SELECT MONTH (t_date) Thang
FROM Branch  JOIN Customer ON Branch.Br_id=Customer.Br_id
             JOIN Account ON Customer.Cust_id=Account.Cust_id
			 JOIN Transactions ON Account.Ac_no=Transactions.Ac_no
WHERE Br_name LIKE N'% Đà Nẵng' 
GROUP BY MONTH (t_date)
HAVING COUNT(t_id) = (SELECT f.a
                      FROM (SELECT TOP 1 COUNT (t_id) a, MONTH (t_date) b 
			                FROM Branch  JOIN Customer ON Branch.Br_id=Customer.Br_id
                                         JOIN Account ON Customer.Cust_id=Account.Cust_id
			                             JOIN Transactions ON Account.Ac_no=Transactions.Ac_no
                            WHERE Br_name LIKE N'%Đà Nẵng' 
                            GROUP BY  MONTH (t_date)
                            ORDER BY COUNT (t_id) DESC) f)

--SET: **********

--C1:
DECLARE @Thang VARCHAR(2)
SET @Thang = (SELECT MONTH (t_date) 
			  FROM Branch  JOIN Customer ON Branch.Br_id=Customer.Br_id
						   JOIN Account ON Customer.Cust_id=Account.Cust_id
						   JOIN Transactions ON Account.Ac_no=Transactions.Ac_no
			  WHERE Br_name LIKE N'% Đà Nẵng' 
			  GROUP BY MONTH (t_date)
			  HAVING COUNT(t_id) = (SELECT f.a
									FROM (SELECT TOP 1 COUNT (t_id) a, MONTH (t_date) b 
										  FROM Branch  JOIN Customer ON Branch.Br_id=Customer.Br_id
													   JOIN Account ON Customer.Cust_id=Account.Cust_id
													   JOIN Transactions ON Account.Ac_no=Transactions.Ac_no
										  WHERE Br_name LIKE N'%Đà Nẵng' 
										  GROUP BY  MONTH (t_date)
										  ORDER BY COUNT (t_id) DESC) f))
PRINT @Thang

--C2:
Declare @t varchar(2)
Set @t= (select bang.thang
		from (select month(t_date) as thang, count(t_id) as Sogd
			  from transactions join account on account.ac_no=transactions.ac_no 
					join customer on customer.cust_id=account.cust_id 
					join branch on customer.br_id=branch.br_id
			  where br_name like N'%Đà Nẵng'
			  group by month(t_date)) as bang
		where Sogd = (select top 1 count(t_id) as gd
					  from transactions join account on account.ac_no=transactions.ac_no 
							join customer on customer.cust_id=account.cust_id 
							join branch on customer.br_id=branch.br_id
					  where br_name like N'%Đà Nẵng'
					  group by month(t_date)
					  order by gd desc))
Print @t

--SELECT: ************
DECLARE @Thang VARCHAR(2)
SELECT @Thang = MONTH (T_date)
FROM Branch  JOIN Customer ON Branch.Br_id=Customer.Br_id
             JOIN Account ON Customer.Cust_id=Account.Cust_id
			 JOIN Transactions ON Account.Ac_no=Transactions.Ac_no
WHERE Br_name LIKE N'% Đà Nẵng' 
GROUP BY MONTH (t_date)
HAVING COUNT(t_id) = (SELECT f.a
                      FROM (SELECT TOP 1 COUNT (t_id) a, MONTH (t_date) b 
			                FROM Branch  JOIN Customer ON Branch.Br_id=Customer.Br_id
                                         JOIN Account ON Customer.Cust_id=Account.Cust_id
			                             JOIN Transactions ON Account.Ac_no=Transactions.Ac_no
                            WHERE Br_name LIKE N'%Đà Nẵng' 
                            GROUP BY  MONTH (t_date)
                            ORDER BY COUNT (t_id) DESC) f)
PRINT @Thang

--TABLE:
DECLARE @Thang TABLE (Thang VARCHAR(2))
INSERT INTO @Thang SELECT MONTH (t_date) Thang
					FROM Branch  JOIN Customer ON Branch.Br_id=Customer.Br_id
								 JOIN Account ON Customer.Cust_id=Account.Cust_id
								 JOIN Transactions ON Account.Ac_no=Transactions.Ac_no
					WHERE Br_name LIKE N'% Đà Nẵng' 
					GROUP BY MONTH (t_date)
					HAVING COUNT(t_id) = (SELECT f.a
										  FROM (SELECT TOP 1 COUNT (t_id) a, MONTH (t_date) b 
												FROM Branch  JOIN Customer ON Branch.Br_id=Customer.Br_id
															 JOIN Account ON Customer.Cust_id=Account.Cust_id
															 JOIN Transactions ON Account.Ac_no=Transactions.Ac_no
										  WHERE Br_name LIKE N'%Đà Nẵng' 
										  GROUP BY  MONTH (t_date)
										  ORDER BY COUNT (t_id) DESC) f)
SELECT * FROM @Thang

--Câu 2: Có bao nhiêu khách hàng quê ở Quang Nam nhưng lại mở tài khoản ở chi nhánh Đà Nẵng, số tiền trung bình trong tài khoản của họ là bao 
--       nhiêu.

--Cách thường:
SELECT COUNT (Customer.Cust_id) SLKH, AVG (Account.Ac_balance) STTB
FROM Branch  JOIN Customer ON Branch.Br_id=Customer.Br_id
             JOIN Account ON Customer.Cust_id=Account.Cust_id
WHERE Cust_ad LIKE N'% Quảng Nam'
	  AND Br_name LIKE N'% Đà Nẵng'

--SET:
DECLARE @SLKH INT, @STTB INT
SET @SLKH = (SELECT COUNT (Customer.Cust_id) 
			 FROM Branch  JOIN Customer ON Branch.Br_id=Customer.Br_id
						  JOIN Account ON Customer.Cust_id=Account.Cust_id
			 WHERE Cust_ad LIKE N'% Quảng Nam'
				   AND Br_name LIKE N'% Đà Nẵng')
SET @STTB = (SELECT AVG (Account.Ac_balance)
			 FROM Branch  JOIN Customer ON Branch.Br_id=Customer.Br_id
						  JOIN Account ON Customer.Cust_id=Account.Cust_id
			 WHERE Cust_ad LIKE N'% Quảng Nam'
				   AND Br_name LIKE N'% Đà Nẵng')
PRINT @SLKH
PRINT @STTB

--SELECT:
DECLARE @SLKH INT, @STTB INT
SELECT @SLKH = COUNT (Customer.Cust_id), @STTB = AVG (Account.Ac_balance)
FROM Branch  JOIN Customer ON Branch.Br_id=Customer.Br_id
             JOIN Account ON Customer.Cust_id=Account.Cust_id
WHERE Cust_ad LIKE N'% Quảng Nam'
	  AND Br_name LIKE N'% Đà Nẵng'
PRINT @SLKH
PRINT @STTB 

--TABLE:
DECLARE @Bang TABLE (SLKH INT,
					 STTB INT)
INSERT INTO @Bang SELECT COUNT (Customer.Cust_id) SLKH, AVG (Account.Ac_balance) STTB
				  FROM Branch  JOIN Customer ON Branch.Br_id=Customer.Br_id
							   JOIN Account ON Customer.Cust_id=Account.Cust_id
				  WHERE Cust_ad LIKE N'% Quảng Nam'
						AND Br_name LIKE N'% Đà Nẵng'
SELECT * FROM @Bang

--Câu 3: Khách hàng Dương Ngọc Long thuộc chi nhánh ngân hàng nào, quê quán ở đâu, sở hữu bao nhiêu tài khoản và trong năm 2016 đã thực hiện bao 
--		 nhiêu giao dịch trên mỗi tài khoản. 

DECLARE @Chinhanh NVARCHAR(100),
		@Quequan NVARCHAR(100),
		@STK INT
Declare @Bang TABLE (SoTK VARCHAR(10),
					 SoGD VARCHAR(2))

SET @Chinhanh = (SELECT Br_name
				  FROM Customer JOIN Branch ON Branch.Br_id=Customer.Br_id
				  WHERE Cust_name = N'Dương Ngọc Long')
SET @Quequan = (SELECT Cust_ad
				FROM Customer
				WHERE Cust_name = N'Dương Ngọc Long')
SET @STK = (SELECT COUNT (Ac_no)
			FROM Customer JOIN Account ON Account.Cust_id=Customer.Cust_id
			WHERE Cust_name = N'Dương Ngọc Long')
INSERT INTO @Bang SELECT Account.Ac_no, COUNT (T_id)
				  FROM Transactions JOIN Account ON Transactions.Ac_no=Account.Ac_no 
									JOIN Customer ON Account.Cust_id=Customer.Cust_id
				  WHERE Cust_name = N'Dương Ngọc Long'
						AND YEAR (T_date) = 2016
				  GROUP BY Account.Ac_no
SELECT * FROM @Bang
PRINT @Chinhanh
PRINT @Quequan
PRINT @STK
	  
--Câu 4: Hiển thị số lượng giao dịch của khách hàng Trương Quang Hòa trong vòng 2 năm trở lại đây.

--Cách thường:
SELECT COUNT (T_id) SLGD
FROM Transactions JOIN Account ON Account.Ac_no=Transactions.Ac_no 
				  JOIN Customer ON Customer.Cust_id=Account.Cust_id 
WHERE Cust_name LIKE N'Trương Quang Hòa'
	  AND (YEAR(T_date) BETWEEN ((SELECT MAX (YEAR(T_date)) FROM Transactions)-1)
						AND (SELECT MAX (YEAR(T_date)) FROM Transactions))

--SET:
DECLARE @SLGD INT
SET @SLGD = (SELECT COUNT (T_id)
			FROM Transactions JOIN Account ON Account.Ac_no=Transactions.Ac_no 
							  JOIN Customer ON Customer.Cust_id=Account.Cust_id 
			WHERE Cust_name LIKE N'Trương Quang Hòa'
				  AND (YEAR(T_date) BETWEEN ((SELECT MAX (YEAR(T_date)) FROM Transactions)-1)
						AND (SELECT MAX (YEAR(T_date)) FROM Transactions)))
PRINT @SLGD

--SELECT:
DECLARE @SLGD INT
SELECT @SLGD = COUNT (T_id)
FROM Transactions JOIN Account ON Account.Ac_no=Transactions.Ac_no 
				  JOIN Customer ON Customer.Cust_id=Account.Cust_id 
WHERE Cust_name LIKE N'Trương Quang Hòa'
	  AND (YEAR(T_date) BETWEEN ((SELECT MAX (YEAR(T_date)) FROM Transactions)-1)
						AND (SELECT MAX (YEAR(T_date)) FROM Transactions))
PRINT @SLGD

--TABLE:
DECLARE @SLGD TABLE (SLGD INT)
INSERT INTO @SLGD SELECT COUNT (T_id) SLGD
				  FROM Transactions JOIN Account ON Account.Ac_no=Transactions.Ac_no 
									JOIN Customer ON Customer.Cust_id=Account.Cust_id 
				  WHERE Cust_name LIKE N'Trương Quang Hòa'
						AND (YEAR(T_date) BETWEEN ((SELECT MAX (YEAR(T_date)) FROM Transactions)-1)
										  AND (SELECT MAX (YEAR(T_date)) FROM Transactions))
SELECT * FROM @SLGD

--Câu 5: Hiển thị danh sách khách hàng không thực hiện bất kì giao dịch nào trong vòng 3 năm trở lại đây. 

--Cách thường:
SELECT Cust_name 
FROM Customer
WHERE Cust_name NOT IN (SELECT cust_name
					    FROM Transactions JOIN Account ON Account.Ac_no=Transactions.Ac_no 
										  JOIN Customer ON Customer.Cust_id=Account.Cust_id 
					    WHERE YEAR(T_date) BETWEEN ((SELECT MAX (YEAR(T_date)) FROM Transactions)-2)
										   AND (SELECT MAX (YEAR(T_date)) FROM Transactions))

--SET: *******
DECLARE @DSKH NVARCHAR(50)
SET @DSKH = (SELECT Cust_name 
			FROM Customer
			WHERE Cust_name NOT IN (SELECT cust_name
									FROM Transactions JOIN Account ON Account.Ac_no=Transactions.Ac_no 
													  JOIN Customer ON Customer.Cust_id=Account.Cust_id 
									WHERE YEAR(T_date) BETWEEN ((SELECT MAX (YEAR(T_date)) FROM Transactions)-2)
													   AND (SELECT MAX (YEAR(T_date)) FROM Transactions)))
PRINT @DSKH

--SELECT: ******
DECLARE @DSKH NVARCHAR(50)
SELECT @DSKH = Cust_name
FROM Customer
WHERE Cust_name NOT IN (SELECT cust_name
					    FROM Transactions JOIN Account ON Account.Ac_no=Transactions.Ac_no 
										  JOIN Customer ON Customer.Cust_id=Account.Cust_id 
					    WHERE YEAR(T_date) BETWEEN ((SELECT MAX (YEAR(T_date)) FROM Transactions)-2)
										   AND (SELECT MAX (YEAR(T_date)) FROM Transactions))
PRINT @DSKH

--TABLE:
DECLARE @DSKH TABLE (DSKH NVARCHAR(50))
INSERT INTO @DSKH SELECT Cust_name 
				  FROM Customer
				  WHERE Cust_name NOT IN (SELECT cust_name
										  FROM Transactions JOIN Account ON Account.Ac_no=Transactions.Ac_no 
															JOIN Customer ON Customer.Cust_id=Account.Cust_id 
										  WHERE YEAR(T_date) BETWEEN ((SELECT MAX (YEAR(T_date)) FROM Transactions)-2)
															 AND (SELECT MAX (YEAR(T_date)) FROM Transactions))
SELECT * FROM @DSKH

--Câu 6: Có những khách hàng nào chưa thực hiện nào từ trước tới nay. 

--Cách thường:
SELECT Cust_name
FROM Customer
WHERE Cust_name NOT IN (SELECT Cust_name
					    FROM Transactions JOIN Account ON Account.Ac_no=Transactions.Ac_no 
										  JOIN Customer ON Customer.Cust_id=Account.Cust_id 
					    WHERE YEAR (T_date) BETWEEN (SELECT MIN (YEAR (t_date)) FROM Transactions) 
											AND (SELECT MAX (YEAR (t_date)) FROM Transactions))	

--SET:
DECLARE @KH NVARCHAR(50)
SET @KH = (SELECT Cust_name
		  FROM Customer
		  WHERE Cust_name NOT IN (SELECT Cust_name
								  FROM Transactions JOIN Account ON Account.Ac_no=Transactions.Ac_no 
													JOIN Customer ON Customer.Cust_id=Account.Cust_id 
								  WHERE YEAR (T_date) BETWEEN (SELECT MIN (YEAR (t_date)) FROM Transactions) 
													  AND (SELECT MAX (YEAR (t_date)) FROM Transactions)))
PRINT @KH	

--SELECT:
DECLARE @KH NVARCHAR(50)
SELECT @KH = Cust_name
FROM Customer
WHERE Cust_name NOT IN (SELECT Cust_name
						FROM Transactions JOIN Account ON Account.Ac_no=Transactions.Ac_no 
										  JOIN Customer ON Customer.Cust_id=Account.Cust_id 
						WHERE YEAR (T_date) BETWEEN (SELECT MIN (YEAR (t_date)) FROM Transactions) 
											AND (SELECT MAX (YEAR (t_date)) FROM Transactions))
PRINT @KH	

--TABLE:
DECLARE @KH TABLE (KH NVARCHAR(50))
INSERT INTO @KH SELECT Cust_name
				FROM Customer
				WHERE Cust_name NOT IN (SELECT Cust_name
										FROM Transactions JOIN Account ON Account.Ac_no=Transactions.Ac_no 
														  JOIN Customer ON Customer.Cust_id=Account.Cust_id 
										WHERE YEAR (T_date) BETWEEN (SELECT MIN (YEAR (t_date)) FROM Transactions) 
															AND (SELECT MAX (YEAR (t_date)) FROM Transactions))	
SELECT * FROM @KH

--Câu 7: Có những tài khoản nào thực hiện giao dịch (rút hoặc gửi tiền) cùng ngày với giao dịch gần đây nhất của ông Nguyễn Trí Hùng, những giao 
--		 dịch đó được thực hiện ở những chi nhánh nào? 

--Cách thường:
SELECT Account.Ac_no, Br_name
FROM Branch  JOIN Customer ON Branch.Br_id=Customer.Br_id
             JOIN Account ON Customer.Cust_id=Account.Cust_id
			 JOIN Transactions ON Account.Ac_no=Transactions.Ac_no 
WHERE T_date = (SELECT MAX (t_date) 
			    FROM Transactions JOIN Account ON Account.Ac_no=Transactions.Ac_no 
								  JOIN Customer ON Customer.Cust_id=Account.Cust_id
				WHERE cust_name LIKE N'Nguyễn Trí Hùng')
EXCEPT (SELECT account.ac_no, br_name
		FROM Branch  JOIN Customer ON Branch.Br_id=Customer.Br_id
             JOIN Account ON Customer.Cust_id=Account.Cust_id
			 JOIN Transactions ON Account.Ac_no=Transactions.Ac_no 
		WHERE cust_name LIKE N'Nguyễn Trí Hùng')

--SET:
DECLARE @TK VARCHAR(10), @CN NVARCHAR (50)
SET @TK = (SELECT Account.Ac_no
		  FROM Customer JOIN Account ON Customer.Cust_id=Account.Cust_id
					    JOIN Transactions ON Account.Ac_no=Transactions.Ac_no 
		  WHERE T_date = (SELECT MAX (t_date) 
						  FROM Transactions JOIN Account ON Account.Ac_no=Transactions.Ac_no 
											JOIN Customer ON Customer.Cust_id=Account.Cust_id
						  WHERE Cust_name LIKE N'Nguyễn Trí Hùng')
		  EXCEPT (SELECT account.ac_no
				  FROM Customer JOIN Account ON Customer.Cust_id=Account.Cust_id
								JOIN Transactions ON Account.Ac_no=Transactions.Ac_no  
				  WHERE cust_name LIKE N'Nguyễn Trí Hùng'))
SET @CN = (SELECT Br_name
		  FROM Branch  JOIN Customer ON Branch.Br_id=Customer.Br_id
					   JOIN Account ON Customer.Cust_id=Account.Cust_id
					   JOIN Transactions ON Account.Ac_no=Transactions.Ac_no 
		  WHERE T_date = (SELECT MAX (t_date) 
						  FROM Transactions JOIN Account ON Account.Ac_no=Transactions.Ac_no 
											JOIN Customer ON Customer.Cust_id=Account.Cust_id
						  WHERE cust_name LIKE N'Nguyễn Trí Hùng')
		  EXCEPT (SELECT br_name
				  FROM Branch  JOIN Customer ON Branch.Br_id=Customer.Br_id
							   JOIN Account ON Customer.Cust_id=Account.Cust_id
							   JOIN Transactions ON Account.Ac_no=Transactions.Ac_no 
				  WHERE cust_name LIKE N'Nguyễn Trí Hùng'))
PRINT @TK
PRINT @CN

--SELECT: ***
DECLARE @TK VARCHAR(10), @CN NVARCHAR (50)
SELECT @TK = Account.Ac_no, @CN = Br_name
FROM Branch  JOIN Customer ON Branch.Br_id=Customer.Br_id
             JOIN Account ON Customer.Cust_id=Account.Cust_id
			 JOIN Transactions ON Account.Ac_no=Transactions.Ac_no 
WHERE T_date = (SELECT MAX (t_date) 
			    FROM Transactions JOIN Account ON Account.Ac_no=Transactions.Ac_no 
								  JOIN Customer ON Customer.Cust_id=Account.Cust_id
				WHERE cust_name LIKE N'Nguyễn Trí Hùng')
EXCEPT (SELECT account.ac_no, br_name
		FROM Branch  JOIN Customer ON Branch.Br_id=Customer.Br_id
             JOIN Account ON Customer.Cust_id=Account.Cust_id
			 JOIN Transactions ON Account.Ac_no=Transactions.Ac_no 
		WHERE cust_name LIKE N'Nguyễn Trí Hùng')
PRINT @TK
PRINT @CN

--TABLE
DECLARE @Bang TABLE (TK VARCHAR(10),
					 CN NVARCHAR (50))
INSERT INTO @Bang SELECT Account.Ac_no, Br_name
				  FROM Branch  JOIN Customer ON Branch.Br_id=Customer.Br_id
							   JOIN Account ON Customer.Cust_id=Account.Cust_id
							   JOIN Transactions ON Account.Ac_no=Transactions.Ac_no 
				  WHERE T_date = (SELECT MAX (t_date) 
								  FROM Transactions JOIN Account ON Account.Ac_no=Transactions.Ac_no 
													JOIN Customer ON Customer.Cust_id=Account.Cust_id
								  WHERE cust_name LIKE N'Nguyễn Trí Hùng')
				  EXCEPT (SELECT account.ac_no, br_name
						  FROM Branch  JOIN Customer ON Branch.Br_id=Customer.Br_id
									   JOIN Account ON Customer.Cust_id=Account.Cust_id
									   JOIN Transactions ON Account.Ac_no=Transactions.Ac_no 
						  WHERE cust_name LIKE N'Nguyễn Trí Hùng')
SELECT * FROM @Bang

--Câu 8: Trong tháng 11/2010, có bao nhiêu khách hàng thuộc chi nhánh Quảng Nam thực hiện nhiều hơn 1 giao dịch? Hãy hiển thị danh sách những 
--		 khách hàng và số lần giao dịch tương ứng.

--Cách thường:
SELECT COUNT(t_id) SLGD, Cust_name 
FROM Transactions  JOIN Account ON Account.Ac_no = Transactions.Ac_no
				   JOIN Customer ON Customer.Cust_id = Account.Cust_id
				   JOIN Branch ON Branch.Br_id = Customer.Br_id
WHERE YEAR(T_date) ='2010' 
	  AND MONTH(T_date) ='11' 
	  AND Br_name LIKE N'%Quảng Nam'
GROUP BY Cust_name
HAVING COUNT(T_id)>1

--SET:
DECLARE @SLGD INT, @DSKH NVARCHAR (50)
SET @SLGD = (SELECT COUNT(t_id) 
			FROM Transactions  JOIN Account ON Account.Ac_no = Transactions.Ac_no
							   JOIN Customer ON Customer.Cust_id = Account.Cust_id
							   JOIN Branch ON Branch.Br_id = Customer.Br_id
			WHERE YEAR(T_date) ='2010' 
				  AND MONTH(T_date) ='11' 
				  AND Br_name LIKE N'%Quảng Nam'
			GROUP BY Cust_name
			HAVING COUNT(T_id)>1)
SET @DSKH = (SELECT Cust_name 
			FROM Transactions  JOIN Account ON Account.Ac_no = Transactions.Ac_no
							   JOIN Customer ON Customer.Cust_id = Account.Cust_id
							   JOIN Branch ON Branch.Br_id = Customer.Br_id
			WHERE YEAR(T_date) ='2010' 
				  AND MONTH(T_date) ='11' 
				  AND Br_name LIKE N'%Quảng Nam'
			GROUP BY Cust_name
			HAVING COUNT(T_id)>1)
PRINT @SLGD
PRINT @DSKH

--SELECT:
DECLARE @SLGD INT, @DSKH NVARCHAR (50)
SELECT @SLGD = COUNT(t_id), @DSKH = Cust_name
FROM Transactions  JOIN Account ON Account.Ac_no = Transactions.Ac_no
				   JOIN Customer ON Customer.Cust_id = Account.Cust_id
				   JOIN Branch ON Branch.Br_id = Customer.Br_id
WHERE YEAR(T_date) ='2010' 
	  AND MONTH(T_date) ='11' 
	  AND Br_name LIKE N'%Quảng Nam'
GROUP BY Cust_name
HAVING COUNT(T_id)>1
PRINT @SLGD
PRINT @DSKH

--TABLE:
DECLARE @Bang TABLE (SLGD INT,
					 DSKH NVARCHAR (50))
INSERT INTO @Bang SELECT COUNT(t_id) SLGD, Cust_name 
				  FROM Transactions  JOIN Account ON Account.Ac_no = Transactions.Ac_no
									 JOIN Customer ON Customer.Cust_id = Account.Cust_id
									 JOIN Branch ON Branch.Br_id = Customer.Br_id
				  WHERE YEAR(T_date) ='2010' 
						AND MONTH(T_date) ='11' 
						AND Br_name LIKE N'%Quảng Nam'
				  GROUP BY Cust_name
				  HAVING COUNT(T_id)>1
SELECT * FROM @Bang

--Câu 9: Ai là người có nhiều tiền gửi vào ngân hàng Vietcombank nhất tính tới thời điểm tháng 12/2016.

--Cách thường:
SELECT Cust_name
FROM Customer JOIN Account ON Account.Cust_id = Customer.Cust_id
			  JOIN Transactions ON Transactions.Ac_no = Account.Ac_no
WHERE T_date BETWEEN (SELECT MIN(t_date) FROM Transactions) AND '2016/12/01' 
			 AND T_amount=(SELECT MAX(t_amount) FROM Transactions)
	  AND T_type = '1'

--SET:
DECLARE @KH NVARCHAR (50)
SET @KH = (SELECT Cust_name
		  FROM Customer JOIN Account ON Account.Cust_id = Customer.Cust_id
						JOIN Transactions ON Transactions.Ac_no = Account.Ac_no
		  WHERE T_date BETWEEN (SELECT MIN(t_date) FROM Transactions) AND '2016/12/01' 
					   AND T_amount=(SELECT MAX(t_amount) FROM Transactions)
					   AND T_type = '1')
PRINT @KH

--SELECT:
DECLARE @KH NVARCHAR (50)
SELECT @KH = Cust_name
FROM Customer JOIN Account ON Account.Cust_id = Customer.Cust_id
			  JOIN Transactions ON Transactions.Ac_no = Account.Ac_no
WHERE T_date BETWEEN (SELECT MIN(t_date) FROM Transactions) AND '2016/12/01' 
			 AND T_amount=(SELECT MAX(t_amount) FROM Transactions)
	  AND T_type = '1'
PRINT @KH

--TABLE:
DECLARE @Bang TABLE (KH NVARCHAR (50))
INSERT INTO @Bang SELECT Cust_name
				  FROM Customer JOIN Account ON Account.Cust_id = Customer.Cust_id
								JOIN Transactions ON Transactions.Ac_no = Account.Ac_no
				  WHERE T_date BETWEEN (SELECT MIN(t_date) FROM Transactions) AND '2016/12/01' 
							   AND T_amount=(SELECT MAX(t_amount) FROM Transactions)
							   AND T_type = '1'
SELECT * FROM @Bang