USE [NEWS_WEBSITE]
GO

INSERT INTO [dbo].[tblUSER] (UserID, UserName, UserMail, UserPass, RegisterDate, UserRole)
VALUES (1,'phoitran','phoitran@gmail.com','12345678','2020-01-01',1),
(2,'lanvu','lanvu@gmail.com','135792468','2020-03-10',1),
(3,'hieunguyen','hieunguyen@gmail.com','24681357','2020-05-11',2),
(4,'nhitran','nhitran@gmail.com','77491208','2020-05-12',2),
(5,'binhnguyen','binhnguyen@gmail.com','88641209','2020-07-15',3),
(6,'thaonhi','thaonhi@gmail.com','99811210','2020-07-21',3),
(7,'bichchi','bichchi@gmail.com','22441021','2020-07-31',2),
(8,'thanhtran','thanhtran@gmail.com','33991022','2020-09-12',3),
(9,'baonhi','baonhi@gmail.com','44161023','2020-12-12',2),
(10,'longnguyen','longnguyen@gmail.com','55251024','2021-01-30',3),
(11,'trangnguyen','trangnguyen@gmail.com','66362025','2021-02-18',3),
(12,'huynhngoc','huynhngoc@gmail.com','11211026','2021-04-16',3)
GO

INSERT INTO [dbo].[tblCAT] (CatID,CatName,CatUrl)
VALUES (1,'khac','khac'),
(2,'the thao','the-thao'),
(3,'showbiz','showbiz'),
(4,'me va be','me-va-be'),
(5,'suc khoe','suc-khoe'),
(6,'phap luat','phap-luat'),
(7,'thoi trang','thoi-trang'),
(8,'du lich','du-lich'),
(9,'bep nuc','bep-nuc'),
(10,'giao duc','giao-duc'),
(11,'cong nghe','cong-nghe')
GO

INSERT INTO [dbo].[tblMEDIA] (MedID,Title,MedUrl, CreatedDate, MediaType, Author)
VALUES (1,N'Tình hình covid ngày 3/7','media/tinh-hinh-covid-ngay-3-7','2020-7-3','image',3),
(2,N'tips chụp ảnh','media/tip-chup-anh','2020-7-4','image',4),
(3,N'style giới trẻ ngày MUJI','media/style-gioi-tre-ngay-muji','2020-7-5','image',4),
(4,N'Sao tuyển pháp miệt thị','media/sao-tuyen-phap-miet-thi','2021-7-1','image',7),
(5,N'Italia thắng thuyết phụ','media/italia-thang-thuyet-phuc','2021-7-2','image',7),
(6,N'Quên rửa nồi cơm','media/quen-rua-noi-com','2021-7-2','image',9),
(7,N'Ống hút dùng lại','media/ong-hut-dung-lai','2021-7-3','image',9),
(8,N'Người đẹp Trương Mỹ Nhân','media/nguoi-dep-truong-my-nhan','2021-7-3','image',9),
(9,N'Con gái Trương Ngọc Ánh','media/con-gai-truong-ngoc-anh','2021-7-3','image',9),
(10,N'Gia đình Hà Hồ , Đoan Trang','media/gia-dinh-ha-ho-doan-trang','2021-7-4','image',9)
GO

INSERT INTO tblPOST (PostID,PostTitle,PostUrl,PostExcerpt,PostContent,
						PublishedDate,CreatedDate,ModifiedDate,PostStatus,PostAuthor,
						PostEditor,FeatureImage)
VALUES (1,N'Ngày 3/7 ghi nhận số ca Covid-19 kỷ lục',N'3-7-ghi-nhan-so-ca-covid-ky-luc',N'Theo bản tin 18h ngày 3/7 của Bộ Y tế, Việt Nam có thêm 346 ca ghi nhận trong nước',N'1. Thông tin diễn biến dịch COVID-19 ở Việt Nam:

a. Tính từ 12h30 đến 18h ngày 03/7 có 353 ca mắc mới (BN18691-19043):

+ 07 ca cách ly ngay sau khi nhập cảnh tại Tây Ninh.

+ 346 ca ghi nhận trong nước tại TP. Hồ Chí Minh (250), Đồng Nai (32), Quảng Ngãi (16), Phú Yên (14), Tiền Giang (12), Nghệ An (7), Bình Dương (6), Bình Định (5), Bà Rịa - Vũng Tàu (4) ; trong đó 306 ca được phát hiện trong khu cách ly hoặc khu đã được phong toả.
- 248 bệnh nhân được công bố khỏi bệnh.','2020-7-3','2020-7-3','2020-7-3','published',3,1,1),
(2,N'Check vội 3 tips chụp ảnh thời trang cực ổn',N'check-3-tip-chup-anh-cuc-on',N'Vietnam Street Icon đang dần thu hút sự chú ý của các bạn trẻ Gen Z. Chúng mình mang tới một số tips khi chụp ảnh streetwear ""nhỏ nhưng có võ"" đây.',N'Vietnam Street Icon đang dần thu hút được sự chú ý của các bạn trẻ Gen Z, những người có gout thời trang sáng tạo và không giới hạn. Để giúp bạn thêm tự tin tham gia cuộc thi, chúng mình mang tới một số tips khi chụp ảnh streetwear ""nhỏ nhưng có võ"" đây. Cùng kéo xuống và ""note"" liền tay nhé!
Dĩ nhiên, ánh sáng tự nhiên là tuyệt vời nhất. Để có nguồn sáng vừa đủ, không bị quá gắt thì các bạn nên chọn khung giờ sáng hoặc chiều muộn nhé. Nếu chụp vào buổi trưa hay đầu giờ chiều thì ánh sáng hay bị gắt và chói lắm đó. ','2020-7-4','2020-7-4','2020-7-4','published',4,2,2),
(3,N'Soi style giới trẻ ngày khai trương MUJI',N'soi-style-gioi-tre-ngay-khai-truong-muji',N'Các bạn trẻ khoe trọn khả năng phối đồ đỉnh cao trong buổi khai trương MUJI Hà Nội sáng nay.',N'Các bạn trẻ khoe trọn khả năng phối đồ đỉnh cao trong buổi khai trương MUJI Hà Nội sáng nay.
Nóng hơn cả 40 độ ngoài kia, MUJI Hà Nội đã thu hút hàng nghìn người đến tham quan, mua sắm ngay trong buổi sáng khai trương. Hòa mình vào không khí nhộn nhịp, các bạn trẻ đã đến đây xếp hàng từ rất sớm, diện lên người hàng loạt những outfit mang phong cách khác nhau.
Dẫu có đeo khẩu trang kín mặt, thần thái cô bạn này vẫn không hề giảm đi chút nào. Khoác ngoài áo 2 dây là 1 chiếc crop top trắng tay dài, phối cùng quần túi hộp ngầu đét bên dưới, cô bạn nhờ thế mà trông cao ráo, chuẩn đẹp hẳn lên.','2020-7-5','2020-7-5','2020-7-5','published',4,2,3),
(4,N'Biến căng: Sao tuyển Pháp miệt thị nhân viên người Nhật Bản?',N'sao-tuyen-phap-miet-thi-nhan-vien-nhat-ban',N'Những lùm xùm liên quan đội tuyển Pháp diễn ra cả trong và ngoài sân cỏ tại kỳ Euro lần này.',N'Thay vì lựa chọn thi đấu tốt, tiến sâu và giành chức vô địch thì tất cả những gì đọng lại với người hâm mộ bóng đá Pháp cho đến thời điểm này chỉ toàn là nỗi thất vọng. Sau khi bị Thụy Sĩ loại là nội bộ lục đục, còn bây giờ là nghi vấn phân biệt chủng tộc đến từ Antoine Griezmann và Ousmane Dembélé.
Mới đây, tài khoản Twitter có tên Nahidul vừa đăng tải một video, trong đó cho thấy hai ngôi sao tấn công của FC Barcelona tỏ rõ thái độ chế giễu và cười cợt đối với những nhân viên sửa chữa của khách sạn.','2021-7-1','2021-7-1','2021-7-1','published',7,1,4),
(5,N'Tiền đạo tuyển Bỉ tấu hài, Italy thắng thuyết phục',N'tien-dao-bi-tau-hai',N'Đánh bại Bỉ với tỷ số 2-1, Italy sẽ gặp Tây Ban Nha ở bán kết Euro 2020.',N'90+7: HẾT GIỜ!!! Italy giành chiến thắng với tỷ số 2-1. Họ giành quyền vào bán kết và sẽ gặp ĐT Tây Ban Nha. Chiến thắng hoàn toàn xứng đáng cho Italy.
90: 5 phút bù giờ, nhưng trận đấu liên tục bị gián đoạn bởi những tình huống nằm sân của Donnarumma.
83: KHÔNG VÀO!!! Doku đột phá bên phía cánh trái rồi tung ra cú dứt điểm quyết đoán đưa bóng đi vọt xà.
77: Spinazzola bất ngờ gặp một chấn thương nghiêm trọng sau nỗ lực chạy theo bóng. Anh bật khóc và được đưa rời sân bằng cáng.','2021-7-2','2021-7-2','2021-7-2','published',7,1,5),
(6,N'Thêm một pha sinh viên về quê quên rửa nồi cơm',N've-que-quen-rua-noi-com',N'Quên gì thì quên chứ không được quên rửa nồi cơm nhé…',N'Một câu gen Z hay dặn nhau độ mấy tháng gần đây là “Nhớ rửa nồi cơm!”. Câu nói này ra đời sau vài vụ nồi cơm mốc meo do bị bỏ quên một thời gian dài, mở ra khiến cả MXH váng đầu! Bối cảnh thì hầu như đều là do sinh viên về quê ăn Tết, nghỉ dịch, đi du lịch xong quên mất nồi cơm vẫn chưa rửa. Tới khi quay trở lại thì bốc mùi 7 gian nhà 3 gian bếp.

Nối tiếp nhiều pha gây sốc trước đó, mới đây một anh chàng tiếp tục khiến dân mạng chao đảo với chiếc nồi cơm sau khi nghỉ dịch. Nồi cơm này trước đây thổi gạo lứt, và đây là kết quả…','2021-7-2','2021-7-2','2021-7-2','published',9,2,6),
(7,N'Xôn xao 1 hàng bún đậu nổi tiếng ở Hà Nội bị khách tố xài lại ống hút',N'hang-bun-dau-bi-to-xai-lai-ong-hut',N'Bài đăng của cô gái này tố hàng bún đậu dùng lại ống hút hiện đang khiến nhiều thực khách ai nấy đều rùng mình.',N'Bún đậu mắm tôm có thể nói là món ăn khoái khẩu của không ít người. Đặc biệt là ở Hà Nội, món ăn này được cho là khá bình dân, dễ ăn, được lòng đại đa số từ những người lao động cho đến dân văn phòng. Trưa về mà không biết ăn cái gì, thế nào đồng nghiệp cũng rủ rê làm mâm bún đậu cho mà xem.
Tuy nhiên, do tình hình dịch bệnh vẫn đang diễn biến phức tạp, nhiều người chọn hình thức ship về nhà ăn. Nhiều hàng quán cũng vì thế mà kém trau chuốt hơn, vậy nên thời gian gần đây mới có chuyện trên các hội nhóm review đồ ăn, những bài đấu tố về các hàng quán ship về mọc lên như nấm.','2021-7-3','2021-7-3','2021-7-3','published',9,2,7),
(8,N'Trương Mỹ Nhân - người đẹp phải ""còng lưng"" trả nợ cho mẹ',N'truong-my-nhan-cong-lung-tra-no-cho-me',N'Chia sẻ mới đây của Trương Mỹ Nhân đã khiến nhiều người vô cùng bàng hoàng vì không ngờ mỹ nhân này lại có cuộc sống phức tạp như vậy.',N'Mới đây nhất, người đẹp Trương Mỹ Nhân bất ngờ đăng đàn đề nghị các chủ nợ nếu muốn đòi nợ thì gặp trực tiếp mẹ cô - người đã mượn nợ để phục vụ cho việc đánh đề & bài bạc: ""Riêng bản thân tôi đã trả nợ cho mẹ tôi từ khi tôi bắt đầu kiếm tiền được vào năm 16 tuổi. Đến bây giờ là 10 năm, con số chắc phải lên đến vài tỷ từ đấy đến giờ. Hiện tôi vẫn phải trả nợ ngân hàng 300 triệu cho món nợ cách đây 3-4 năm (trả góp 10 năm trả 4triệu/ tháng). Tôi vừa trả gần 200 triệu cách đây chưa được 4 tháng vẫn đang giai đoạn góp trả dần.','2021-7-3','2021-7-3','2021-7-3','published',9,2,8),
(9,N'Con gái Trương Ngọc Ánh gây sốt khi đi dạo phố ở Mỹ',N'con-gai-truong-ngoc-anh-dao-pho-o-my',N'Biết là khen mãi rồi nhưng phải thừa nhận bé Bảo Tiên ắt hẳn sẽ trở thành đối thủ đáng gờm tại các cuộc thi nhan sắc trong tương lai.',N'Thừa hưởng nét đẹp từ bố mẹ đều là người nổi tiếng, Bảo Tiên nhà Trương Ngọc Ánh và chồng cũ Trần Bảo Sơn được dự đoán sẽ là mỹ nhân đình đám trong tương lai. Mới 13 tuổi, Bảo Tiên đã cao 1m62, bé có gu ăn mặc sành điệu, thần thái ngời ngời nên luôn trở thành tâm điểm mỗi lúc lộ diện.
Nhân dịp nghỉ hè, Bảo Tiên đã cùng bố Trần Bảo Sơn sang Mỹ thăm ông bà nội và tranh thủ vui chơi, tham quan tại New York. Chẳng cần ăn diện lộng lẫy, con gái Trương Ngọc Ánh mặc quần jean, áo phông để phô diễn trọn lợi thế là đôi chân dài cũng đủ gây sốt.','2021-7-3','2021-7-3','2021-7-3','published',9,2,9),
(10,N'Gia đình Hà Hồ - Đoan Trang hội ngộ, spotlight đổ dồn vào 2 nhóc tỳ',N'gia-dinh-ha-ho-doan-trang-hoi-ngo',N'Subeo nhà Hà Hồ quả là em bé vui tính, mỗi lần chụp ảnh cùng mẹ đều chiếm spotlight với biểu cảm nhí nhố.',N'Mới đây, Đoan Trang bất ngờ đăng tải khoảnh khắc gặp gỡ cuối tuần cùng gia đình Hà Hồ. Có thể thấy mẹ bầu Hà Hồ và Đoan Trang tỏ ra rất vui vẻ và hào hứng khi chụp ảnh cùng dàn nhóc tỳ. Bé Sol nhà Đoan Trang tiếp tục ghi điểm bởi nét đẹp lai Tây, mái tóc dài và nụ cười thân thiện.
Tuy nhiên, lần này toàn bộ spotlight lại đổ dồn về biểu cảm nhí nhố và cực đáng yêu của bé Subeo. Dễ dàng nhận ra, Subeo đang rất thích thú, cậu bé tự tin nhìn thẳng vào ống kính và không ngại ""tự dìm"" khiến mẹ Hà Hồ phải bật cười khoái chí.','2021-7-4','2021-7-4','2021-7-4','published',9,2,10)
GO

INSERT INTO [dbo].[tblCOMMENT] (ComID, PostID, ComAuthor, ComParent, ComContent, CreatedDate)
VALUES (1,1,12,NULL,'moi nguoi can than, giu gin suc khoe va an toan cho ban than nhe','2021-07-04'),
(2,1,10,1,'tien khong kiem luc nay thi luc khac kiem, suc khoe thi khong duoc dau','2021-07-04'),
(3,10,8,NULL,'hai gia dinh nhin hanh phuc ghe','2021-07-04'),
(4,10,10,3,'de duoc dua con mat long mat da','2021-07-04'),
(5,10,12,3,'me cung xinh ma con cung xinh','2021-07-04'),
(6,7,5,NULL,'quy than oi, ong hut co bao nhieu tien dau ma hai nguoi qua, lo lay benh gi thi sao','2021-07-04'),
(7,7,7,6,'biet la thoi buoi kho khan, nhung lam vay cung dau giau them duoc mieng nao','2021-07-04'),
(8,7,11,NULL,'chu quan that khong biet suy nghi, chi biet ban than minh thoi','2021-07-04'),
(9,7,6,NULL,'tay chay quan nay, va keu goi ca gia dinh tay chay luon','2021-07-04'),
(10,7,7,9,'tay chay thi ac qua, nguoi ta cung muon kiem mieng com thoi. Biet loi roi thi thoi.','2021-07-04')
GO

INSERT INTO [dbo].[tblCATPOST] (PostID,CatID,PostCount)
VALUES (1,5,1),(2,7,1),(3,7,2),(4,2,1),(5,2,2),(6,9,1),(7,9,2),(7,5,2),(8,3,1),(9,3,2),(9,4,1),(10,3,3),(10,4,2)
GO