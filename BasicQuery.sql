USE [NEWS_WEBSITE]
GO

-- Truy vấn dữ liệu trên một bảng
-- Trích xuất dữ liệu trong tblPOST trả về dữ liệu các cột PostID, PostTitle và PostUrl
SELECT PostID, PostTitle, PostUrl FROM tblPOST
GO

-- Truy vấn có sử dụng Order by
-- Trích xuất dữ liệu trong tblPOST và sắp xếp theo ngày giảm dần
-- Mục đích để hiển thị các bài viết theo thứ tự mới nhất đến cũ nhất trên trang chủ đáp ứng yêu cầu xem tin tức mới nhất trên website
SELECT PostID, PostTitle, PostExcerpt, PublishedDate FROM tblPOST ORDER BY PublishedDate DESC
GO

-- Truy vấn có sử dụng so sánh xâu ký tự
-- Trích xuất dữ liệu trong tblPOST có PostTitle chứa từ 'Italia' nằm bất cứ vị trí nào trong PostTitle
-- Mục đích để hiện thị những bài viết theo từ khóa tìm kiếm của người dùng, ở đây chứa từ Italia.
SELECT PostID, PostTitle, PostExcerpt, PublishedDate FROM tblPOST WHERE PostTitle like '%Italia%'
GO

-- Truy vấn có điều kiện thời gian
-- Trích xuất dữ liệu trong tblPOST là các bài viết được đăng trong tháng 7 năm 2020
-- Mục đích để hiển thị các bài viết đã đăng trong khoảng ngày được chọn bởi người xem
SELECT PostID, PostTitle, PostExcerpt, PublishedDate FROM tblPOST 
WHERE PublishedDate > '2020-07-01' AND PublishedDate < '2020-08-01'
GO

-- Truy vấn từ nhiều bảng sử dụng inner join
-- Khớp dữ liệu từ bảng tblCAT và tblPOST thông qua bảng tblCATPOST để xuất ra các dữ liệu là Post trong các category
-- Mục đích để hiển thị các bài viết theo nhóm danh mục (category) ngoại trừ các nhóm danh mục chưa có bài viết nào thì không được hiển thị
SELECT CatName, PostTitle, PostExcerpt FROM tblCAT
INNER JOIN tblCATPOST ON tblCAT.CatID = tblCATPOST.CatID
INNER JOIN tblPOST ON tblCATPOST.PostID = tblPOST.PostID
GO

-- Truy vấn từ nhiều bảng sử dụng outter join
-- Khớp toàn bộ các dòng dữ liệu từ bảng tblPOST với tblCOMMENT, nếu không có dữ liệu từ bảng tblCOMMENT khớp được với bảng tblPOST thì hiển thị NULL
-- Mục đích để hiển thị số lượng comment trong mỗi bài viết, thể hiện tính tương tác của các bài viết cho người xem.
SELECT PostTitle, PostExcerpt, COUNT(ComID) AS CommentCount FROM tblPOST
LEFT JOIN tblCOMMENT ON tblPOST.PostID = tblCOMMENT.PostID
GROUP BY PostTitle, PostExcerpt
GO

-- Truy vấn sử dụng except
-- Trích xuất dữ liệu từ bảng tblPOST có những PostID không xuất hiện trong bảng tblCOMMENT
-- Mục đích để lọc ra các bài viết có tương tác kém (chưa có comment nào) để có hướng cải thiện nội dung cho biên tập viên và phóng viên
SELECT PostID, PostTitle, PostUrl, PostExcerpt FROM tblPOST 
WHERE PostID IN (SELECT PostID FROM tblPOST
EXCEPT
SELECT PostID FROM tblCOMMENT)
GO

-- Truy vấn sử dụng truy vấn con (trong WHERE)
-- Truy vấn con trong WHERE trả về danh sách những PostEditor (khóa ngoại từ UserID) đã tương tác (đăng) các bài viết trong tblPOST
-- Truy vấn chính trả về dữ liệu của những USER có UserID xuất hiện trong danh sách trả về của truy vấn con
-- kết hợp bằng mệnh đề EXCEPT để trả về các USER chưa duyệt bất kì bài viết nào
SELECT * FROM tblUSER WHERE UserRole = 1
EXCEPT
SELECT * FROM tblUSER WHERE UserID IN (SELECT PostEditor FROM tblPOST WHERE PostStatus = 'Published')
GO

-- Truy vấn sử dụng WITH
-- Trong WITH có 2 alias query ComInPost và PostInCat
-- ComInPost trả về giá trị 2 thuộc tính là PostID và tổng số comment trong PostID đó (kể cả Post không có comment)
-- PostInCat kết hợp 2 bảng tblCAT và tblCATPOST để trả về giá trị 2 thuộc tính CatName và PostID, những CatName nào không có PostID sẽ không xuất hiện
-- Thực hiện truy vấn trả về danh sách các CatName và tổng số Comment có trong mỗi CatName này,
-- thông qua kết hợp (INNER JOIN) 2 alias ComInPost và PostInCat dựa trên PostID
WITH ComInPost(PostID, totalCom) AS
	(SELECT PostID, COUNT(ComID) AS totalCom FROM tblCOMMENT group by PostID),
	PostInCat(CatName, PostID) AS (SELECT CatName,PostID FROM tblCAT LEFT JOIN tblCATPOST ON tblCAT.CatID = tblCATPOST.CatID)

SELECT CatName,sum(totalCom) AS TotalCom FROM PostInCat INNER JOIN ComInPost ON PostInCat.PostID = ComInPost.PostID group by CatName
GO

-- Truy vấn sử dụng GROUP BY và HAVING
-- Mượn truy vấn đã thực hiện với WITH bên trên đã được GROUP BY CatName
-- Thêm điều kiện HAVING để trả về các CatName có tổng số comment >= 5
WITH ComInPost(PostID, totalCom) AS
	(SELECT PostID, COUNT(ComID) AS totalCom FROM tblCOMMENT group by PostID),
	PostInCat(CatName, PostID) AS (SELECT CatName,PostID FROM tblCAT LEFT JOIN tblCATPOST ON tblCAT.CatID = tblCATPOST.CatID)

SELECT CatName,sum(totalCom) AS TotalCom FROM PostInCat INNER JOIN ComInPost ON PostInCat.PostID = ComInPost.PostID 
GROUP BY CatName
HAVING SUM(totalCom) >= 5
GO

-- Truy vấn sử dụng function đã tạo
-- UDF đã tạo trước đó nhận parameter là một CatID và trả về giá trị INT là tổng số Post trong Category đó
SELECT *, dbo.fc_totalPostInCat(CatID) AS TotalPost FROM tblCAT