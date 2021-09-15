USE [NEWS_WEBSITE]
GO

-- TRIGGER được khởi tạo trên tblPOST để kiểm tra dữ liệu nhập vào bằng cách khởi tạo 1 biến @AUTHOR nhận giá trị từ PostAuthor được thêm vào,
-- rồi dùng câu điều kiện để kiểm tra sự tồn tại của giá trị này trong bảng tblUSER với UserRole được cho phép.
-- Kiểm tra PostAuthor (references UserID) được thêm vào có tồn tại trong bảng tblUser hoặc cấp bậc (level) được phép tạo Post này không,
-- nếu không có hoặc không đủ quyền thì hiển thị lỗi và rollback toàn bộ.

IF OBJECT_ID('trg_checkUserLevel','TR') IS NOT NULL
DROP TRIGGER trg_checkUserLevel
GO

CREATE TRIGGER trg_checkUserLevel ON [dbo].[tblPOST]
	AFTER INSERT
	AS
	BEGIN
		SET NOCOUNT ON
		DECLARE @AUTHOR INT
		SELECT @AUTHOR = PostAuthor from inserted
		IF NOT EXISTS (SELECT * FROM tblUSER WHERE UserID = @AUTHOR AND UserRole < 3)
		BEGIN
			RAISERROR('User do not have permission!',15,0)
			ROLLBACK
		END
	END
GO
-- Test trigger: insert dữ liệu mới vào bảng tblPost có PostAuthor = 12 (UserRole = 3 không được phép tạo post) => trigger run và thông báo lỗi
 begin tran
	insert into [dbo].[tblPOST] (PostID,PostTitle,PostUrl,PostExcerpt,PostContent,
						PublishedDate,CreatedDate,ModifiedDate,PostStatus,PostAuthor,
						PostEditor,FeatureImage)
	values (11,N'Gia đình Hà Hồ - Đoan Trang hội ngộ, spotlight đổ dồn vào 2 nhóc tỳ',N'gia-dinh-ha-ho-doan-trang-hoi-ngo',
	N'Subeo nhà Hà Hồ quả là em bé vui tính, mỗi lần chụp ảnh cùng mẹ đều chiếm spotlight với biểu cảm nhí nhố.',
	N'Mới đây, Đoan Trang bất ngờ đăng tải khoảnh khắc gặp gỡ cuối tuần cùng gia đình Hà Hồ. Có thể thấy mẹ bầu Hà Hồ và Đoan Trang tỏ ra rất vui vẻ và hào hứng khi chụp ảnh cùng dàn nhóc tỳ. Bé Sol nhà Đoan Trang tiếp tục ghi điểm bởi nét đẹp lai Tây, mái tóc dài và nụ cười thân thiện.
Tuy nhiên, lần này toàn bộ spotlight lại đổ dồn về biểu cảm nhí nhố và cực đáng yêu của bé Subeo. Dễ dàng nhận ra, Subeo đang rất thích thú, cậu bé tự tin nhìn thẳng vào ống kính và không ngại ""tự dìm"" khiến mẹ Hà Hồ phải bật cười khoái chí.',
'2021-7-4','2021-7-4','2021-7-4','published',12,2,10)
select * from tblPOST
rollback tran
GO

 -- STORED PROCEDURE: Nhận một tham số là CatID và trả về danh sách bài viết thuộc danh mục này, được sắp xếp theo thứ tự mới nhất đến cũ nhất.
 -- Mục đích để lấy ra danh sách các bài viết trong danh mục và hiển thị cho phía người đọc khi nhận được yêu cầu xem các bài viết trong cùng danh mục.
IF OBJECT_ID('proc_showPostInCat','P') IS NOT NULL
DROP PROC proc_showPostInCat
GO

CREATE PROC proc_showPostInCat (@CatID int)
	AS
	BEGIN
		SELECT * FROM tblPOST WHERE PostID IN (SELECT PostID FROM tblCATPOST WHERE CatID = @CatID) AND PostStatus = 'Published'
		ORDER BY PublishedDate DESC
	END
GO

BEGIN TRAN
	exec proc_showPostInCat 3
ROLLBACK TRAN
GO

-- SCALAR FUNCTION: fc_totalPostInCat trả về tổng số bài viết có trong một Category
-- Function nhận vào một tham số là CatID có kiểu INT và trả về dữ liệu kiểu INT là tổng số post có trong category đó
-- Mục để lấy ra dữ liệu (tổng số post) và hiển thị cùng với Category trong giao diện quản trị hoặc trang danh mục, 
-- giúp người quản trị nắm được tổng số trong từng danh mục và phân bổ nội dung.
IF EXISTS (SELECT * FROM sys.all_objects WHERE name = 'fc_totalPostInCat')
DROP FUNCTION fc_totalPostInCat
GO

CREATE FUNCTION fc_totalPostInCat (@CatID int)
RETURNS INT
AS
BEGIN
	DECLARE @TOTAL INT
	SELECT @TOTAL = COUNT(*) FROM tblCATPOST WHERE CatID = @CatID
    RETURN @TOTAL
END
GO

-- Test Function fc_totalPostInCat hiển thị toàn bộ thuộc tính của bảng tblCAT kèm thuộc tính TotalPost (tổng số post lấy từ function)
BEGIN TRAN
	SELECT *, dbo.fc_totalPostInCat(CatID) AS TotalPost FROM tblCAT
ROLLBACK TRAN
GO

-- INDEX: filtered index trên cột PublishedDate của bảng tblPOST
-- Để cải thiện hiệu xuất tìm kiếm bài viết theo khoảng ngày.
-- Ở đây, index đã được lọc dựa theo PostStatus, thể hiện đối tượng là những bài viết tin tức đã được hiển thị trên website.
-- Bỏ qua các đối tượng là các bài viết quá hạn đang ở tình trạng khác (PostStatus = 'Private').

IF EXISTS (select * from sys.indexes where name = 'IX_tblPOST_PublishedDate')
DROP INDEX IX_tblPOST_PublishedDate ON [dbo].[tblPOST]
GO

CREATE NONCLUSTERED INDEX IX_tblPOST_PublishedDate
    ON [dbo].[tblPOST]([PublishedDate])
	INCLUDE (PostTitle, PostUrl, PostExcerpt)
	WHERE PostStatus = 'Published' 
GO

-- TRANSACTION: Thêm column vào bảng tblPOST thể hiện Post có cho phép thêm bình luận hay không, 
-- kiểu dữ liệu bit với 2 giá trị 0 (không cho phép) và 1 (cho phép). Cột mới được thêm một constraint default để các
-- giá trị mới thêm vào đều có dữ liệu (0: không cho phép). Sau đó, ta cần cập nhật lại cột ComAllowed có PostID xuất hiện trong bảng tblCOMMENT
-- thành các giá trị (1: cho phép) để hợp lý với những dữ liệu có sẵn trong tblCOM (đã được phép bình luận trên các post) 
BEGIN TRANSACTION MyTransaction WITH MARK N'Add New Attribute To tblPOST'
	ALTER TABLE [dbo].[tblPOST]
	ADD ComAllowed bit NOT NULL CONSTRAINT default_allowComment default 0
	GO

	UPDATE [dbo].[tblPOST] SET ComAllowed = 1 WHERE PostID IN (SELECT PostID from tblCOMMENT)
	select * from tblPOST
COMMIT TRAN
GO

IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'tg_ComInPost')
DROP TRIGGER tg_ComInPost
GO

CREATE TRIGGER tg_ComInPost ON [dbo].[tblCOMMENT]
	AFTER INSERT, UPDATE
	AS
	BEGIN
		DECLARE @POST INT, @ALLOWED bit
		SELECT @POST = PostID from inserted
		SELECT @ALLOWED = ComAllowed FROM tblPOST WHERE PostID = @POST
		IF @ALLOWED = 0
		BEGIN
			RAISERROR('Post nay khong cho phep comment',15,0)
			ROLLBACK
		END
	END
GO
-- Test Transaction 'MyTransaction'
BEGIN TRAN
	INSERT INTO [dbo].[tblCOMMENT] (ComID,PostID,ComAuthor,ComParent,ComContent,CreatedDate)
	VALUES (12,9,7,NULL,'this is a comment','2021-07-05')
ROLLBACK TRAN
GO