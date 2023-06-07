﻿USE Ql_DATHANG_BANHANG
GO

-- Đối tác thực hiện cập nhật giá của món ăn @MA_MON_AN = ‘MA002’
CREATE PROCEDURE USP_DT_CAPNHAT_GIA_MONAN @MA_MON_AN CHAR(5), @GIA_UPDATE MONEY
AS
BEGIN TRAN
	IF NOT EXISTS (SELECT * FROM MON_AN WHERE MA_MON_AN=@MA_MON_AN)
	BEGIN
		PRINT N'MÓN ĂN KHÔNG TỒN TẠI'
		RETURN 
	END

	DECLARE @GIASP MONEY
	SET @GIASP = (SELECT DON_GIA FROM MON_AN WHERE MA_MON_AN=@MA_MON_AN)
	UPDATE MON_AN
    SET DON_GIA = @GIA_UPDATE  
	WHERE MA_MON_AN=@MA_MON_AN
	WAITFOR DELAY '00:00:05'

	IF (@GIA_UPDATE = 0)
	BEGIN
		ROLLBACK TRAN
		RETURN
	END
COMMIT TRAN
GO

-- Khách hàng xem giá món ăn

CREATE PROCEDURE USP_KH_XEMGIA_MONAN @MA_MON_AN CHAR(5)
AS
BEGIN TRAN
	IF NOT EXISTS (SELECT * FROM MON_AN WHERE MA_MON_AN=@MA_MON_AN)
	BEGIN
		PRINT N'MÓN ĂN KHÔNG TỒN TẠI'
		RETURN 
	END

    SELECT *
    FROM MON_AN WITH(NOLOCK)
	WHERE MA_MON_AN=@MA_MON_AN
COMMIT TRAN
GO