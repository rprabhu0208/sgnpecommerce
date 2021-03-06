USE [master]
GO
/****** Object:  Database [SGNP_Ecommerce]    Script Date: 18-12-2014 15:22:18 ******/
CREATE DATABASE [SGNP_Ecommerce]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SGNP_Ecommerce', FILENAME = N'D:\DBFiles\MDF\SGNP_Ecommerce.mdf' , SIZE = 6144KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SGNP_Ecommerce_log', FILENAME = N'D:\DBFiles\LDF\SGNP_Ecommerce_log.ldf' , SIZE = 52416KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SGNP_Ecommerce] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SGNP_Ecommerce].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SGNP_Ecommerce] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SGNP_Ecommerce] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SGNP_Ecommerce] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SGNP_Ecommerce] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SGNP_Ecommerce] SET ARITHABORT OFF 
GO
ALTER DATABASE [SGNP_Ecommerce] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SGNP_Ecommerce] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [SGNP_Ecommerce] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SGNP_Ecommerce] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SGNP_Ecommerce] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SGNP_Ecommerce] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SGNP_Ecommerce] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SGNP_Ecommerce] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SGNP_Ecommerce] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SGNP_Ecommerce] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SGNP_Ecommerce] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SGNP_Ecommerce] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SGNP_Ecommerce] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SGNP_Ecommerce] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SGNP_Ecommerce] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SGNP_Ecommerce] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SGNP_Ecommerce] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SGNP_Ecommerce] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SGNP_Ecommerce] SET RECOVERY FULL 
GO
ALTER DATABASE [SGNP_Ecommerce] SET  MULTI_USER 
GO
ALTER DATABASE [SGNP_Ecommerce] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SGNP_Ecommerce] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SGNP_Ecommerce] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SGNP_Ecommerce] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'SGNP_Ecommerce', N'ON'
GO
USE [SGNP_Ecommerce]
GO
/****** Object:  User [dbdeveloper]    Script Date: 18-12-2014 15:22:18 ******/
CREATE USER [dbdeveloper] FOR LOGIN [dbdeveloper] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [dbdeveloper]
GO
/****** Object:  StoredProcedure [dbo].[SP_AddImageDetails]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AddImageDetails]
(
	@ProductId			NVARCHAR(100)
	,@ImagePath			NVARCHAR(100)
	,@ImageOrder		NVARCHAR(100)
)
----------------------------------------------------------------------
-- Author:		<Vipul>
-- Create date: <11/10/2014>
-- Description:	<Insert Image Details>
-----------------------------------------------------------------------
AS
BEGIN		
		INSERT INTO dbo.ImageDetails
		(
			ProductID
			,ImagePath
			,Priority
			,IsActive
			,CreatedDate
		)
		VALUES
		(
			@ProductId
			,@ImagePath
			,@ImageOrder
			,1
			,GETDATE()
		)		
END


GO
/****** Object:  StoredProcedure [dbo].[SP_AddOTPDetails]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_AddOTPDetails]  

(  

@RandomNo bigint = null,
@CurrentTime  datetime = null,
@userid  bigint
)  

AS  

BEGIN  

 SET NOCOUNT Off;  
		
		update UserMaster set RandomNo =@RandomNo , currenttime =@CurrentTime where UserID  =@userid
  

end
GO
/****** Object:  StoredProcedure [dbo].[SP_AddProductDetails]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AddProductDetails]
(
	@SubCategory				INT
	,@ProductName_LL			NVARCHAR(100)	= NULL
	,@ProductName				NVARCHAR(100)	= NULL
	,@ProductDescription_LL		NVARCHAR(1000)	= NULL
	,@ProductDescription		NVARCHAR(1000)	= NULL
	,@ProductSize_LL			NVARCHAR(1000)	= NULL
	,@ProductSize				NVARCHAR(50)	= NULL
	,@ProductWeight_LL			NVARCHAR(50)	= NULL
	,@ProductWeight				NVARCHAR(20)	= NULL
	,@Author_LL					NVARCHAR(20)	= NULL
	,@Author					NVARCHAR(100)	= NULL
	,@Publisher_LL				NVARCHAR(100)	= NULL
	,@Publisher					NVARCHAR(100)	= NULL
	,@Language_LL				NVARCHAR(100)	= NULL
	,@Language					NVARCHAR(100)	= NULL
	,@Pages						INT				= NULL
	,@Price						DECIMAL(10,2)	= NULL
	,@Thumbnail					NVARCHAR(300)	= NULL
	,@Quantity					INT				= 0
	,@CreatedBy					INT				= 1
	,@ClientId					INT				= 1	
	,@ProductID					INT				= NULL
	,@IsActive					BIT				= 0
	,@Base_Price				DECIMAL(18,2)	= 0
	,@MahaonlineCharges			DECIMAL(18,2)	= 0
	,@ShippingCharges			DECIMAL(18,2)	= 0
	,@VAT						INT				= 0
	,@ServiceTax				INT				= 0
)
----------------------------------------------------------------------
-- Author:		<Vipul>
-- Create date: <01/09/2014>
-- Description:	<Insert Product Details>
-----------------------------------------------------------------------
AS
BEGIN
	DECLARE @intErrorCode	INT
			,@intProducId	INT
			
	BEGIN TRAN ProductDetails
	IF EXISTS(SELECT ProductID FROM dbo.ProductMaster WHERE ProductID=@ProductID)
	BEGIN
			UPDATE	dbo.ProductMaster
			SET		ProductName_LL				=		@ProductName_LL
					,ProductName				=		@ProductName
					,ProductDescription_LL		=		@ProductDescription_LL
					,ProductDescription			=		@ProductDescription
					,ProductSize_LL				=		@ProductSize_LL
					,ProductSize				=		@ProductSize
					,ProductWeight_LL			=		@ProductWeight_LL
					,ProductWeight				=		@ProductWeight
					,Author_LL					=		@Author_LL
					,Author						=		@Author
					,Publisher_LL				=		@Publisher_LL
					,Publisher					=		@Publisher
					,Language_LL				=		@Language_LL
					,Language					=		@Language
					,Pages						=		@Pages
					,Price						=		@Price
					,Thumbnail					=		@Thumbnail
					,ModifiedBy					=		@CreatedBy
					,ModifiedDate				=		GETDATE()
					,IsActive					=		@IsActive
					,BasePrice					=		@Base_Price
					,MahaonlineCharges			=		@MahaonlineCharges
					,ShippingCharges			=		@ShippingCharges
					,VAT						=		@VAT
					,ServiceTax					=		@ServiceTax
			WHERE	
					ProductID=@ProductID
			 SELECT @intProducId = @ProductID
	END 
	ELSE
	BEGIN
			INSERT INTO	dbo.ProductMaster
			(
				SubCategoryID
				,ProductName_LL
				,ProductName
				,ProductDescription_LL
				,ProductDescription
				,ProductSize_LL
				,ProductSize
				,ProductWeight_LL
				,ProductWeight
				,Author_LL
				,Author
				,Publisher_LL
				,Publisher
				,Language_LL
				,Language
				,Pages
				,Price
				,Thumbnail
				,CreatedBy
				,CreatedDate
				,ClientID
				,IsActive
				,BasePrice
				,MahaonlineCharges
				,ShippingCharges
				,VAT
				,ServiceTax
			)
			VALUES
			(
				@SubCategory					
				,@ProductName_LL	
				,@ProductName		
				,@ProductDescription_LL		
				,@ProductDescription		
				,@ProductSize_LL			
				,@ProductSize				
				,@ProductWeight_LL			
				,@ProductWeight				
				,@Author_LL					
				,@Author					
				,@Publisher_LL				
				,@Publisher					
				,@Language_LL				
				,@Language					
				,@Pages						
				,@Price						
				,@Thumbnail					
				,@CreatedBy	
				,GETDATE()
				,@ClientId
				,1
				,@Base_Price
				,@MahaonlineCharges
				,@ShippingCharges
				,@VAT
				,@ServiceTax
			)
			
			
			SELECT @intProducId = @@IDENTITY
			
			--INSERT INTO dbo.StockMaster
			--(
			--	ProductID
			--	,Quantity
			--	,ClientID
			--	,CreatedBy
			--	,CreatedDate
			--)
			--VALUES
			--(
			--	@intProducId
			--	,@Quantity
			--	,@ClientId
			--	,@CreatedBy
			--	,GETDATE()
			--)
		END
		SELECT @intErrorCode = @@ERROR
		IF (@intErrorCode <> 0) GOTO PROBLEM
		COMMIT TRAN
		PROBLEM:
		IF (@intErrorCode <> 0) 
		BEGIN
				PRINT 'Unexpected error occurred!'
		ROLLBACK TRAN
		END	
		
		IF(@intProducId >0)
		BEGIN
				SELECT @intProducId AS ProductId 
		END
		ELSE
		BEGIN
				SELECT 0 AS ProductId 
		END
END


GO
/****** Object:  StoredProcedure [dbo].[SP_AddProductProperties]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_AddProductProperties]
(
	@ProductId			NVARCHAR(100)
	,@ProductDetailId   NVARCHAR(100)
	,@Product_Size		NVARCHAR(100)
	,@Product_Unit		NVARCHAR(100)
	,@Product_Quantity	NVARCHAR(100)
)
----------------------------------------------------------------------
-- Author:		<Vipul>
-- Create date: <01/09/2014>
-- Description:	<Insert Product Properties>
-----------------------------------------------------------------------
AS
BEGIN		
	DECLARE @intErrorCode	INT
			,@intProducId	INT
	BEGIN TRAN PRODUCTDETAILS
	IF EXISTS(SELECT ProductDetailID FROM dbo.ProductDetails WHERE ProductDetailID =@ProductDetailId)
	BEGIN
		UPDATE DBO.PRODUCTDETAILS 
		SET Size = @Product_Size
			,Unit = @Product_Unit
			,Quantity = @Product_Quantity
			WHERE ProductDetailID = @ProductDetailId

		SELECT @intProducId = @ProductDetailId
	END
	ELSE
		INSERT INTO dbo.ProductDetails
		(
			ProductID
			,Size
			,Unit
			,Quantity
			,CreatedDate
		)
		VALUES
		(
			@ProductId
			,@Product_Size
			,@Product_Unit
			,@Product_Quantity			
			,GETDATE()
		)	
		INSERT INTO dbo.StockMaster	
		(
			ProductID
			,Quantity
			,CreatedDate
		)
		VALUES
		(
			@ProductId
			,@Product_Quantity	
			,GETDATE()
		)
	END
	SELECT @intErrorCode = @@ERROR
		IF (@intErrorCode <> 0) GOTO PROBLEM
		COMMIT TRAN
		PROBLEM:
		IF (@intErrorCode <> 0) 
		BEGIN
				PRINT 'Unexpected error occurred!'
		ROLLBACK TRAN
		END	
		
		IF(@intProducId >0)
		BEGIN
				RETURN 1  
		END
		ELSE
		BEGIN
			RETURN	0
		END

GO
/****** Object:  StoredProcedure [dbo].[SP_AddQuickAdv]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Dineshd>
-- Create date: <Create Date,04.10.2014>
-- Description:	<Description,To get Quick Advertisements on Home Page>
-- =============================================
CREATE PROCEDURE [dbo].[SP_AddQuickAdv]
	@Productid bigint,
	@Priority int,
	@ImagePath nvarchar(500),
	@id int
AS
BEGIN
	
	SET NOCOUNT ON;
	if Exists(select ID from QuickAdv where ID=@id)
		Begin
		
			update QuickAdv set Productid=@Productid ,Priority=@Priority,ImagePath=@ImagePath where ID=@id;
		End		
		else
		Begin
			insert into QuickAdv values(@Productid,@Priority,@ImagePath,null,GETDATE())
		End
	END


	--select * from QuickAdv
	--delete from QuickAdv where ID=39



GO
/****** Object:  StoredProcedure [dbo].[SP_AddTransactionPaymentDetails]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_AddTransactionPaymentDetails]

--@PaymentId	bigint ,
@UniqueNo	bigint
,@ApplicationTransactionID	bigint
,@TransactionID	nvarchar(400)
,@BankTransactionID	nvarchar(400)
,@BankTransactionRefNo nvarchar(1000)
,@Amount	decimal(18,9)
,@PortalFee	decimal(18,9)
,@TotalAmount	decimal(18,9)
,@AmountInWords	nvarchar(2000)
,@PaymentDate	datetime
,@PayeeName	nvarchar(2000)

AS
BEGIN
	SET NOCOUNT ON;

 declare @PayFlag	char(1),@PayMode	char(1),@Createddate	datetime  , @ApplicantName	nvarchar(2000) , @email nvarchar(500) ,@PaymentId	bigint 
	
 set @ApplicantName = (select ApplicantName from ShootingPermission where receiptid = @ApplicationTransactionID)
 set @email = (select email from ShootingPermission where receiptid = @ApplicationTransactionID)
 --set @PaymentId = Scope_Identity()

--	SET IDENTITY_INSERT [dbo].[PaymentOfShooting] ON


		INSERT INTO [dbo].PaymentOfShooting
						( TxnUniqueNo,applicantid,PGTransactionID,
				PaymentTransactionID ,	BankTransactionRefNo,	Amount,	PortalFee,	TotalAmount,
				AmountInWords,	PaymentDate,	 PayeeName,	 ApplicantName ,PayFlag ,	PayMode ,	Createddate , email
				)
		values
		(		@UniqueNo , @ApplicationTransactionID , @TransactionID,@BankTransactionID ,@BankTransactionRefNo, @Amount,@PortalFee,@TotalAmount,@AmountInWords
		,@PaymentDate,@PayeeName	, @ApplicantName , 'Y','G' , getdate() , @email)
	
--	SET IDENTITY_INSERT [dbo].[PaymentOfShooting] OFF

update ShootingPermission set shootdone = 1 where receiptid = @ApplicationTransactionID
	End

	





GO
/****** Object:  StoredProcedure [dbo].[SP_AdminLogin]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--exec SP_AdminLogin 'Lekha','Pass@123'



CREATE PROCEDURE [dbo].[SP_AdminLogin]

@UserName nvarchar(100),
@flag nvarchar(100) = null
--@UserPassword nvarchar(100)

as 

BEGIN
	
	Declare @Random Varchar(50)  
    set @Random = convert(nvarchar(50),NEWID())            


	 update UserMaster set ForgotPasswordToken= @Random where UserName =@UserName

	 if(@flag ='Login')
	 begin

	select IsLocked, UserID,UserName,eMail,UserPassword,u.RoleID,u.ClientID,u.IsActive,ForgotPasswordToken , u.Mobile_No , u.eMail from UserMaster u with (nolock)

    join clientmaster c with (nolock) on u.ClientID=c.ClientID

	join RoleMaster r with (nolock) on r.roleid =u.roleid
	 where u.UserName=@UserName and (IsLocked = 0 or IsLocked is null)
	 	 
	 --and u.UserPassword=@UserPassword
	 end

	 else
	begin	
		select IsLocked, UserID,UserName,eMail,UserPassword,u.RoleID,u.ClientID,u.IsActive,ForgotPasswordToken , u.Mobile_No , u.eMail from UserMaster u with (nolock)

    join clientmaster c with (nolock) on u.ClientID=c.ClientID

	join RoleMaster r with (nolock) on r.roleid =u.roleid
	 where u.UserName=@UserName 

	 

	 end

END





GO
/****** Object:  StoredProcedure [dbo].[SP_Category]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Reshma>
-- Create date: <30/8/2014>
-- Description:	<Add Update Delete category>
-- =============================================
-- exec [SP_Category] 0,'Books','',1,1
--delete from CategoryMaster where CategoryName='books'
--select * from CategoryMaster
--select * from subcategory
--update CategoryMaster set CategoryName='books' where CategoryID=30
--update SubCategory set CategoryID=30 where SubCategoryID=1
CREATE PROCEDURE [dbo].[SP_Category] 
@CategoryID bigint,
@CategoryName  nvarchar(200),
@CategoryNameLL  nvarchar(200),
@ClientID int,
@IsActive Bit

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	if Exists(select CategoryID from CategoryMaster where CategoryID=@CategoryID or CategoryName=@CategoryName)
	Begin
	print 'update' 
		Update [dbo].[CategoryMaster] set CategoryName_LL=@CategoryNameLL,CategoryName=@CategoryName,IsActive=@IsActive where CategoryID=@CategoryID and ClientID=@ClientID			

	end
	else
	Begin	
	print 'insert'		
		INSERT INTO [dbo].[CategoryMaster]([CategoryName_LL],[CategoryName],[ClientID],[IsActive])
		values
        (@CategoryNameLL, @CategoryName,@ClientID,@IsActive)
	End
END



--select * from CategoryMaster
--select * from SubCategory
delete from CategoryMaster where CategoryID in(54)
GO
/****** Object:  StoredProcedure [dbo].[SP_ChangePassword]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ChangePassword]

@UserID bigint


as 

BEGIN

	SET NOCOUNT ON;

select userpassword from usermaster where UserID = @UserID


end








GO
/****** Object:  StoredProcedure [dbo].[SP_ChangePasswordForCustomer]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[SP_ChangePasswordForCustomer]

@CustomerID uniqueidentifier


as 

BEGIN

	SET NOCOUNT ON;

select Password from Customer where CustomerID = @CustomerID


end

GO
/****** Object:  StoredProcedure [dbo].[SP_CheckEmailExist]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Rohan>
-- Create date: <08-10-2014>
-- Description:	<Check existing email id>
-- =============================================
CREATE PROCEDURE [dbo].[SP_CheckEmailExist]
	-- Add the parameters for the stored procedure here
	@EmailID nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT COUNT(*) cnt FROM Customer where EmailID =@EmailID
END

GO
/****** Object:  StoredProcedure [dbo].[SP_CheckRegisterMailID]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_CheckRegisterMailID]

@EmailID  Nvarchar(50)=null

as 

BEGIN

select Emailid from Customer where EmailID =@EmailID

end

GO
/****** Object:  StoredProcedure [dbo].[SP_CheckWhetherPaymentDone]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CheckWhetherPaymentDone]

@ReceiptID  bigint =null

as 

BEGIN

	select shootdone ,isrejected ,isapproved	from ShootingPermission s

	where s.ReceiptID =@ReceiptID --and shootdone = 1


END









GO
/****** Object:  StoredProcedure [dbo].[SP_Courier]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Dinesh>
-- Create date: <10/11/2014>
-- Description:	<Add Updte Courier Details>
-- =============================================

CREATE PROCEDURE [dbo].[SP_Courier]
	 @CourierID			BIGINT=NULL
	,@CourierName		NVARCHAR(200)
	,@BranchName		NVARCHAR(100)
    ,@Address			NVARCHAR(300)
    ,@Phone				NVARCHAR(15)
    ,@Mobile			NVARCHAR(10)
	,@Email				NVARCHAR(100)
	,@IsActive			Bit
	,@CreatedBy			BIGINT
	,@UserName			int OUTPUT
	,@OTP				int OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @intErrorCode INT;

	BEGIN TRAN
	IF EXISTS(SELECT CourierID FROM CourierMaster WHERE CourierID=@CourierID)
	BEGIN
		
		UPDATE
			[dbo].[CourierMaster] 
		
		SET
			CourierName=@CourierName,
			BranchName=@BranchName,
			Address=@Address,
			Phone=@Phone,
			Mobile=@Mobile,	
			IsActive=@IsActive,
			Email=@Email
		WHERE
			CourierID=@CourierID

		SELECT @intErrorCode=@@ERROR

		set @UserName=0;
		set @OTP=0;
	END
	ELSE
	BEGIN

		---- Random Password Generation -----\\\\

		DECLARE @EncryptPassword VARCHAR(32);

		SELECT @OTP = Convert(int, RAND() * 1000000000)

		SELECT @intErrorCode=@@ERROR

		SELECT @EncryptPassword = CONVERT(VARCHAR(32), HashBytes('MD5', CONVERT(VARCHAR(100), @OTP)), 2)

		SELECT @intErrorCode=@@ERROR

		---- Random Password Generation -----////

	
		---- Random Username Generation -----\\\\

		SELECT @UserName = Convert(int, RAND() * 1000000000)

		SELECT @intErrorCode=@@ERROR

		---- Random Username Generation -----/////

			DECLARE @newUserId BIGINT;

			INSERT INTO [dbo].UserMaster
			(
				UserName,eMail,UserPassword,RoleID,ClientID,IsActive,CreatedBy,CreatedDate,Mobile_No,IsOTP
			)
		
			VALUES 
			(
				@UserName ,@Email,@EncryptPassword,12,1,@IsActive,@CreatedBy,GETDATE(),@Mobile,1
			)

			select @newUserId = Scope_Identity()

			SELECT @intErrorCode=@@ERROR

			INSERT INTO [dbo].[CourierMaster]
			(
				 CourierName
				,BranchName
				,[Address]
				,Phone
				,Mobile
				,Email
				,IsActive
				,CreatedBy
				,CreatedOn
				,UserPassword
				,IsOTP
				,UserID
			)

			VALUES
			(
				 @CourierName
				,@BranchName
				,@Address
				,@Phone
				,@Mobile
				,@Email
				,@IsActive
				,@CreatedBy
				,GETDATE()
				,@EncryptPassword
				,1
				,@newUserId
			)

			SELECT @intErrorCode=@@ERROR

	END

	IF (@intErrorCode <> 0) GOTO PROBLEM

	COMMIT TRAN

	PROBLEM:
	IF (@intErrorCode <> 0)
	BEGIN
		PRINT 'Unexpected error occurred!'
		ROLLBACK TRAN
	END
END


GO
/****** Object:  StoredProcedure [dbo].[SP_CreateCategoryMenu]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC [SP_CreateCategoryMenu]
CREATE PROCEDURE [dbo].[SP_CreateCategoryMenu]
@langid int =0
----------------------------------------------------------------------
-- Author:		<Reshma>
-- Create date: <14/11/2014>
-- Description:	<Get Category Details>
-----------------------------------------------------------------------
AS
BEGIN

		DECLARE @MenuTempTable TABLE(MenuID bigint identity(1,1) not null, MenuName VARCHAR(200),CategoryID bigint not null,Title NVARCHAR(200),ParentID bigint, SubCategoryID bigint not null)
		
		INSERT INTO @MenuTempTable(MenuName,CategoryID,Title,ParentID,SubCategoryID) SELECT CM.CategoryName AS MenuName, CM.CategoryID as CategoryID,  case @langid when 1 then cm.CategoryName_LL else cm.CategoryName end AS Title,0 as ParentID, 0 as SubCategoryID from CategoryMaster CM WHERE CM.IsActive=1

		DECLARE @TempTable TABLE(MenuID bigint identity(1,1) not null, MenuName VARCHAR(200),CategoryID bigint not null,Title NVARCHAR(200),ParentID bigint, SubCategoryID bigint not null)

		INSERT INTO @TempTable(MenuName,CategoryID,Title,ParentID,SubCategoryID) SELECT MenuName, CategoryID,Title,ParentID,SubCategoryID from @MenuTempTable

		INSERT INTO @TempTable(MenuName,CategoryID,Title,ParentID,SubCategoryID) SELECT S.SubCategoryName as MenuName, S.CategoryID AS CategoryID, case @langid when 1 then s.SubCategoryName_LL else s.SubCategoryName end AS Title, tt.MenuID as ParentID, s.SubCategoryID
		FROM SubCategory S LEFT OUTER JOIN @TempTable tt ON s.CategoryID = tt.CategoryID WHERE S.IsActive=1

		SELECT * from @TempTable
END


GO
/****** Object:  StoredProcedure [dbo].[SP_CreateCategoryMenuDemo]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC [SP_CreateCategoryMenuDemo]
CREATE PROCEDURE [dbo].[SP_CreateCategoryMenuDemo]
@langid int =1
----------------------------------------------------------------------
-- Author:		<Reshma>
-- Create date: <14/11/2014>
-- Description:	<Get Category Details>
-----------------------------------------------------------------------
AS
BEGIN

		DECLARE @MenuTempTable TABLE(MenuID bigint identity(1,1) not null, MenuName VARCHAR(200),CategoryID bigint not null,Title NVARCHAR(200),ParentID bigint, SubCategoryID bigint not null)
		
		INSERT INTO @MenuTempTable(MenuName,CategoryID,Title,ParentID,SubCategoryID) SELECT CM.CategoryName AS MenuName, CM.CategoryID as CategoryID, case @langid when 1 then cm.CategoryName_LL else cm.CategoryName end AS Title,0 as ParentID, 0 as SubCategoryID from CategoryMaster CM  

		DECLARE @TempTable TABLE(MenuID bigint identity(1,1) not null, MenuName VARCHAR(200),CategoryID bigint not null,Title NVARCHAR(200),ParentID bigint, SubCategoryID bigint not null)

		INSERT INTO @TempTable(MenuName,CategoryID,Title,ParentID,SubCategoryID) SELECT MenuName, CategoryID,Title,ParentID,SubCategoryID from @MenuTempTable

		INSERT INTO @TempTable(MenuName,CategoryID,Title,ParentID,SubCategoryID) SELECT S.SubCategoryName as MenuName, S.CategoryID AS CategoryID, case @langid when 1 then s.SubCategoryName_LL else s.SubCategoryName end AS Title, tt.MenuID as ParentID, s.SubCategoryID
		FROM SubCategory S LEFT OUTER JOIN @TempTable tt ON s.CategoryID = tt.CategoryID

		SELECT * from @TempTable
END



GO
/****** Object:  StoredProcedure [dbo].[SP_CreateCategoryMenuTest]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC [SP_CreateCategoryMenu]
create PROCEDURE [dbo].[SP_CreateCategoryMenuTest]

----------------------------------------------------------------------
-- Author:		<Reshma>
-- Create date: <14/11/2014>
-- Description:	<Get Category Details>
-----------------------------------------------------------------------
AS
BEGIN
		select cm.CategoryID,sc.SubCategoryID, cm.CategoryName , sc.SubCategoryName from CategoryMaster cm inner join 
		SubCategory sc on cm.CategoryID=sc.CategoryID where sc.IsActive=1 and cm.IsActive=1

END


GO
/****** Object:  StoredProcedure [dbo].[SP_CustomerRegistration]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Reshma>
-- Create date: <6/9/2014>
-- Description:	<New customer entry>
-- =============================================
CREATE PROCEDURE [dbo].[SP_CustomerRegistration]
@EmailID nvarchar(150),
@Password nvarchar(50),
@Mobile nvarchar(15),
@Gender NVARCHAR(20)

AS
BEGIN 
   INSERT INTO [dbo].[Customer]
           ([CustomerID] 
           ,[EmailID]
           ,[Mobile]
           ,[Password]
		   ,[Gender]
           ,[CreatedDate])
     VALUES
           (NEWID() 
           ,@EmailID
           ,@Mobile
           ,@Password
		   ,@Gender
		   ,getdate()) 
END

GO
/****** Object:  StoredProcedure [dbo].[SP_CustomerResetPassword]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  



CREATE PROCEDURE [dbo].[SP_CustomerResetPassword]  



@mailID varchar(100),  

@UserPassword varchar(100)

as

  BEGIN  


  UPDATE Customer  

     SET    Password=@UserPassword

     WHERE	EmailID like @mailID



END 
GO
/****** Object:  StoredProcedure [dbo].[SP_DispatchOrder]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DispatchOrder] 

     @OrderId BIGINT
	,@OrderDetailID BIGINT
	,@DispatchType char
	,@DispatchedBy INT=NULL
	,@DeliveryChannel		char(1)
	,@User					NVARCHAR(100)
	,@Courier				NVARCHAR(100)
	,@HasBeenShipped		bit
	,@IsDelivered			bit
	,@result BIGINT OUTPUT
	
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @intErrorCode INT
	SET @result=1;

	BEGIN TRAN
		
		IF EXISTS(SELECT OrderId FROM [DispatchOrder] WHERE OrderId=@OrderId)
		BEGIN
			print 'update' 
			Update 
				[dbo].[DispatchOrder] 
			
			SET
				[OrderDetailID]	=	@OrderDetailID,
				[DispatchType]	=	@DispatchType,
				[DispatchDate]	=	GETDATE(),
				[DispatchedBy]	=	@DispatchedBy,
				DeliveryChannel	=	@DeliveryChannel,
				[User]			=	@User,
				Courier			=	@Courier,
				HasBeenShipped	=	@HasBeenShipped

			WHERE OrderId=@OrderId

			SELECT @intErrorCode=@@ERROR

			UPDATE Orders 
			SET HasBeenShipped=@HasBeenShipped
			WHERE OrderID=@OrderId

			SELECT @intErrorCode = @@ERROR

		END
		ELSE
		BEGIN	
			DECLARE @InvoiceNumber as NVARCHAR(50);

			SELECT @InvoiceNumber =  Convert(varchar(4), DATEPART(YYYY,GETDATE())) + Convert(varchar(4),DATEPART(MM,GETDATE())) + Convert(varchar(4),DATEPART(DD,GETDATE())) + '-' + Convert(VARCHAR(50), @OrderId)

			INSERT INTO [dbo].[DispatchOrder] (
				 [OrderId]
				,[OrderDetailID]
				,[DispatchType]
				,[DispatchDate]
				,[DispatchedBy]
				,DeliveryChannel
				,[User]
				,Courier
				,[InvoiceNumber]
				,HasBeenShipped
				,CreatedOn
				,IsDelivered
				)
			VALUES (
				 @OrderId
				,@OrderDetailID
				,@DispatchType
				,GETDATE()
				,@DispatchedBy
				,@DeliveryChannel
				,@User	
				,@Courier
				,@InvoiceNumber
				,@HasBeenShipped
				,GETDATE()
				,@IsDelivered
				)

			SELECT @intErrorCode=@@ERROR

			UPDATE Orders 
			SET HasBeenShipped=@HasBeenShipped
			WHERE OrderID=@OrderId

			SELECT @intErrorCode = @@ERROR

			UPDATE DispatchOrder
			SET InvoiceNumber=@InvoiceNumber
			WHERE OrderID=@OrderId

			SELECT @intErrorCode = @@ERROR

		END

		IF (@intErrorCode <> 0) GOTO PROBLEM
	COMMIT TRAN

	PROBLEM:
	IF (@intErrorCode <> 0)
	BEGIN
		PRINT 'Unexpected error occurred!'
		SET @result=@InvoiceNumber;
		ROLLBACK TRAN
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GenerateInvoice]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--EXEC [SP_GenerateInvoice] '73','1'
CREATE PROCEDURE [dbo].[SP_GenerateInvoice] (
	@OrderId	INT,
	--@OrderDetailId INT=NULL,
	@LangID		INT=  1
)
-----------------------------------------------------------------------
-- Author:		<Dinesh>
-- Create date: <11/10/2014>
-- Description:	<To get invoice details>
-----------------------------------------------------------------------
AS
BEGIN

	SELECT
		CASE @LangID 
						WHEN 1 THEN CM.ClientName 
						WHEN 2 THEN CM.ClientName_LL 
		END AS ClientName,
		CASE @LangID 
						WHEN 1 THEN CM.ClientDescription 
						WHEN 2 THEN CM.ClientDescription_LL 
		END AS ClientDescription ,

		(CASE @LangID	WHEN 1 THEN (ISNULL(CM.AddressLine1,'')) 
						WHEN 2 THEN (ISNULL(CM.AddressLine1_LL,'')) 
		END
		+ ', ' +
		CASE @LangID	WHEN 1 THEN (ISNULL(CM.AddressLine2,'')) 
						WHEN 2 THEN (ISNULL(CM.AddressLine2_LL,'')) 
		END
		+ ', ' +
		CASE @LangID	WHEN 1 THEN (ISNULL(CM.AddressLine3,'')) 
						WHEN 2 THEN (ISNULL(CM.AddressLine3_LL,'')) 
		END
		) AS ClientAddress,
							
		ClientLogo,

		O.FullName as CustomerName,
		O.ShippingAddress,
		O.City,
		O.States,
		O.PinCode,
		O.LandMark,
		O.Mobile,
		O.LandLine,
		O.Email,

		O.OrderId,
		O.OrderDate,
		OD.OrderDetailId,
		OD.Quantity,
		
		CASE @LangID WHEN 1 THEN PM.ProductName WHEN 2 THEN PM.ProductName_LL END AS ProductName,
		CASE @LangID WHEN 1 THEN PM.ProductDescription WHEN 2 THEN PM.ProductDescription_LL END AS ProductDescription,

		PM.Price AS Price,
		PM.BasePrice,
		T.TaxRate  AS VAT,
		CONVERT(DECIMAL(30,2),(T.TaxRate * (PM.BasePrice/100))) AS VATAmount,
		T1.TaxRate AS ServiceTax,
		CONVERT(DECIMAL(30,2),(T1.TaxRate * (PM.BasePrice/100))) AS ServiceTaxAmount,

		O.subTotal,
		O.MolPortalCharges,
		O.MolServiceCharges,
		(OD.Quantity*OD.UnitPrice) As NetAmount
		
	FROM
		Orders O
		LEFT OUTER JOIN OrderDetail OD ON O.OrderId = OD.OrderId
		LEFT OUTER JOIN ProductMaster PM ON OD.ProductId = PM.ProductId
		LEFT OUTER JOIN ClientMaster CM ON O.ClientID=CM.ClientID
		LEFT OUTER JOIN TaxDetail T ON PM.VAT=T.ID
		LEFT OUTER JOIN TaxDetail T1 ON PM.ServiceTax=T1.ID
		LEFT OUTER JOIN TaxMaster TM ON TM.TaxTypeID=T.TaxTypeID
		--LEFT OUTER JOIN PaymentDetails P ON

	WHERE 
		O.OrderId=@OrderId
		--AND TM.TaxType='VAT'
			--AND ( @OrderDetailId IS NULL OR @OrderDetailId=0 OR OD.OrderDetailId=@OrderDetailId )
		
END

--select * from  clientmaster
--select * from Orders where orderid=73
----select * from OrderDetail  where orderid=73

--select * from ProductMaster where productid in(74,75)
--select * from  TaxMaster
--select * from  TaxDetail

--select * from ClientMaster
GO
/****** Object:  StoredProcedure [dbo].[SP_GenerateReceipt]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GenerateReceipt] (

	@applicantid	bigINT

)
AS

BEGIN

	SELECT		TxnUniqueNo,applicantid,PGTransactionID,

				PaymentTransactionID ,	BankTransactionRefNo,	Amount,	PortalFee,	TotalAmount,

				AmountInWords,PaymentDate--	CONVERT(DATETIME, getdate(), 131) as PaymentDate
 				-- FORMAT(getdate() , 'G', 'id-ID') as PaymentDate //CONVERT(VARCHAR(24),GETDATE(),113)
				  ,	 PayeeName,	 ApplicantName ,PayFlag ,	PayMode , email

	FROM

		PaymentOfShooting P

	WHERE applicantid = @applicantid

			
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetAccessController]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--exec SP_GetAccessController 'LogOff','Account',12
CREATE PROCEDURE [dbo].[SP_GetAccessController]
(
	@action varchar(50)	,
	@controller varchar(50)	,
	@roleid int

)
----------------------------------------------------------------------
-- Author:		<Reshma>
-- Create date: <12/11/2014>
-- Description:	<Get dispatched details>
-----------------------------------------------------------------------
AS
BEGIN		
		SET NOCOUNT ON;
		---select count(*) cnt from ContollerRights where Action=@action and Controller=@controller and RoleID=@roleid and Access='1'
	select COUNT(*) cnt from MenusForRoles mr inner join Menus m on m.MenuID=mr.MenuId where m.Action=@action and m.Controller=@controller and mr.RoleId=@roleid

END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetApplicantDetails]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GetApplicantDetails]

@ReceiptID  bigint =null

as 

BEGIN

	select ReceiptID,ApplicationDate,s.ApplicantName,s.ClientName ,CONVERT(VARCHAR(13),ShootDate,103) as ShootDate , Days , email, MobileNo , Adults,Childs, 
		TwoWheelers,FourWheelers,Bus_Heavy_vehicls , shootingAmount ,DepositAmount , molcharges , ShootDetails , RejectionReason
		,ApplicantAddress1 , ApplicantAddress2 , s.ApplicantDesignation, isvalid, IsNatural ,IsAnimal  , s.ClientName,ClientName_ll, 
		ClientAddress1 ,ClientAddress1_ll, ClientAddress2 ,ClientAddress2_ll , FilmName, FilmName_ll, FilmPlace, FilmPlace_ll , d.ImagePath

		
	from ShootingPermission s

	inner join ShootingIdentityDocs d on s.ReceiptID = d.ApplicantId

	where s.ReceiptID =@ReceiptID


END









GO
/****** Object:  StoredProcedure [dbo].[SP_GetApplicants]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_GetApplicants]    
(
@langId int = null,
@ReceiptID bigint = null
)
AS    

BEGIN    
if @langId =1
begin

	SELECT  ReceiptID,CONVERT(VARCHAR(13),ApplicationDate,103) as ApplicationDate,ApplicantName,ClientName , CONVERT(VARCHAR(13),ShootDate,103) as  ShootDate , Days , email, MobileNo , Adults,Childs, TwoWheelers,FourWheelers,Bus_Heavy_vehicls
	from ShootingPermission s where s.ReceiptID not in ( select ReceiptID from ShootingPermission 
	where-- (ShootDone = 0 or ShootDone is null)and
	  (@ReceiptID IS NULL OR @ReceiptID=0 OR s.ReceiptID = @ReceiptID)  
	 and isrejected = 'Action Taken')

 ORDER BY ReceiptID desc --,  s.ApplicantName --s.ApplicationDate desc ,

 end
 else 
 begin
 
	SELECT ReceiptID,CONVERT(VARCHAR(13),ApplicationDate,103) as ApplicationDate,ApplicantName,ClientName_ll , CONVERT(VARCHAR(13),ShootDate,103) as ShootDate , Days , email, MobileNo , Adults,Childs, TwoWheelers,FourWheelers,Bus_Heavy_vehicls
	from ShootingPermission s where s.ReceiptID not  in ( select ReceiptID from ShootingPermission 
	where -- (ShootDone = 0 or ShootDone is null) and
	  (@ReceiptID IS NULL OR @ReceiptID=0 OR s.ReceiptID = @ReceiptID)  and isrejected = 'Action Taken')
	 
 ORDER BY  ReceiptID desc -- , s.ApplicantName -- s.ApplicationDate desc ,
  
 end

END
 
GO
/****** Object:  StoredProcedure [dbo].[SP_GetApprovedReports]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_GetApprovedReports] 
AS

BEGIN

--if (@flag ='Approved')
--begin
	
	SELECT	s.ReceiptID, CONVERT(VARCHAR(13), p.PaymentDate,103) as PaymentDate,  p.PaymentTransactionID , p.PGTransactionID ,s.shootingAmount ,s.DepositAmount , s.molcharges, p.PortalFee , p.TotalAmount , p.AmountInWords,s.ApplicantName,s.ClientName , s.email, s.MobileNo 
	

		FROM

		PaymentOfShooting P inner join ShootingPermission s on p.applicantid= s.ReceiptID

	WHERE 
		s.isapproved = 1 and ShootDone = 1
	--end
	--else if(@flag='Rejected')
	
	--begin
	
	--SELECT	 ReceiptID,ApplicationDate,ApplicantName,ClientName ,  email, MobileNo , RejectionReason
	 
	--	FROM	ShootingPermission s 

	--where isapproved = 0 and (ShootDone =0 or ShootDone =null)

	--end		
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetCategory]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC [SP_GetCategory] 1,1,0,null,BOOKS
CREATE PROCEDURE [dbo].[SP_GetCategory]
(
	
	@ClientId INT = 1
	,@LangId	INT = 1
	,@CategoryID INT = NULL
	,@IsActive Bit = null
	,@CategoryName nvarchar(50)=null
)
----------------------------------------------------------------------
-- Author:		<Vipul>
-- Create date: <01/09/2014>
-- Description:	<Get Category Details>
-----------------------------------------------------------------------
AS
BEGIN
		--SELECT 
		--		'' AS CategoryID
		--		,'Please Select'  CategoryName
		--UNION 
		SELECT 
				CategoryID
				,CASE  @LangId
						WHEN	1
						THEN  CategoryName
						ELSE  CategoryName_LL
				END AS CategoryName,
				case IsActive when 1 then 'Yes' else 'No' end AS IsActive
		FROM	dbo.CategoryMaster with (nolock)
		WHERE	ClientID = @ClientId
		AND		(@IsActive is null or IsActive =  @IsActive)
		AND		(@CategoryID IS NULL OR @CategoryID = 0 OR CategoryID=@CategoryID)
		AND		(@CategoryName IS NULL OR CategoryName like '%'+@CategoryName+'%')
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetCity]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

--exec SP_GetCity 'mum'
CREATE PROCEDURE [dbo].[SP_GetCity]
	-- Add the parameters for the stored procedure here
	@SearchCity Nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT DISTINCT
		City 
	
	FROM  
		Orders WITH (NOLOCK)

	WHERE
		City LIKE '%' + @SearchCity + '%' OR ShippingAddress LIKE '%' + @SearchCity + '%'
	
END





GO
/****** Object:  StoredProcedure [dbo].[SP_GetClientDetails]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetClientDetails]
(
	@LangId	INT = 1
)
----------------------------------------------------------------------
-- Author:		<Vipul>
-- Create date: <01/09/2014>
-- Description:	<Get Client Details>
-----------------------------------------------------------------------
AS
BEGIN
		SELECT 
					ClientID
					,CASE  @LangId 
							WHEN	1
							THEN  ClientName
							ELSE  ClientName_LL
					END AS ClientName
		FROM		dbo.ClientMaster with (nolock)
		WHERE		IsActive	= 1 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetClientIDName]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GetClientIDName]    

AS    

BEGIN    
SELECT ISNULL(ClientID,0) AS ClientID,ISNULL(ClientName,'') AS ClientName
--SELECT ISNULL(ClientID,'00000000-0000-0000-0000-000000000000') AS ClientID,ISNULL(ClientName,'') AS ClientName
FROM ClientMaster with (nolock) ORDER BY ClientID

END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCountry]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_GetCountry] (

@Langid INT = 1

	)

AS

BEGIN

	SELECT Countrycode 
		,CASE @Langid

			WHEN 1

				THEN Countryname

			ELSE Countryname_LL

			END AS Countryname

	FROM dbo.Census_Country with (nolock)

END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCourier]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Dinesh>
-- Create date: <10/11/2014>
-- Description:	<Get Courier Details>
-- =============================================

CREATE PROCEDURE [dbo].[SP_GetCourier]
(
	 @CourierID			BIGINT=NULL
	 ,@IsActive			BIT=NULL
)

AS

BEGIN
		
		SELECT
			CourierID
			,CourierName
			,BranchName
			,[Address]
			,Phone
			,Mobile
			,Email
			,CASE WHEN IsActive = 1 THEN 'Yes' ELSE 'No' END AS IsActive
			
		FROM
			dbo.[CourierMaster] with (nolock)
		
		WHERE
			(@CourierID IS NULL OR @CourierID = 0 OR CourierID=@CourierID)
			AND (@IsActive IS NULL OR IsActive=@IsActive)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCustomer]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Dinesh>
-- Create date: <10/11/2014>
-- Description:	<Get Customer Details>
-- =============================================

CREATE PROCEDURE [dbo].[SP_GetCustomer]
	 @searchCustomerName			NVARCHAR(200)=NULL
AS

BEGIN
		
		SELECT 
			 CustomerName
			 ,EmailID
			 ,Mobile
			 ,CASE LTRIM(RTRIM(Gender)) WHEN 'M' THEN 'Male' ELSE 'Female' END AS Gender

		FROM
			dbo.Customer WITH (NOLOCK)
		
		WHERE
			(@searchCustomerName IS NULL OR CustomerName  LIKE '%' + @searchCustomerName + '%')
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetCustomerFromOrders]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Dinesh>
-- Create date: <10/11/2014>
-- Description:	<Get Customer Details>
-- =============================================
--SP_GetCustomerFromOrders 'DIN'
CREATE PROCEDURE [dbo].[SP_GetCustomerFromOrders]
	 @searchCustomerName			NVARCHAR(200)=NULL
AS

BEGIN
		
		SELECT
			DISTINCT
			 FullName AS CustomerName
			 --,EmailID
			 --,Mobile
			 --,CASE LTRIM(RTRIM(Gender)) WHEN 'M' THEN 'Male' ELSE 'Female' END AS Gender

		FROM
			dbo.Orders WITH (NOLOCK)
		
		WHERE
			(@searchCustomerName IS NULL OR FullName  LIKE '%' + @searchCustomerName + '%')
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetDispatchDetails]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetDispatchDetails]
(
	@orderFromdate datetime	,
	@orderTodate datetime	
)
----------------------------------------------------------------------
-- Author:		<Reshma>
-- Create date: <11/10/2014>
-- Description:	<Get dispatched details>
-----------------------------------------------------------------------
AS
BEGIN		
		
		select convert(varchar(15),de.DeliveryDate,106) as DeliveryDate,de.OrderDeliveryID,DO.DispatchOrderID,do.DispatchType,do.InvoiceNumber,
		pm.ProductName,do.IsDelivered,do.DeliveryChannel,de.Remark,do.HasBeenShipped,cm.CourierName  from DispatchOrder DO inner join OrderDetail OD 
		on do.OrderId=od.OrderId inner join CourierMaster cm on DO.Courier=cm.CourierID inner join ProductMaster pm 
		on pm.ProductID=od.ProductId INNER JOIN Orders O ON O.OrderId=DO.OrderId inner join OrderDelivery de on de.OrderId=OD.OrderId
		where de.DeliveryDate>='2014-10-30' and de.DeliveryDate<='2014-11-28'

END

--select * from DispatchOrder

--select * from OrderDelivery
--select * from Orders
--select * from OrderDetail
GO
/****** Object:  StoredProcedure [dbo].[SP_GetDistrict]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_GetDistrict] (
	@Langid INT = 1
	,@StateCode int=27
	)
AS

BEGIN

	SELECT  
		Districtcode 
		,CASE @Langid WHEN 1 THEN Districtname ELSE Districtname_LL END AS Districtname

	FROM 
		dbo.census_district with (nolock)
	
	WHERE 
		StateCode=@StateCode
	
	ORDER BY
		Districtname
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetForgetPwdToken]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_GetForgetPwdToken]
@UserName  varchar(100) = null

as
begin

 SELECT ForgotPasswordToken

            FROM  UserMaster

        
         WHERE 

		Username =@UserName  and IsActive =1

         end
GO
/****** Object:  StoredProcedure [dbo].[SP_GetMenuForRoles]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Reshma>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[SP_GetMenuForRoles]
	@RoleID INT =NULL
AS
BEGIN

	SET NOCOUNT ON;

	SELECT
		RM.RoleID
		,RM.RoleName
		,m.MenuID
		,m.SortOrder
		,m.[Description] as MenuName
		,m.[Action]
		,m.Controller
		,m.Title
		--,UM.Display_Name
		,'' as 'Display_Name'
		,IsNULL(M.ParentId,0) as ParentId

	FROM
		MenusForRoles MFR WITH (NOLOCK)
		inner join RoleMaster RM WITH (NOLOCK)  ON  mfr.RoleId=rm.RoleID
		--LEFT join UserMaster UM WITH(NOLOCK) ON rm.RoleID = um.RoleID
		inner join Menus M WITH (NOLOCK) ON mfr.MenuId = m.MenuID

	WHERE (@RoleID IS NULL OR MFR.RoleID =@RoleID) and m.IsActive=1
	
	ORDER BY MFR.RoleID,m.ParentID,m.SortOrder

END


--select * from MenusForRoles

--select * from Menus

--sp_depends 'RoleMaster'


--truncate table MenusForRoles
GO
/****** Object:  StoredProcedure [dbo].[SP_GetMenus]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Dinesh>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[SP_GetMenus]
AS
BEGIN

	SET NOCOUNT ON;

	SELECT 
		m.MenuID
		,m.[Description] as MenuName

	FROM
		Menus M WITH (NOLOCK)
		
	WHERE 
		m.IsActive=1 and MenuID not in(16,18,19,20)

END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetNewProductList]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--- [SP_GetNewProductList] NULL,NULL,NULL,NULL,NULL,'JACK'
CREATE PROCEDURE [dbo].[SP_GetNewProductList]	@Top      NVARCHAR(20) = NULL, 
												@CATID    NVARCHAR(100) = NULL, 
												@SUBCATID NVARCHAR(100) = NULL,
												@FRM        INT = null, 
												@TO         INT = NULL,
												@KEYWORD NVARCHAR(1000) = NULL
AS 
  BEGIN  
  if(@frm is null)
	set @frm = 0

 if(@to is null)
	set @to = 4

      SELECT *
            
      FROM   (SELECT pm.productid, 
                     pd.productdetailid, 
                     pm.productname, 
                     pm.price, 
                     isnull(pm.thumbnail,'') thumbnail, 
                     Isnull(pd.size, '') Size, 
                     SC.subcategoryid, 
                     sc.subcategoryname, 
                     CM.categoryid, 
                     cm.categoryname,
					  Row_number() 
               OVER ( 
                 ORDER BY pd.createddate DESC ) AS ID,
				 --'0' as Quantity
				 pd.Quantity 
              FROM   productmaster PM 
                     INNER JOIN productdetails pd 
                             ON pm.productid = pd.productid 
                     LEFT JOIN subcategory SC 
                            ON pm.subcategoryid = sc.subcategoryid 
                     LEFT JOIN categorymaster CM 
                            ON sc.categoryid = CM.categoryid 
              WHERE  pm.isactive = 1 
                     AND ( @CATID IS NULL 
                            OR @CATID = 0 
                            OR CM.categoryid = @CATID ) 
                     AND ( @SUBCATID IS NULL 
                            OR SC.subcategoryid = @SUBCATID )
					AND (@KEYWORD IS NULL OR PM.PRODUCTNAME LIKE '%' + @KEYWORD + '%')
							) T 

							 where t.ID > @FRM and id <= @to
						 
   
--	select max(ID) cnt from #Results

END 
GO
/****** Object:  StoredProcedure [dbo].[SP_GetOrdersToDeliver]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--EXEC [SP_GetOrdersToDeliver] null,1,1906
CREATE PROCEDURE [dbo].[SP_GetOrdersToDeliver] (
	--@DispatchOrderId	INT = NULL,
	 @SearchCity NVARCHAR(200)=NULL
	,@LangID		INT=  1
	,@UserID	BIGINT=NULL
)
----------------------------------------------------------------------
-- Author:		<Dinesh>
-- Create date: <13/10/2014>
-- Description:	<To get invoice details>
-----------------------------------------------------------------------
AS
BEGIN

	SELECT
		O.OrderId,
		dbo.fnProductName(D.OrderId) as ProductName,
		O.FullName as CustomerName,
		O.ShippingAddress,
		O.City,
		O.States,
		O.Landmark,
		O.PinCode,
		O.Mobile,
		O.Email,
		CONVERT(VARCHAR(13),O.OrderDate,101) as OrderDate,
		CONVERT(VARCHAR(13),D.DispatchDate,101) as DispatchDate,
		D.InvoiceNumber,
		C.CourierID,
		C.UserID

	FROM
		DispatchOrder D
		LEFT OUTER JOIN Orders O ON D.OrderId=O.OrderId
		--inner JOIN PaymentDetails P ON O.OrderId=P.OrderId
		LEFT OUTER JOIN CourierMaster C ON D.Courier=C.CourierID
		LEFT OUTER JOIN UserMaster U ON U.UserID=C.UserID

	 WHERE
		(@SearchCity IS NULL OR O.ShippingAddress LIKE '%'+@SearchCity+'%' OR O.City LIKE '%'+@SearchCity+'%')
		AND (@UserID IS NULL OR C.UserID=@UserID)
		--AND D.DeliveryChannel='C'
		AND D.IsDelivered=0
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetOrdersToDispatch]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--EXEC [SP_GetOrdersToDispatch] 3,'1'
CREATE PROCEDURE [dbo].[SP_GetOrdersToDispatch] (
	@OrderId	INT = NULL,
	@LangID		INT=  1
)
----------------------------------------------------------------------
-- Author:		<Dinesh>
-- Create date: <13/10/2014>
-- Description:	<To get invoice details>
-----------------------------------------------------------------------
AS
BEGIN

	SELECT

		--O.OrderId,
		--Convert(varchar(13),O.OrderDate,106) as OrderDate,
		----CASE @LangID WHEN 1 THEN PM.ProductName WHEN 2 THEN PM.ProductName_LL END AS 'ProductName'
		--STUFF((SELECT ',' + PM.ProductName_LL
  --            FROM  Orders O
		--LEFT OUTER JOIN OrderDetail OD ON O.OrderId = OD.OrderId
		--LEFT OUTER JOIN ProductMaster PM ON OD.ProductId = PM.ProductId              
  --            --where( O.OrderId=@OrderId)
  --            ORDER BY ProductName
  --            FOR XML PATH('')), 1, 1, '') AS ProductName

		O.OrderId
		,Convert(varchar(13),O.OrderDate,106) as OrderDate
		,dbo.fnProductName( O.OrderId) 'ProductName(Quantity)'
		,CASE WHEN O.HasBeenShipped=1 THEN 'Shipped' ELSE 'Not Shipped' END AS 'Status'
	FROM
		Orders O		
		--LEFT OUTER JOIN DispatchOrder D ON O.OrderId=D.OrderId
	WHERE 
		(@OrderId IS NULL OR O.OrderId=@OrderId OR @OrderId =0) 
		 --AND D.IsDelivered<>1 OR D.IsDelivered is NULL
		 AND O.HasBeenShipped<>1
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetOTPDetails]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GetOTPDetails]      


 @userid bigint   

AS      

BEGIN    
 SET NOCOUNT Off;      

         
		 
select RandomNo , CurrentTime from dbo.UserMaster        


    where UserID =@userid

END      

    

    

GO
/****** Object:  StoredProcedure [dbo].[SP_GetPlaceOrderDetails]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC [SP_GetPlaceOrderDetails] '10123','1'
CREATE PROCEDURE [dbo].[SP_GetPlaceOrderDetails] (
	@OrderId	INT,
	--@OrderDetailId INT=NULL,
	@LangID		INT=  1
)
-----------------------------------------------------------------------
-- Author:		<Dinesh>
-- Create date: <12/01/2014>
-- Description:	<To get Order details>
-----------------------------------------------------------------------
AS
BEGIN

	SELECT
		CASE @LangID 
						WHEN 1 THEN CM.ClientName 
						WHEN 2 THEN CM.ClientName_LL 
		END AS ClientName,
		CASE @LangID 
						WHEN 1 THEN CM.ClientDescription 
						WHEN 2 THEN CM.ClientDescription_LL 
		END AS ClientDescription ,

		(CASE @LangID	WHEN 1 THEN (ISNULL(CM.AddressLine1,'')) 
						WHEN 2 THEN (ISNULL(CM.AddressLine1_LL,'')) 
		END
		+
		CASE @LangID	WHEN 1 THEN (ISNULL(CM.AddressLine2,'')) 
						WHEN 2 THEN (ISNULL(CM.AddressLine2_LL,'')) 
		END
		+
		CASE @LangID	WHEN 1 THEN (ISNULL(CM.AddressLine3,'')) 
						WHEN 2 THEN (ISNULL(CM.AddressLine3_LL,'')) 
		END
		) AS ClientAddress,
							
		ClientLogo,

		O.FullName as CustomerName,
		O.ShippingAddress,
		O.City,
		O.States,
		O.PinCode,
		O.LandMark,
		O.Mobile,
		O.LandLine,
		O.Email,

		O.OrderId,
		O.OrderDate,
		OD.OrderDetailId,
		OD.Quantity,

		CASE @LangID WHEN 1 THEN PM.ProductName WHEN 2 THEN PM.ProductName_LL END AS ProductName,
		CASE @LangID WHEN 1 THEN PM.ProductDescription WHEN 2 THEN PM.ProductDescription_LL END AS ProductDescription,

		PM.Price AS Price,
		PM.BasePrice,
		T.TaxRate  AS VAT,
		CONVERT(DECIMAL(30,2),(T.TaxRate * (PM.BasePrice/100))) AS VATAmount,
		T1.TaxRate AS ServiceTax,
		CONVERT(DECIMAL(30,2),(T1.TaxRate * (PM.BasePrice/100))) AS ServiceTaxAmount,

		O.subTotal,
		O.MolPortalCharges,
		O.MolServiceCharges,
		(OD.Quantity*OD.UnitPrice) As NetAmount
	FROM
		Orders O
		LEFT OUTER JOIN OrderDetail OD ON O.OrderId = OD.OrderId
		LEFT OUTER JOIN ProductMaster PM ON OD.ProductId = PM.ProductId
		LEFT OUTER JOIN ClientMaster CM ON O.ClientID=CM.ClientID
		LEFT OUTER JOIN TaxDetail T ON PM.VAT=T.ID
		LEFT OUTER JOIN TaxDetail T1 ON PM.ServiceTax=T1.ID
		LEFT OUTER JOIN TaxMaster TM ON TM.TaxTypeID=T.TaxTypeID
		--LEFT OUTER JOIN PaymentDetails P ON

	WHERE O.OrderId=@OrderId 
			--AND ( @OrderDetailId IS NULL OR @OrderDetailId=0 OR OD.OrderDetailId=@OrderDetailId )
		
END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetProduct]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetProduct] 
(
	@SubCategoryId	INT = NULL
	,@ClientId	INT = 1
	,@LangId	INT = 1
	,@ProductId	INT	= NULL
)
----------------------------------------------------------------------
-- Author:		<Vipul>
-- Create date: <01/09/2014>
-- Description:	<Get Product Data>
-----------------------------------------------------------------------
AS
BEGIN
		
		SELECT 
					ProductID
					,CASE  @LangId 
							WHEN	1
							THEN  ProductName
							ELSE  ProductName_LL
					END AS ProductName
					,ProductName_LL
					,S.SubCategoryID
					,CASE  @LangId 
							WHEN	1
							THEN  SubCategoryName
							ELSE  SubCategoryName_LL
					END AS SubCategoryName
					,C.CategoryID
					,CASE  @LangId
						WHEN	1
						THEN	C.CategoryName
						ELSE  C.CategoryName_LL
					END AS CategoryName
					,P.IsActive
		FROM	dbo.ProductMaster P with (nolock)
		JOIN	dbo.SubCategory S with (nolock)
		ON		P.SubCategoryID = S.SubCategoryID
		JOIN	dbo.CategoryMaster	C with (nolock)
		ON		C.CategoryID = S.CategoryID
		WHERE	P.ClientID		= @ClientId
		--AND		P.SubCategoryID	= @SubCategoryId
		--AND		P.IsActive		= 1 
		AND		(@SubCategoryId IS NULL OR @SubCategoryId=0 OR P.SubCategoryID = @SubCategoryId)
		AND		(@ProductId IS NULL OR @ProductId=0 OR P.ProductID = @ProductId)
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetProductDetails]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetProductDetails] 
(
	@ProductID	INT
	,@LangId	INT = 1
)
----------------------------------------------------------------------
-- Author:		<Vipul>
-- Create date: <01/09/2014>
-- Description:	<Get Product Details>
-----------------------------------------------------------------------
AS
BEGIN
		
		SELECT 
					ProductDetailID,
					'' as ProductIdentifierName
					--,CASE  @LangId 
					--		WHEN	1
					--		THEN  ProductIdentifierName
					--		ELSE  ProductIdentifierName_LL
					--END AS ProductIdentifierName
		FROM	dbo.ProductDetails with (nolock)
		WHERE	ProductID		= @ProductID
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetProductDetailsWithSpec]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


---exec SP_GetProductDetailsWithSpec null,'abc',null,null,null

CREATE PROCEDURE [dbo].[SP_GetProductDetailsWithSpec]

(

	@ProductID			nvarchar(200) = null,

	@productName		nvarchar(200) = null,

	@ProductDetailID	nvarchar(100) = null,

	@categoryName nvarchar(100) = null,

	@subcategoryName nvarchar(100) = null

	

)

----------------------------------------------------------------------

-- Author:		<rohan>



-- Create date: <03/12/2014>



-- Description:	<Get Product Details>



-- Example : exec SP_GetProductDetailsWithSpec 3,null



-----------------------------------------------------------------------

AS

BEGIN
SELECT distinct

				PM.ProductID

				,PM.ProductName

				,ProductName_LL

				,PM.ProductDescription_LL		

				,PM.ProductDescription

				,PM.ProductSize_LL

				--,PD.Size as 'ProductSize'

				,PM.ProductWeight_LL

				,PM.ProductWeight

				,PM.Author_LL

				,PM.Author

				,PM.Publisher_LL

				,PM.Publisher

				,PM.Language_LL

				,PM.Language

				,PM.Pages

				,ISNULL(PM.Price,0.00) as Price

				,PD.Quantity

				,PM.Thumbnail

				,ProductName

				,S.SubCategoryID

				,SubCategoryName

				,C.CategoryID				

				,C.CategoryName

				,Unit

				,Price

				,PM.BasePrice

				,PM.MahaonlineCharges

				,PM.ShippingCharges

				,PM.VAT

				,PM.ServiceTax

				,PM.IsActive

				--,PD.productDetailid
				, stuff((select '|'+cast(S.ProductDetailID as varchar(10))
              from ProductDetails S
              where S.ProductID = Pm.ProductID
              for xml path('')), 1, 1, '') ProductIdColl
			  , stuff((select '|'+cast(S.Size as varchar(10))
              from ProductDetails S
              where S.ProductID = Pm.ProductID
              for xml path('')), 1, 1, '') sizeColl
			  ,stuff((select '|'+cast(pd.Quantity as varchar(10))
              from ProductDetails S
              where S.ProductID = Pm.ProductID
              for xml path('')), 1, 1, '') QuantityColl
		FROM	

				dbo.ProductMaster  PM WITH (NOLOCK) 

		inner JOIN	dbo.SubCategory S WITH (NOLOCK)

		ON		PM.SubCategoryID = S.SubCategoryID

		inner JOIN	dbo.CategoryMaster C WITH (NOLOCK)

		ON		S.CategoryID = C.CategoryID

		--LEFT JOIN	dbo.StockMaster SM WITH (NOLOCK)

		--ON		PM.ProductID = SM.ProductID

		inner JOIN	dbo.ProductDetails PD WITH (NOLOCK)

		ON		PM.ProductID = PD.ProductID		

		WHERE	

				(@ProductID IS NULL OR @ProductID = 0 OR PM.ProductID=@ProductID) 

				and (@ProductDetailID IS NULL OR @ProductDetailID = 0 OR pd.ProductDetailID = @ProductDetailID) 

				and (@categoryName IS NULL OR c.CategoryName like '%'+@categoryName+'%' ) 

				and (@subcategoryName IS NULL OR s.SubCategoryName like '%'+@subcategoryName+'%')  

END



GO
/****** Object:  StoredProcedure [dbo].[SP_GetProductDetailsWithSpecification]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

---exec SP_GetProductDetailsWithSpecification null,'abc',null,null,null
CREATE PROCEDURE [dbo].[SP_GetProductDetailsWithSpecification]
(
	@ProductID			nvarchar(200) = null,
	@productName		nvarchar(200) = null,
	@ProductDetailID	nvarchar(100) = null,
	@categoryName nvarchar(100) = null,
	@subcategoryName nvarchar(100) = null
	
)
----------------------------------------------------------------------
-- Author:		<Vipul>

-- Create date: <01/09/2014>

-- Description:	<Get Product Details>

-- Example : exec SP_GetProductDetailsWithSpecification 3,null

-----------------------------------------------------------------------
AS
BEGIN
		SELECT		 distinct
				PM.ProductID
				,PM.ProductName
				,ProductName_LL
				,PM.ProductDescription_LL		
				,PM.ProductDescription
				,PM.ProductSize_LL
			--	,PD.Size as 'ProductSize'
				,PM.ProductWeight_LL
				,PM.ProductWeight
				,PM.Author_LL
				,PM.Author
				,PM.Publisher_LL
				,PM.Publisher
				,PM.Language_LL
				,PM.Language
				,PM.Pages
				,ISNULL(PM.Price,0.00) as Price
			--	,PD.Quantity
				,PM.Thumbnail
				,ProductName
				,S.SubCategoryID
				,SubCategoryName
				,C.CategoryID				
				,C.CategoryName
				,Unit
				,Price
				,PM.BasePrice
				,PM.MahaonlineCharges
				,PM.ShippingCharges
				,PM.VAT
				,PM.ServiceTax
				,PM.IsActive
				--,PD.productDetailid
		FROM	
				dbo.ProductMaster  PM WITH (NOLOCK) 
		inner JOIN	dbo.SubCategory S WITH (NOLOCK)
		ON		PM.SubCategoryID = S.SubCategoryID
		inner JOIN	dbo.CategoryMaster C WITH (NOLOCK)
		ON		S.CategoryID = C.CategoryID
		--LEFT JOIN	dbo.StockMaster SM WITH (NOLOCK)
		--ON		PM.ProductID = SM.ProductID
		inner JOIN	dbo.ProductDetails PD WITH (NOLOCK)
		ON		PM.ProductID = PD.ProductID		
		WHERE	
				(@ProductID IS NULL OR @ProductID = 0 OR PM.ProductID=@ProductID) 
				and (@ProductDetailID IS NULL OR @ProductDetailID = 0 OR pd.ProductDetailID = @ProductDetailID) 
				and (@categoryName IS NULL OR c.CategoryName like '%'+@categoryName+'%' ) 
				and (@subcategoryName IS NULL OR s.SubCategoryName like '%'+@subcategoryName+'%') 
				and (@productName IS NULL OR PM.ProductName like '%'+@productName+'%') 
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetProductName]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

--exec SP_GetProductName 'Kno'
CREATE PROCEDURE [dbo].[SP_GetProductName]
	-- Add the parameters for the stored procedure here
	@ProductName Nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select ProductName,ProductID from ProductMaster with (nolock) where ProductName like'%'+@ProductName+'%' and IsActive=1
END





GO
/****** Object:  StoredProcedure [dbo].[SP_GetQuickAdv]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,Dineshd>
-- Create date: <Create Date,04.10.2014>
-- Description:	<Description,To get Quick Advertisements on Home Page>
-- =============================================
CREATE PROCEDURE [dbo].[SP_GetQuickAdv]
	@ID INT=NULL,
	@LangID INT=1
AS
BEGIN
	
	SET NOCOUNT ON;
	
	SELECT
		Q.ID,
		Q.ProductId,
		(CASE WHEN @LangID=1 THEN PM.ProductName ELSE PM.ProductName_LL END) AS ProductName,
		(CASE WHEN @LangID=1 THEN PM.ProductDescription ELSE PM.ProductDescription_LL END) AS ProductDescription,
		PM.Price,
		Q.ImagePath,
		Q.[Priority]

	FROM
		QuickAdv Q WITH (NOLOCK)
		LEFT OUTER JOIN ProductMaster PM WITH(NOLOCK) ON Q.ProductId=PM.ProductID

	WHERE
		(@ID IS NULL OR Q.ID=@ID OR @ID=0)

	ORDER BY
		[Priority]
END

--select * from ProductMaster
GO
/****** Object:  StoredProcedure [dbo].[SP_GetRejectedReports]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_GetRejectedReports] 
	
AS

BEGIN
	
	SELECT	 ReceiptID ,CONVERT(VARCHAR(13), ApplicationDate,103) as ApplicationDate ,ApplicantName,ClientName ,  email, MobileNo , RejectionReason
	 
		FROM	ShootingPermission s 

	where isapproved = 0 and (ShootDone =0 or ShootDone =null)


END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetRoleForAlter]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_GetRoleForAlter]

@RoleID as int = NULL

AS    

BEGIN    

	SELECT 
		ISNULL(RoleName,'') AS RoleName
		,ISNULL(RoleID,0) AS RoleID 
		,IsActive
		,ISNULL(ClientID,0) AS ClientID

	FROM 
		RoleMaster with (nolock) 
		
	WHERE 
		IsActive=1 
		AND (@RoleID IS NULL OR RoleID=@RoleID)  
		
	ORDER BY RoleID desc

END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetRoleIDName]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_GetRoleIDName]    
(
@ClientId	bigint = 1
,@RoleId	INT =null
)
AS    

BEGIN    
SELECT ISNULL(r.RoleName,'') AS RoleName , ISNULL(r.RoleID,0) AS RoleID ,r.IsActive
, ISNULL(r.ClientID,0) AS ClientID
,ISNULL(c.ClientName,'') AS ClientName
FROM RoleMaster r with (nolock)
join ClientMaster c with (nolock) on r.ClientID =c.ClientID
where r.IsActive=1  and r.ClientID=@ClientId
and (@RoleId IS NULL OR @RoleId=0 OR r.RoleID = @RoleId)
 ORDER BY r.RoleID desc

END

GO
/****** Object:  StoredProcedure [dbo].[SP_GetServiceTaxDetails]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetServiceTaxDetails] 
----------------------------------------------------------------------
-- Author:		<Vipul>
-- Create date: <01/09/2014>
-- Description:	<Get ServiceTax Details>
-----------------------------------------------------------------------
AS
BEGIN
		
		SELECT 
				ID,
				TaxRate
		FROM	dbo.TaxDetail WITH (NOLOCK)
		WHERE	TaxTypeId = 2
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetState]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================

-- Author:		<Lekha>

-- Create date: <22/09/2014>

-- Description:	<Get state value>

-- =============================================

CREATE PROCEDURE [dbo].[SP_GetState] 
	(@Langid INT = 1)
AS
BEGIN
	SELECT 
		Statecode 
		,CASE @Langid WHEN 1 THEN Statname ELSE Statename_LL END AS Statname

	FROM 
		dbo.Census_State WITH (NOLOCK)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetSubCategory]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--[SP_GetSubCategory] null,1,1,'',NULL,NULL
CREATE PROCEDURE [dbo].[SP_GetSubCategory]
(
	@CategoryId	INT =null
	,@ClientId	INT = 1
	,@LangId	INT = 1
	,@SubCategoryId	INT =null,
	@IsActive bit=null,
	@SubCategoryName Nvarchar(50)=null,
	@CategoryName Nvarchar(50)=null
)
----------------------------------------------------------------------
-- Author:		<Dinesh>
-- Create date: <09/09/2014>
-- Description:	<Get All Sub Category Details>
-----------------------------------------------------------------------
AS
BEGIN
		
		SELECT 
			
			s.SubCategoryID

			,CASE  @LangId 
					WHEN	1
					THEN  s.SubCategoryName
					ELSE  s.SubCategoryName_LL
			END AS SubCategoryName

			,C.CategoryID
			,CASE  @LangId
				WHEN	1
				THEN	C.CategoryName
				ELSE  C.CategoryName_LL
			END AS CategoryName,

			CASE s.IsActive WHEN 1 Then 'Yes' ELSE 'No' END AS IsActive

		FROM

			dbo.SubCategory S with (nolock) INNER JOIN dbo.CategoryMaster C with (nolock) ON S.CategoryID=C.CategoryID
			--left join dbo.SubCategory S1 ON S1.CategoryID=c.CategoryID
			--left join dbo.SubCategory S2 ON S2.CategoryID=c.CategoryID
			--left join dbo.SubCategory S3 ON S3.CategoryID=c.CategoryID
			--left join dbo.SubCategory S4 ON S4.CategoryID=c.CategoryID
			--left join dbo.SubCategory S5 ON S5.CategoryID=c.CategoryID

		WHERE
			S.ClientID	= @ClientId	 AND	(@SubCategoryId IS NULL OR @SubCategoryId=0 OR S.SubCategoryID = @SubCategoryId)
			AND (@CategoryId IS NULL OR	S.CategoryID = @CategoryId) and (@SubCategoryName IS NULL OR S.SubCategoryName like '%'+ @SubCategoryName+'%')
			AND  (@CategoryName IS NULL OR	C.CategoryName like '%'+ @CategoryName+'%')
			AND (@IsActive is null or s.IsActive=@IsActive)

			
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetSubDistrict]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetSubDistrict] (
	@Langid INT = 1
	,@Districtcode VARCHAR(3)
	)
AS
BEGIN
	SELECT Subdistrictcode
		,CASE @Langid
			WHEN 1
				THEN Subdistrictname
			ELSE Subdistrictname_LL
			END AS Subdistrictname
	FROM dbo.Census_subdistrict WITH (NOLOCK)
	WHERE Districtcode = @Districtcode
	ORDER BY Subdistrictname
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetSuppliers]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Dinesh>
-- Create date: <11/11/2014>
-- Description:	<Get Supplier Details>
-- =============================================

CREATE PROCEDURE [dbo].[SP_GetSuppliers]
(
	 @SupplierID		BIGINT=NULL
	,@IsActive			BIT=NULL
)

AS

BEGIN
		
		SELECT
			SupplierID
			,CompanyName
			,ContactName
			,[Address]
			,[State]
			,CS.[Statname] as 'StateName'
			,District
			,CD.[Districtname] as 'DistrictName'
			,[City]
			,Pincode
			,Phone
			,Mobile
			,CASE WHEN IsActive = 1 THEN 'Yes' ELSE 'No' END AS IsActive
		
		FROM
			dbo.Suppliers S WITH (NOLOCK)
			LEFT OUTER JOIN Census_State CS WITH (NOLOCK) ON S.[State]=CS.Statecode
			LEFT OUTER JOIN census_district CD WITH (NOLOCK) ON S.District=CD.Districtcode
		
		WHERE
			(@SupplierID IS NULL OR @SupplierID = 0 OR SupplierID=@SupplierID)
			AND (@IsActive IS NULL OR IsActive=@IsActive)
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetTransactionPaymentDetails]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_GetTransactionPaymentDetails] 
(
 @ClientId	bigint = 1
 ,@UserId	INT =null
 
--	,@IsActive	BIT=NULL
)
AS
BEGIN

 SELECT  *from paymentdetails p

 inner join ShootingPermission s

 on p.OrderId = s.ReceiptID
       
END 


 --   Receipt Number: strUniqueNo -- unique id returned 
 --Name: strPayeeName --
 -- Application Id: strApplicationTransactionID
 --  Transaction ID: strTransactionID
 --  Transaction Reference Number: strBankTransactionID
 --   Bank Reference Number:  strBankTransactionRefNo
	--Amount:  strAmount
	--Portal Fees: strPortalFee
	--Total: Total (in Words): strTotalAmount
	--Service: Date: strPaymentDate

GO
/****** Object:  StoredProcedure [dbo].[SP_GetTreeDemoCategory]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetTreeDemoCategory]

----------------------------------------------------------------------
-- Author:		<Dinesh>
-- Create date: <09/09/2014>
-- Description:	<Get All Sub Category Details>
-----------------------------------------------------------------------
AS
BEGIN
		
		SELECT 
			
			T.CategoryID
			,T.ParentID
			,T.CategoryName as ParentName
			,T.CategoryName_LL as ParentName_LL
			,T1.CategoryName
			,T1.CategoryName_LL
			

		FROM
			dbo.[TreeDemoCategory] T with (nolock)
			LEFT OUTER JOIN dbo.[TreeDemoCategory] T1 with (nolock) ON T.CategoryID=T1.ParentID
			
		WHERE
			T.IsActive= 1
END


GO
/****** Object:  StoredProcedure [dbo].[SP_GetUser]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetUser]
(
 @ClientId	bigint = 1
 ,@UserId	INT =null
 
--	,@IsActive	BIT=NULL
)
AS
BEGIN

		SELECT U.UserName,c.ClientName, R.RoleName,u.IsActive, u.Mobile_No ,u.ClientID --CASE U.IsActive WHEN 1 Then 'Yes' ELSE 'No' END AS IsActive
		,u.RoleID,u.Full_Name,u.Display_Name,U.eMail,U.UserID,U.UserPassword
				FROM
			dbo.UserMaster U with (nolock)
			JOIN dbo.RoleMaster R with (nolock) ON U.RoleID=R.RoleID 
			join ClientMaster c with (nolock) on c.ClientID= U.ClientID
		WHERE

				u.ClientID=@ClientId --	and  U.IsActive= 1  
				  and (@UserId IS NULL OR @UserId=0 OR u.UserID = @UserId)
	order by u.UserID desc
END 
GO
/****** Object:  StoredProcedure [dbo].[SP_GetUserProfile]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetUserProfile] 
(
	@UserID	INT 
)
AS
BEGIN
		SELECT 
		
		Full_Name,
		Display_Name,
		eMail,
		Mobile_No,
		AddressLine1,
		AddressLine2,
		AddressLine3,
		census_district,
		Census_subdistrict, 
		PinCode,
		UserName,
		AddressLine3


		FROM		dbo.UserMaster with (nolock)

		WHERE		UserID	= @UserID 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GetVATDetails]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GetVATDetails] 
----------------------------------------------------------------------
-- Author:		<Vipul>
-- Create date: <01/09/2014>
-- Description:	<Get VAT Details>
-----------------------------------------------------------------------
AS
BEGIN
		
		SELECT 
				ID,
				TaxRate
		FROM	dbo.TaxDetail WITH (NOLOCK)
		WHERE	TaxTypeId = 1
END



GO
/****** Object:  StoredProcedure [dbo].[SP_LoginCustomer]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Reshma	>
-- Create date: <6/9/2014>
-- Description:	<Customer Login>
-- =============================================
--exec SP_LoginCustomer 'test','Pass@123',null

CREATE PROCEDURE [dbo].[SP_LoginCustomer]

@EmailID nvarchar(200)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;
	declare @count int;

	  select CustomerID,EmailID,[Password] from Customer with (nolock)  where EmailID=@EmailID
END

 
  
GO
/****** Object:  StoredProcedure [dbo].[SP_OrderDelivery]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_OrderDelivery]

(
	@OrderId	            BIGINT 
	,@IsDelivered			BIT
	,@DeliveryDate			datetime
	,@CreatedBy				BIGINT
	,@Remark                Nvarchar(400)
	,@result				INT OUTPUT
)

AS

BEGIN
	DECLARE @intErrorCode INT
	SET @result=1;

	BEGIN TRAN

		INSERT INTO	dbo.OrderDelivery
		(
			OrderId
			,IsDelivered
			,DeliveryDate
			,CreatedBy
			,CreatedOn
			,Remark
		)

		VALUES
		(
			@OrderId
			,@IsDelivered
			,@DeliveryDate
			,@CreatedBy
			,GETDATE()
			,@Remark
		)

		SELECT @intErrorCode=@@ERROR

		UPDATE DispatchOrder 
		SET IsDelivered=1
		WHERE OrderID=@OrderId

		SELECT @intErrorCode = @@ERROR

		IF (@intErrorCode <> 0) GOTO PROBLEM

	COMMIT TRAN

	PROBLEM:
	IF (@intErrorCode <> 0)
	BEGIN
		PRINT 'Unexpected error occurred!'
		SET @result=@intErrorCode
		ROLLBACK TRAN
	END

END
GO
/****** Object:  StoredProcedure [dbo].[SP_RegenerateOTP]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RegenerateOTP]      


 @userid bigint,

 @RandomNo Bigint = null,

 @CurrentTime Datetime      

AS      

BEGIN    
 SET NOCOUNT Off;      

         

Update dbo.UserMaster        

set 

    RandomNo=@RandomNo ,CurrentTime    =@CurrentTime


    where UserID =@userid

END      

    

    

GO
/****** Object:  StoredProcedure [dbo].[SP_RegisterCustomer]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Reshma	>
-- Create date: <6/9/2014>
-- Description:	<Insert customer data>
-- =============================================
CREATE PROCEDURE [dbo].[SP_RegisterCustomer]
@CustomerID uniqueidentifier,
@CustomerName nvarchar(200),
@eMail nvarchar(100),
@Mobile nvarchar(100),
@Password nvarchar(200),
@CreatedBy int,
@CreatedDate datetime



AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	
INSERT INTO [dbo].[Customer]
           ([CustomerID]
           ,[CustomerName]
           ,[EmailID]
           ,[Mobile]
           ,[Password]
           ,[CreatedBy]
           ,[CreatedDate])
     VALUES
           (@CustomerID
           ,@CustomerName
           ,@eMail
           ,@Mobile
           ,@Password
           ,@CreatedBy
           ,@CreatedDate)
   
END

GO
/****** Object:  StoredProcedure [dbo].[SP_ResetPassword]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  

CREATE PROCEDURE [dbo].[SP_ResetPassword]  

@Username varchar(100),  

@UserPassword varchar(100),

@ForgotPasswordToken uniqueidentifier


As  

  BEGIN  

  UPDATE usermaster  

     SET    UserPassword=@UserPassword,

      ForgotPasswordToken='00000000-0000-0000-0000-000000000000'   , IsLocked =0

     WHERE	 Username=@Username 

	 and ForgotPasswordToken= @ForgotPasswordToken   

END 
GO
/****** Object:  StoredProcedure [dbo].[SP_RoleMaster]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RoleMaster]

	 @RoleID int
	,@RoleName NVARCHAR(100)
	,@ClientID bigint
	,@IsActive BIT-- nvarchar(10) --
	,@Flag nvarchar(10) --bit
AS
BEGIN
	SET NOCOUNT ON;

	if Exists(select roleid from Rolemaster with (nolock) where RoleID=@RoleID)
	Begin
	print 'update' 
		Update [dbo].RoleMaster set RoleName=@RoleName,ClientID=@ClientID,IsActive=@IsActive where RoleID=@RoleID 

	end
	else
	Begin	
	print 'insert'		
		INSERT INTO [dbo].RoleMaster(RoleName,ClientID,[IsActive])
		values
        (@RoleName , @ClientID,@IsActive)
	End

	--IF (@Flag ='Add')
	--BEGIN
	--	INSERT INTO [dbo].RoleMaster(RoleName,ClientID,[IsActive])
	--	VALUES (@RoleName,@ClientID,@IsActive)
	--end
	--else if(@Flag='Update')
	--begin
	--update RoleMaster set RoleName =@RoleName , ClientID =@ClientID , IsActive =@IsActive where RoleID =@RoleID
	--end
	-- else if (@Flag='Delete')
	--begin
	--update RoleMaster set  IsActive =0 where RoleID =@RoleID
	--end
	
END




GO
/****** Object:  StoredProcedure [dbo].[SP_RptDeliveryDetails]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--exec SP_RptDeliveryDetails '2014-10-31','2014-11-30'
CREATE PROCEDURE [dbo].[SP_RptDeliveryDetails]
(
	@DeliveryFromdate datetime	,
	@DeliveryTodate datetime	
)
----------------------------------------------------------------------
-- Author:		<Reshma>
-- Create date: <12/11/2014>
-- Description:	<Get dispatched details>
-----------------------------------------------------------------------
AS
BEGIN		
		
		select convert(varchar(15),de.DeliveryDate,106) as DeliveryDate,de.OrderDeliveryID,DO.DispatchOrderID,do.DispatchType,do.InvoiceNumber,
		pm.ProductName,do.IsDelivered,do.DeliveryChannel,de.Remark,do.HasBeenShipped,cm.CourierName  from DispatchOrder DO  with (nolock) inner join OrderDetail OD  with (nolock)
		on do.OrderId=od.OrderId inner join CourierMaster cm  with (nolock) on DO.Courier=cm.CourierID inner join ProductMaster pm  with (nolock)
		on pm.ProductID=od.ProductId INNER JOIN Orders O  with (nolock) ON O.OrderId=DO.OrderId inner join OrderDelivery de   with (nolock) on de.OrderId=OD.OrderId
		where de.DeliveryDate>=@DeliveryFromdate and de.DeliveryDate<=@DeliveryTodate

END

--select * from DispatchOrder

--select * from OrderDelivery
--select * from Orders
--select * from OrderDetail
GO
/****** Object:  StoredProcedure [dbo].[SP_RptDispatchDetails]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--exec [SP_RptDispatchDetails] '2014-10-31','2014-11-05'
CREATE PROCEDURE [dbo].[SP_RptDispatchDetails]
(
	@dispatchFromdate datetime	,
	@dispatchTodate datetime	
)
----------------------------------------------------------------------
-- Author:		<Reshma>
-- Create date: <11/11/2014>
-- Description:	<Get dispatched details>
-----------------------------------------------------------------------
AS
BEGIN		
		select convert(varchar(15),do.DispatchDate,106) as DispatchDate,DO.DispatchOrderID,do.DispatchType,do.InvoiceNumber,
		pm.ProductName,do.IsDelivered,do.DeliveryChannel,
		do.OrderId,do.HasBeenShipped,cm.CourierName  from DispatchOrder DO  with (nolock) inner join OrderDetail OD  with (nolock)
		on do.OrderId=od.OrderId inner join CourierMaster cm  with (nolock) on DO.Courier=cm.CourierID inner join ProductMaster pm  with (nolock)
		on pm.ProductID=od.ProductId INNER JOIN Orders O  with (nolock) ON O.OrderId=DO.OrderId
		where do.DispatchDate>=@dispatchFromdate and do.DispatchDate<= DATEADD(day,1,@dispatchTodate)
END



GO
/****** Object:  StoredProcedure [dbo].[SP_RptOrderDetails]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--exec SP_RptOrderDetails '2014-10-30','2014-11-01'
CREATE  PROCEDURE [dbo].[SP_RptOrderDetails]

	@orderFromdate datetime	,
	@orderTodate datetime	

----------------------------------------------------------------------
-- Author:		<Reshma>
-- Create date: <11/10/2014>
-- Description:	<Get Order Details>
-----------------------------------------------------------------------
AS
BEGIN		
		select  o.OrderId, OD.UnitPrice,OD.Quantity,o.HasBeenShipped,o.ShippingAddress,Convert(varchar(15),o.OrderDate,106) as OrderDate,
		PM.ProductName,o.FullName from Orders O  with (nolock) INNER join OrderDetail OD  with (nolock)
		 on o.OrderId=od.OrderId INNER JOIN ProductMaster PM  with (nolock) ON OD.ProductId=PM.ProductID
		 where o.OrderDate >=@orderFromdate and o.OrderDate<=@orderTodate
END


--select * from Orders
--select * from ProductMaster
GO
/****** Object:  StoredProcedure [dbo].[SP_RptProductDetails]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RptProductDetails]
(
	@productName		nvarchar(200) = null,
	@categoryName nvarchar(100) = null,
	@subcategoryName nvarchar(100) = null
)
----------------------------------------------------------------------
-- Author:		<Dinesh>

-- Create date: <27/11/2014>

-- Description:	<Get Product Details for Report>

-- Example : exec [SP_RptProductDetails] 3,null

-----------------------------------------------------------------------
AS
BEGIN
	SELECT
		PM.ProductID
		,PM.ProductName
		,ProductName_LL

		,C.CategoryID				
		,C.CategoryName

		,S.SubCategoryID
		,S.SubCategoryName

		,PM.ProductDescription
		,PM.ProductDescription_LL		

		,PM.Author
		,PM.Author_LL

		,PM.Publisher
		,PM.Publisher_LL
		
		,PM.[Language]
		,PM.Language_LL
		
		,PM.Pages
		,ISNULL(PM.Price,0.00) as Price
		,PM.Thumbnail
		,ProductName
		,Unit
		,Price
		,PM.BasePrice
		,PM.MahaonlineCharges
		,PM.ShippingCharges
		,PM.VAT
		,PM.ServiceTax
		,PM.IsActive

		,PD.productDetailid
		,PD.Size as 'ProductSize'
		,PD.Quantity
		,PD.Unit
	FROM
		dbo.ProductMaster  PM WITH (NOLOCK)
		LEFT OUTER JOIN	dbo.SubCategory S WITH (NOLOCK) ON PM.SubCategoryID = S.SubCategoryID
		LEFT OUTER JOIN	dbo.CategoryMaster C WITH (NOLOCK) ON S.CategoryID = C.CategoryID
		LEFT OUTER JOIN	dbo.ProductDetails PD WITH (NOLOCK) ON PM.ProductID = PD.ProductID

	WHERE
		(@categoryName IS NULL OR c.CategoryName like '%'+categoryName+'%') 
		and (@subcategoryName IS NULL OR s.SubCategoryName like '%'+subcategoryName+'%') 
		and (@productName IS NULL OR PM.ProductName like '%'+@productName+'%') 
END

--select *  from ProductDetails
--select * from ProductMaster
GO
/****** Object:  StoredProcedure [dbo].[SP_RptSummaryDetails]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--exec [SP_RptSummaryDetails] '2014-10-1','2014-11-30'
CREATE PROCEDURE [dbo].[SP_RptSummaryDetails]
(
	@Fromdate datetime	,
	@Todate datetime	
)
----------------------------------------------------------------------
-- Author:		<Reshma>
-- Create date: <12/11/2014>
-- Description:	<Get dispatched details>
-----------------------------------------------------------------------
AS
BEGIN	

		select  o.OrderId, OD.UnitPrice,OD.Quantity,o.HasBeenShipped,Convert(varchar(15),DO.DispatchDate,106) As DispatchDate,
		 CASE DO.DeliveryChannel WHEN 'U' then 'User' when 'C' then 'Courier' end as 'DeliveryChannel', 
		CASE DO.DeliveryChannel WHEN 'U' then do.[User] when 'C' then cm.CourierName end as 'DeliveryBy' ,do.IsDelivered,
		o.ShippingAddress,Convert(varchar(15),o.OrderDate,106) as OrderDate,Convert(varchar(15),ode.DeliveryDate,106) as DeliveryDate,
		PM.ProductName,o.FullName from Orders O with (nolock) INNER join OrderDetail OD  with (nolock)
		 on o.OrderId=od.OrderId INNER JOIN ProductMaster PM  with (nolock)
		 ON OD.ProductId=PM.ProductID inner join DispatchOrder DO  with (nolock)
		 on DO.OrderId=O.OrderId left outer join OrderDelivery ode  with (nolock) on o.OrderId=ode.OrderId inner join CourierMaster cm  with (nolock) on DO.Courier=cm.CourierID	
		 where OrderDate>=@Fromdate and OrderDate<=@Todate
END



--select * from DispatchOrder

--select * from OrderDelivery

--select * from Orders
--select * from OrderDetail
--select * from productmaster
GO
/****** Object:  StoredProcedure [dbo].[SP_SearchProducts]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================



-- Author:		ROHAN



-- Create date: 10-12-2014







-- =============================================



CREATE PROCEDURE [dbo].[SP_SearchProducts] 



	-- Add the parameters for the stored procedure here



	@keyword nvarchar(1000)



	



AS



BEGIN



	-- SET NOCOUNT ON added to prevent extra result sets from



	-- interfering with SELECT statements.



	SET NOCOUNT ON;







    -- Insert statements for procedure here



	

SELECT PM.ProductName,CM.CategoryName ,SC.SubCategoryName,CM.CategoryID, SC.SubCategoryID  FROM PRODUCTMASTER PM

INNER JOIN SubCategory SC

ON PM.SubCategoryID = SC.SubCategoryID

INNER JOIN CategoryMaster CM

ON SC.CategoryID = CM.CategoryID

WHERE ProductName LIKE '%' + @keyword + '%' AND PM.ISACTIVE = 1 





END

GO
/****** Object:  StoredProcedure [dbo].[SP_SetIsLocked]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

  

CREATE PROCEDURE [dbo].[SP_SetIsLocked]  

@Userid bigint

As  

  BEGIN  

  UPDATE usermaster  

     SET     IsLocked =1

     WHERE	 UserID=@Userid

END 

GO
/****** Object:  StoredProcedure [dbo].[SP_ShootingPermissionAppln]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ShootingPermissionAppln]

@ApplicationDate datetime ,
@ApplicantName nvarchar(500),
@ApplicantAddress1 nvarchar(500) ,
@ApplicantAddress2 nvarchar(500) =null,
@ApplicantDesignation nvarchar(200) ,
@IsValid bit ,
@IsNatural bit,
@IsAnimal bit,
@ClientName nvarchar(500) , 
@ClientName_ll nvarchar(500),
@ClientAddress1 nvarchar(500) ,
@ClientAddress1_ll nvarchar(500),
@ClientAddress2 nvarchar(500) = null,
@ClientAddress2_ll nvarchar(500) = null,
@ShootDate datetime,
@Days int,
@FilmName nvarchar(500),
@FilmName_ll nvarchar(500),
@FilmPlace nvarchar(500),
@FilmPlace_ll nvarchar(500),
@ShootDetails nvarchar(500) = null,
@Adults int,
@Childs int,
@TwoWheelers int,
@FourWheelers int,
@Bus_Heavy_vehicls int,
@LangID int = 0,
@email nvarchar(400),
@MobileNo nvarchar(20),
@Path nvarchar(1000),
@ApplicantID bigint OUTPUT -- It's a ReceiptID
--@RejectionReason nvarchar(500),
--@PrintOption varchar(50),
--@isapproved bit,
--@isrejected bit,
--@shootingAmount decimal(18, 2),
--@DepositAmount decimal(18, 2),
--@TotalAmount decimal(18, 2),


--- ShootDone =0 if shooting not done after completeion of shooting it set to 1 or on rejection
AS  
Begin
    SET NOCOUNT ON;

	set @ApplicationDate =   getdate() --CONVERT(VARCHAR(10), GETDATE(), 103)

   insert into ShootingPermission (ApplicationDate,ApplicantName,ApplicantAddress1,ApplicantAddress2,ApplicantDesignation,isvalid,IsNatural,IsAnimal,
									ClientName,ClientName_ll,ClientAddress1,ClientAddress1_ll,ClientAddress2,ClientAddress2_ll,ShootDate,Days,
									FilmName,FilmName_ll,FilmPlace,FilmPlace_ll,ShootDetails,RejectionReason,Adults,Childs,TwoWheelers,FourWheelers,
									Bus_Heavy_vehicls,LangID,email,MobileNo,PrintOption,isapproved,isrejected,shootingAmount,DepositAmount,TotalAmount,ShootDone )
				 values

							    (@ApplicationDate,@ApplicantName,@ApplicantAddress1,@ApplicantAddress2,@ApplicantDesignation,@IsValid,@IsNatural,@IsAnimal,
									@ClientName,@ClientName_ll,@ClientAddress1,@ClientAddress1_ll,@ClientAddress2,@ClientAddress2_ll,@ShootDate,@Days,
									@FilmName,@FilmName_ll,@FilmPlace,@FilmPlace_ll,@ShootDetails,null,@Adults,@Childs,@TwoWheelers,@FourWheelers,
									@Bus_Heavy_vehicls,@LangID,@email,@MobileNo,null,null,null,null,null,null,0 )


	set @ApplicantID =  SCOPE_IDENTITY();
	
	insert into ShootingIdentityDocs (ApplicantId,ApplicantName,ApplicantDesignation,clientname,ImagePath,CreatedDate)
	values (@ApplicantID , @ApplicantName,@ApplicantDesignation,@ClientName,@Path,@ApplicationDate)
	
	return @ApplicantID


end
GO
/****** Object:  StoredProcedure [dbo].[SP_SubCategory]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_SubCategory] 

     @CategoryID INT
	,@SubCategoryID BIGINT
	,@SubCategoryName NVARCHAR(100)
	,@SubCategoryName_LL NVARCHAR(100)
	,@ClientID INT
	,@IsActive BIT
	,@CreatedBy INT
	,@ModifiedBy INT AS

BEGIN
	SET NOCOUNT ON;

	IF EXISTS (
			SELECT *
			FROM SubCategory with (nolock)
			WHERE SubCategoryID = @SubCategoryID
			)
	BEGIN
		PRINT 'update'

		UPDATE [dbo].[SubCategory]
		SET CategoryID = @CategoryID
			,SubCategoryName = @SubCategoryName
			,SubCategoryName_LL = @SubCategoryName_LL
			,IsActive = @IsActive
		WHERE SubCategoryID = @SubCategoryID
			AND ClientID = @ClientID
	END
	ELSE
	BEGIN
		PRINT 'insert'

		INSERT INTO [dbo].[SubCategory] (
			[CategoryID]
			,[SubCategoryName]
			,[SubCategoryName_LL]
			,[ClientID]
			,[IsActive]
			)
		VALUES (
			@CategoryID
			,@SubCategoryName
			,@SubCategoryName_LL
			,@ClientID
			,@IsActive
			)
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Supplier]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Dinesh>
-- Create date: <11/11/2014>
-- Description:	<Add Updte Supplier Details>
-- =============================================

CREATE PROCEDURE [dbo].[SP_Supplier]
	 @SupplierID			BIGINT=NULL
	,@CompanyName		NVARCHAR(200)
	,@ContactName		NVARCHAR(100)
    ,@Address			NVARCHAR(300)
	,@City				NVARCHAR(300)
	,@District			NVARCHAR(300)
	,@State				int
	,@Pincode			NVARCHAR(300)
    ,@Phone				NVARCHAR(15)
    ,@Mobile			NVARCHAR(15)
	,@IsActive			Bit
	,@CreatedBy			BIGINT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF EXISTS(SELECT @SupplierID FROM Suppliers WHERE SupplierID=@SupplierID)
	BEGIN
		
		UPDATE
			[dbo].Suppliers 
		
		SET
			 CompanyName=@CompanyName
			,ContactName=@ContactName
			,[Address]=@Address
			,City=@City
			,District=@District
			,[State]=@State
			,Pincode=@Pincode
			,Phone=@Phone
			,Mobile=@Mobile
			,IsActive=@IsActive 
		WHERE
			SupplierID=@SupplierID

	END
	ELSE
	BEGIN

		INSERT INTO [dbo].Suppliers
		(
			 CompanyName
			,ContactName
			,[Address]
			,City
			,District
			,[State]
			,Pincode
			,Phone
			,Mobile
			,IsActive
			,CreatedBy
			,CreatedOn
		)

		VALUES
        (
			 @CompanyName
			,@ContactName
			,@Address
			,@City
			,@District
			,@State
			,@Pincode
			,@Phone
			,@Mobile
			,@IsActive
			,@CreatedBy
			,GETDATE()
		)

	END
END


GO
/****** Object:  StoredProcedure [dbo].[SP_TakeAction]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_TakeAction]

	 @ReceiptID bigint

	,@Isapproved bit

	,@ShootingAmount decimal(18,2)

	,@DepositeAmount decimal(18,2)

	,@TotalAmount decimal(18,2)

	,@ReasonForRejection varchar(500)

	,@Molcharges decimal (18,2)

AS

BEGIN

	SET NOCOUNT ON;

	Begin

	print 'update' 

		Update [dbo].ShootingPermission set isapproved=@Isapproved, shootingAmount=@ShootingAmount , DepositAmount=@DepositeAmount ,TotalAmount=@TotalAmount , RejectionReason =@ReasonForRejection

		, isrejected = 'Action Taken' , molcharges =@Molcharges --- to differentiate the records which are taken under action & those which are not gone under action
		
		 where ReceiptID=@ReceiptID
			
	end
END







GO
/****** Object:  StoredProcedure [dbo].[SP_TrackMyOrder]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--EXEC [SP_TrackMyOrder] 'rohan.prabhu@mahaonline.gov.in','2'
CREATE PROCEDURE [dbo].[SP_TrackMyOrder] (
	@OrderID NVARCHAR(10)=NULL
	,@ShippingAddress NVARCHAR(200)=NULL
	,@CustomerName NVARCHAR(200)=NULL
	,@LangID		INT=  1
	,@Email NVARCHAR(50)=NULL
)
----------------------------------------------------------------------
-- Author:		<Dinesh>
-- Create date: <13/10/2014>
-- Description:	<To get invoice details>
----------------------------------------------------------------------
AS
BEGIN

	SELECT
		O.OrderId,
		PM.ProductID,
		PM.ProductName,
		
		O.FullName as CustomerName,
		(
			O.ShippingAddress
			+ CASE LTRIM(RTRim(ISNULL(O.City,''))) WHEN '' THEN '' ELSE ', CITY : '+ O.City END +
			+ CASE LTRIM(RTRim(ISNULL(O.States,''))) WHEN '' THEN '' ELSE ', STATE : '+ O.States END
			+ CASE LTRIM(RTRim(ISNULL(O.Landmark,''))) WHEN '' THEN '' ELSE ', Landmark : '+ O.Landmark END
			+ CASE LTRIM(RTRim(ISNULL(O.PinCode,''))) WHEN '' THEN '' ELSE ', PinCode : '+ O.PinCode END
		) AS [ShippingAddress],
		(CASE LTRIM(RTRIM(ISNULL(O.Mobile,''))) WHEN '' THEN '' ELSE 'Mo.- ' + O.Mobile END + CASE LTRIM(RTRIM(ISNULL(O.Email,''))) WHEN '' THEN '' ELSE ', Email : ' + O.Email END) AS ContactDetails,
		CONVERT(VARCHAR(13),O.OrderDate,101) as OrderDate,
		CASE D.HasBeenShipped WHEN 1 THEN 'Yes' ELSE 'No' END AS HasBeenShipped,
		CASE D.HasBeenShipped WHEN 1 THEN CONVERT(VARCHAR(13), D.DispatchDate,103) ELSE 'NA' END AS DispatchDate,
		CASE D.HasBeenShipped WHEN 1 THEN D.DeliveryChannel ELSE 'NA' END AS DeliveryChannel,
		CASE D.HasBeenShipped WHEN 1 THEN D.InvoiceNumber ELSE 'NA' END AS InvoiceNumber,
		CASE D.HasBeenShipped WHEN 1 THEN C.CourierName ELSE 'NA' END AS CourierName,
		CASE D.HasBeenShipped WHEN 1 THEN U.Full_Name ELSE 'NA' END AS UserName,
		CASE OD.IsDelivered WHEN 1 THEN 'Yes' ELSE 'No' END AS IsDelivered,
		CASE OD.IsDelivered WHEN 1 THEN CONVERT(VARCHAR(13), OD.DeliveryDate,103) ELSE 'NA' END AS DeliveryDate,

		IsNull(ODT.Quantity,0) AS Quantity,
		IsNull(PM.Price,0.00) AS Price,
		(IsNull(ODT.Quantity,0) * IsNull(PM.Price,0.00)) AS NetAmount,
		IsNull(O.subTotal,0.00) AS subTotal,
		IsNull(O.MolPortalCharges,0.00) AS MolPortalCharges,
		IsNull(O.MolServiceCharges,0.00) AS MolServiceCharges,
		IsNull(O.Total,0.00) AS Total
		
	FROM
		ORDERS O
		LEFT OUTER JOIN OrderDetail ODT ON O.OrderId=ODT.OrderId
		LEFT OUTER JOIN DispatchOrder D ON O.OrderId=D.OrderId
		LEFT OUTER JOIN OrderDelivery OD ON O.OrderId=OD.OrderId
		LEFT OUTER JOIN CourierMaster C ON D.Courier=C.CourierID
		LEFT OUTER JOIN UserMaster U ON C.UserID=U.UserID
		LEFT OUTER JOIN ProductMaster PM ON ODT.ProductId=PM.ProductID

	 WHERE
		 (@Email IS NULL OR O.Email=@Email)

		ORDER BY O.OrderDate DESC
END

--select * from Orders
--select * from  DispatchOrder

---select * from  UserMaster
GO
/****** Object:  StoredProcedure [dbo].[SP_TrackOrders]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--EXEC [SP_TrackOrders] null,null,null,2,'dinesh.dalvi@mahaonline.gov.in'
CREATE PROCEDURE [dbo].[SP_TrackOrders] (
	--@DispatchOrderId	INT = NULL,
	 @OrderID NVARCHAR(10)=NULL
	,@ShippingAddress NVARCHAR(200)=NULL
	,@CustomerName NVARCHAR(200)=NULL
	,@LangID		INT=  1
	,@Email NVARCHAR(50)=NULL
)
----------------------------------------------------------------------
-- Author:		<Dinesh>
-- Create date: <13/10/2014>
-- Description:	<To get invoice details>
----------------------------------------------------------------------
AS
BEGIN

	SELECT
		O.OrderId,
		isnull (dbo.fnProductName(D.OrderId),'') as ProductName,
		
		O.FullName as CustomerName,
		(
			O.ShippingAddress
			+ CASE LTRIM(RTRim(ISNULL(O.City,''))) WHEN '' THEN '' ELSE ', CITY : '+ O.City END +
			+ CASE LTRIM(RTRim(ISNULL(O.States,''))) WHEN '' THEN '' ELSE ', STATE : '+ O.States END
			+ CASE LTRIM(RTRim(ISNULL(O.Landmark,''))) WHEN '' THEN '' ELSE ', Landmark : '+ O.Landmark END
			+ CASE LTRIM(RTRim(ISNULL(O.PinCode,''))) WHEN '' THEN '' ELSE ', PinCode : '+ O.PinCode END
		) AS [ShippingAddress],
		(CASE LTRIM(RTRIM(ISNULL(O.Mobile,''))) WHEN '' THEN '' ELSE 'Mo.- ' + O.Mobile END + CASE LTRIM(RTRIM(ISNULL(O.Email,''))) WHEN '' THEN '' ELSE ', Email : ' + O.Email END) AS ContactDetails,
		CONVERT(VARCHAR(13),O.OrderDate,103) as OrderDate,
		CASE D.HasBeenShipped WHEN 1 THEN 'Yes' ELSE 'No' END AS HasBeenShipped,
		CASE D.HasBeenShipped WHEN 1 THEN CONVERT(VARCHAR(13), D.DispatchDate,103) ELSE 'NA' END AS DispatchDate,
		CASE D.HasBeenShipped WHEN 1 THEN D.DeliveryChannel ELSE 'NA' END AS DeliveryChannel,
		CASE D.HasBeenShipped WHEN 1 THEN D.InvoiceNumber ELSE 'NA' END AS InvoiceNumber,
		CASE D.HasBeenShipped WHEN 1 THEN C.CourierName ELSE 'NA' END AS CourierName,
		CASE D.HasBeenShipped WHEN 1 THEN U.Full_Name ELSE 'NA' END AS UserName,
		CASE OD.IsDelivered WHEN 1 THEN 'Yes' ELSE 'No' END AS IsDelivered,
		CASE OD.IsDelivered WHEN 1 THEN CONVERT(VARCHAR(13), OD.DeliveryDate,103) ELSE 'NA' END AS DeliveryDate,

		0 As Quantity,
		0.00 AS Price,
		0.00 AS NetAmount,
		0.00 As subTotal,
		0.00 AS MolPortalCharges,
		0.00 AS MolServiceCharges,
		0.00 AS Total
		
	FROM
		ORDERS O
		LEFT OUTER JOIN DispatchOrder D ON O.OrderId=D.OrderId
		LEFT OUTER JOIN OrderDelivery OD ON O.OrderId=OD.OrderId
		LEFT OUTER JOIN CourierMaster C ON D.Courier=C.CourierID
		LEFT OUTER JOIN UserMaster U ON C.UserID=U.UserID
	 WHERE
		(@ShippingAddress IS NULL OR O.ShippingAddress LIKE '%'+@ShippingAddress+'%' OR O.City LIKE '%'+@ShippingAddress+'%')
		AND (@CustomerName IS NULL OR O.FullName LIKE '%'+@CustomerName+'%')
		AND (@OrderID IS NULL OR O.OrderId = @OrderID)

	ORDER BY O.OrderDate DESC
END

--select * from Orders
--select * from  DispatchOrder

---select * from  UserMaster
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateChangePassword]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[SP_UpdateChangePassword]  

@UserID bigint,  

@UserPassword varchar(100)



As  

  BEGIN  

  UPDATE usermaster  

     SET    UserPassword=@UserPassword

     

     WHERE	 UserID=@UserID 

	 

END 
GO
/****** Object:  StoredProcedure [dbo].[SP_UpdateChangePasswordForCusrtomer]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[SP_UpdateChangePasswordForCusrtomer]  

@CustomerID uniqueidentifier,  

@Password nvarchar(100)



As  

  BEGIN  

  UPDATE Customer  

     SET    Password=@Password 

     

     WHERE	 CustomerID=@CustomerID 

	 

END 
GO
/****** Object:  StoredProcedure [dbo].[SP_UserMaster]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_UserMaster]

	 @UserID int
	,@UserName NVARCHAR(100)
	,@eMail NVARCHAR(100)
	,@UserPassword NVARCHAR(100)
	,@ClientID INT
	,@RoleID int
	,@IsActive bit
	,@CreatedBy int
	,@CreatedDate datetime
	,@ModifiedBy int
	,@ModifiedDate datetime
	,@MobileNo Varchar(15) = null
	,@Message varchar(100) OUTPUT
	
	--,@Flag varchar(10)
AS

BEGIN
	SET NOCOUNT ON;

if Exists(select userid from UserMaster where UserID=@UserID)
			Begin
			print 'update' 
				Update [dbo].UserMaster set ClientID=@ClientID, RoleID=@RoleID,ModifiedBy=@ModifiedBy,ModifiedDate=@ModifiedDate,IsActive =@IsActive , Mobile_No=@MobileNo  where UserID =@UserID

			end
else
	Begin	
			print 'insert'	
				
		 if exists (select username from UserMaster where UserName =@UserName and IsActive =1)
			begin
				set @Message ='UserName is already created .Kindly Choose other UserName.'
				return
			end
		else if exists (select email from UserMaster where eMail =@eMail and IsActive =1)
			begin
				set @Message='Email ID is already registered.Kindly enter other EmailID.'
				return
			end
		else
			begin		
				INSERT INTO [dbo].UserMaster(UserName,eMail,UserPassword,RoleID,ClientID,IsActive,CreatedBy,CreatedDate,Mobile_No)
				VALUES (@UserName ,@eMail,@UserPassword,@RoleID,@ClientID,@IsActive ,@CreatedBy ,@CreatedDate,@MobileNo)

				set @Message =''
				return
			End
	end

	--IF (@Flag ='Add')
	--BEGIN
	--	INSERT INTO [dbo].UserMaster(UserName,eMail,UserPassword,RoleID,ClientID,IsActive,CreatedBy,CreatedDate)
	--	VALUES (@UserName ,@eMail,@UserPassword,@RoleID,@ClientID,@IsActive ,@CreatedBy ,@CreatedDate)
	--end
	--else if(@Flag='Update')
	--begin
	--	 update UserMaster set  eMail =@eMail , ClientID =@ClientID ,RoleID =@RoleID ,
	--	 UserPassword =@UserPassword , ModifiedBy =@ModifiedBy , ModifiedDate =@ModifiedDate  where UserID=@UserID
	--end
	-- else if (@Flag='Delete')
	--begin
	--	update UserMaster set  IsActive =0 where UserID =@UserID
	--end
	
END





GO
/****** Object:  StoredProcedure [dbo].[SP_UserProfile]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_UserProfile]


@UserID bigint,
@Full_Name nvarchar(50),
@Display_Name nvarchar (50),
@AddressLine1 nvarchar(300),
@AddressLine2 nvarchar(300),
@AddressLine3 nvarchar(300),
@eMail nvarchar(50),
@Mobile_No nvarchar(13),
@PinCode nvarchar(6),
@census_district nvarchar(50),
@Census_subdistrict nvarchar(50),
@ModifiedBy int,
@UserName nvarchar(50)
--@ModifiedDate int

AS

BEGIN

 
--Declare @UserIdFind Bigint 
--Set @UserIdFind = ( select userid from UserMaster where UserID=@UserID);

if EXISTS(select userid from UserMaster where UserID=@UserID)
begin
		Update 
		UserMaster 
		set 
			Full_Name=@Full_Name, 
			Display_Name=@Display_Name,
			AddressLine1=@AddressLine1,
			AddressLine2=@AddressLine2,
			AddressLine3=@AddressLine3,
			eMail=@eMail,
			Mobile_No=@Mobile_No,
			Pincode=@PinCode,
			census_district=@census_district,
			Census_subdistrict=@Census_subdistrict,
			ModifiedBy= @ModifiedBy,
			ModifiedDate= getdate(),
			UserName=@UserName
		where 
			UserID =@UserID

end
--else
--begin

--End
End

GO
/****** Object:  StoredProcedure [dbo].[SPProductMaster]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Reshma>
-- Create date: <30/8/2014>
-- Description:	<Add Update Delete ProductMaster>
-- =============================================
CREATE PROCEDURE [dbo].[SPProductMaster] 
@SubCategoryID  nvarchar(200),
@ProductName_LL  nvarchar(200),
@ProductName int,
@ClientID Bit,
@IsActive bit,
@CreatedBy int,
@CreatedDate datetime,
@ModifiedBy int,
@ModifiedDate datetime,
@OrderBy int,
@OrderDate datetime,
@Query int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	if(@Query=1)
	BEGIN
		INSERT INTO [dbo].[ProductMaster]
           ([SubCategoryID]
           ,[ProductName_LL]
           ,[ProductName]
           ,[ClientID]
           ,[IsActive]
           ,[CreatedBy]
           ,[CreatedDate]
           ,[ModifiedBy]
           ,[ModifiedDate]
           ,[OrderBy]
           ,[OrderDate])
     VALUES
           (@SubCategoryID
           ,@ProductName_LL
           ,@ProductName
           ,@ClientID
           ,@IsActive
           ,@CreatedBy
           ,@CreatedDate
           ,@ModifiedBy
           ,@ModifiedDate
           ,@OrderBy
           ,@OrderDate)
	END

END

GO
/****** Object:  Synonym [dbo].[mstServices]    Script Date: 18-12-2014 15:22:18 ******/
CREATE SYNONYM [dbo].[mstServices] FOR [MahaFrame].[dbo].[mstServices]
GO
/****** Object:  UserDefinedFunction [dbo].[fnProductName]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Function [dbo].[fnProductName] 
(
	@OrderId INT
)

returns varchar(101)
Begin 
 return  (select (STUFF((SELECT '; ' + PM.ProductName+ '(Qty: ' + CONVERT(VARCHAR(13), OD.Quantity) + ')'
         FROM  Orders O
			LEFT OUTER JOIN OrderDetail OD ON O.OrderId = OD.OrderId
			LEFT OUTER JOIN ProductMaster PM ON OD.ProductId = PM.ProductId              
              where(O.OrderId=@OrderId)
              group by O.OrderId,PM.ProductName,OD.Quantity
              ORDER BY ProductName
              FOR XML PATH('')), 1, 1, '')) AS 'ProductName(Quantity)');
end

GO
/****** Object:  Table [dbo].[BOOK]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BOOK](
	[BookIdId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Auther] [nvarchar](50) NOT NULL,
	[Year] [nvarchar](4) NOT NULL,
	[Price] [decimal](6, 2) NOT NULL,
	[PublisherId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BookIdId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Carts]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Carts](
	[RecordId] [bigint] IDENTITY(1,1) NOT NULL,
	[CartId] [nvarchar](200) NULL,
	[ProductId] [bigint] NOT NULL,
	[Count] [int] NULL,
	[DateCreated] [datetime] NULL,
	[ProductDetailID] [bigint] NOT NULL,
	[isSoldOut] [bit] NOT NULL,
 CONSTRAINT [PK_Carts] PRIMARY KEY CLUSTERED 
(
	[RecordId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CategoryMaster]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoryMaster](
	[CategoryID] [bigint] IDENTITY(1,1) NOT NULL,
	[CategoryName_LL] [nvarchar](100) NULL,
	[CategoryName] [nvarchar](100) NULL,
	[ClientID] [bigint] NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Census_Country]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Census_Country](
	[Countrycode] [int] NULL,
	[Countryname] [nvarchar](50) NULL,
	[Langid] [numeric](1, 0) NULL,
	[Countryname_LL] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[census_district]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[census_district](
	[Districtcode] [varchar](5) NULL,
	[Districtname] [nvarchar](255) NULL,
	[Statecode] [int] NULL,
	[Langid] [numeric](1, 0) NULL,
	[Districtname_LL] [nvarchar](255) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Census_State]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Census_State](
	[Statecode] [int] NULL,
	[Statname] [nvarchar](50) NULL,
	[Langid] [numeric](1, 0) NULL,
	[Statename_LL] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Census_subdistrict]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Census_subdistrict](
	[Districtcode] [varchar](3) NULL,
	[Subdistrictcode] [varchar](5) NULL,
	[Subdistrictname] [nvarchar](255) NULL,
	[langid] [numeric](1, 0) NULL,
	[CUST_PK_CDAC] [int] IDENTITY(1,1) NOT NULL,
	[Subdistrictname_LL] [nvarchar](max) NULL,
 CONSTRAINT [CUST_PK_128297191] PRIMARY KEY CLUSTERED 
(
	[CUST_PK_CDAC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Census_subdistrict_BKP]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Census_subdistrict_BKP](
	[Districtcode] [varchar](3) NULL,
	[Subdistrictcode] [varchar](5) NULL,
	[Subdistrictname] [nvarchar](255) NULL,
	[langid] [numeric](1, 0) NULL,
	[Subdistrictname_LL] [nvarchar](255) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ClientMaster]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ClientMaster](
	[ClientID] [bigint] IDENTITY(1,1) NOT NULL,
	[ClientName_LL] [nvarchar](100) NULL,
	[ClientName] [nvarchar](100) NULL,
	[ClientLogo] [nvarchar](150) NULL,
	[ClientDescription_LL] [nvarchar](1000) NULL,
	[ClientDescription] [nvarchar](1000) NULL,
	[AddressLine1] [nvarchar](100) NULL,
	[AddressLine2] [nvarchar](100) NULL,
	[AddressLine3] [nvarchar](100) NULL,
	[ContactNo] [nvarchar](20) NULL,
	[EmailID] [varchar](50) NULL,
	[IsActive] [bit] NULL,
	[AddressLine1_LL] [nvarchar](100) NULL,
	[AddressLine2_LL] [nvarchar](100) NULL,
	[AddressLine3_LL] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ContollerRights]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ContollerRights](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Action] [varchar](50) NULL,
	[Controller] [varchar](50) NULL,
	[RoleID] [int] NULL,
	[Access] [bit] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CourierMaster]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CourierMaster](
	[CourierID] [bigint] IDENTITY(1,1) NOT NULL,
	[CourierName] [nvarchar](200) NULL,
	[Address] [nvarchar](300) NULL,
	[Phone] [nvarchar](15) NULL,
	[Mobile] [nvarchar](10) NULL,
	[CreatedBy] [bigint] NULL,
	[CreatedDate] [datetime] NULL,
	[BranchName] [nvarchar](100) NULL,
	[IsActive] [bit] NULL,
	[CreatedOn] [datetime] NULL,
	[UserPassword] [varchar](32) NULL,
	[IsOTP] [bit] NULL,
	[Email] [varchar](100) NULL,
	[UserID] [bigint] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerID] [uniqueidentifier] NOT NULL,
	[CustomerName] [nvarchar](100) NULL,
	[EmailID] [nvarchar](50) NULL,
	[Mobile] [nvarchar](50) NULL,
	[Password] [nvarchar](100) NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[Gender] [char](1) NULL,
	[ForgotPasswordToken] [uniqueidentifier] NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CustomerDemo]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerDemo](
	[CustomerID] [nvarchar](50) NOT NULL,
	[CustomerName] [nvarchar](100) NULL,
	[CompanyName] [nvarchar](50) NULL,
	[ContactName] [nvarchar](50) NULL,
	[ContactTitle] [nvarchar](100) NULL,
	[City] [nvarchar](50) NULL,
	[Country] [nvarchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DamageDetails]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DamageDetails](
	[DamageDetailsID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProductDetailID] [bigint] NULL,
	[DamagedQuantity] [int] NULL,
	[DamagedReason] [nvarchar](500) NULL,
	[CreatedBy] [bigint] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [bigint] NULL,
	[ModifiedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[DamageDetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[dept]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dept](
	[deptid] [int] NULL,
	[name] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[desg]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[desg](
	[desgid] [int] NULL,
	[name] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DiscountMaster]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiscountMaster](
	[DiscountID] [bigint] IDENTITY(1,1) NOT NULL,
	[DiscountType] [nvarchar](50) NULL,
	[Amount] [nvarchar](50) NULL,
	[Percentage] [nvarchar](50) NULL,
	[ProductID] [bigint] NULL,
	[CategoryID] [bigint] NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [bigint] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [bigint] NULL,
	[ModifiedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[DiscountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DispatchOrder]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DispatchOrder](
	[DispatchOrderID] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderId] [bigint] NULL,
	[OrderDetailID] [bigint] NULL,
	[DispatchType] [char](1) NULL,
	[DispatchDate] [datetime] NULL,
	[DispatchedBy] [nvarchar](100) NULL,
	[InvoiceNumber] [nvarchar](50) NULL,
	[IsDelivered] [bit] NULL,
	[DeliveryChannel] [char](1) NULL,
	[User] [nvarchar](100) NULL,
	[Courier] [bigint] NULL,
	[HasBeenShipped] [bit] NULL,
	[CreatedOn] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[emp]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[emp](
	[id] [int] NULL,
	[name] [varchar](100) NULL,
	[deptid] [int] NULL,
	[desgid] [int] NULL,
	[address] [varchar](100) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Enumeration]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Enumeration](
	[EnumerationID] [bigint] NOT NULL,
	[EnumerationName] [varchar](250) NULL,
	[IsActive] [bit] NULL,
	[EnumText] [varchar](250) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EnumerationValue]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EnumerationValue](
	[EnumerationValueID] [bigint] NOT NULL,
	[EnumerationID] [bigint] NULL,
	[EnumerationValueCode] [nvarchar](500) NULL,
	[EnumerationValue] [nvarchar](500) NULL,
	[IsDefault] [bit] NULL,
	[SortOrder] [int] NULL,
	[IsActive] [bit] NULL,
	[EnumerationValue_M] [nvarchar](500) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ImageDetails]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImageDetails](
	[ImageDetailID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProductID] [bigint] NULL,
	[ImagePath] [nvarchar](100) NULL,
	[IsActive] [bit] NULL,
	[Priority] [int] NULL,
	[CreatedBy] [bigint] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [bigint] NULL,
	[ModifiedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ImageDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Invoices]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoices](
	[InvoiceID] [bigint] IDENTITY(1,1) NOT NULL,
	[CustomerID] [bigint] NULL,
	[PaymentId] [bigint] NULL,
	[OrderID] [bigint] NULL,
	[InvoiceNumber] [nvarchar](50) NULL,
	[InvoiceIssueDate] [datetime] NULL,
	[Description] [text] NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Menus]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Menus](
	[MenuID] [bigint] IDENTITY(1,1) NOT NULL,
	[ParentID] [bigint] NULL,
	[PageUrl] [nvarchar](256) NULL,
	[Description] [varchar](50) NULL,
	[SortOrder] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedBy] [nvarchar](15) NULL,
	[CreatedDt] [datetimeoffset](7) NOT NULL,
	[UpdatedBy] [nvarchar](15) NULL,
	[UpdatedDt] [datetimeoffset](7) NULL,
	[Title] [varchar](100) NULL,
	[Action] [varchar](100) NULL,
	[Controller] [varchar](100) NULL,
 CONSTRAINT [PK_Menus] PRIMARY KEY CLUSTERED 
(
	[MenuID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MenusForRoles]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MenusForRoles](
	[RoleId] [int] NOT NULL,
	[MenuId] [bigint] NOT NULL,
	[ModifiedBy] [bigint] NULL,
	[ModifiedOn] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderCart]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderCart](
	[OrderCartID] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderDetailID] [bigint] NULL,
	[ProductDetailID] [bigint] NULL,
	[ProductName] [nvarchar](50) NULL,
	[ProductPrice] [decimal](10, 2) NULL,
	[Quantity] [int] NULL,
	[ShippingAmount] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderCartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderDelivery]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDelivery](
	[OrderDeliveryID] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderId] [bigint] NULL,
	[DispatchOrderID] [bigint] NULL,
	[IsDelivered] [bit] NULL,
	[DeliveryDate] [datetime] NULL,
	[CreatedBy] [bigint] NULL,
	[CreatedOn] [datetime] NULL,
	[Remark] [nvarchar](400) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[OrderDetailId] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderId] [bigint] NOT NULL,
	[ProductId] [bigint] NULL,
	[Quantity] [int] NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[ProductDetailID] [bigint] NOT NULL,
 CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED 
(
	[OrderDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orders]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderId] [bigint] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NULL,
	[PinCode] [nvarchar](100) NULL,
	[FullName] [nvarchar](100) NULL,
	[ShippingAddress] [nvarchar](100) NULL,
	[Landmark] [nvarchar](100) NULL,
	[City] [nvarchar](100) NULL,
	[States] [nvarchar](100) NULL,
	[Mobile] [nvarchar](100) NULL,
	[LandLine] [nvarchar](100) NULL,
	[Total] [decimal](18, 2) NULL,
	[OrderDate] [datetime] NULL,
	[PaymentTransactionId] [nvarchar](200) NULL,
	[HasBeenShipped] [bit] NOT NULL,
	[ClientID] [int] NOT NULL,
	[MolPortalCharges] [decimal](18, 2) NULL,
	[MolServiceCharges] [decimal](18, 2) NULL,
	[subTotal] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PaymentDetails]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PaymentDetails](
	[PaymentId] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderId] [bigint] NOT NULL,
	[PaymentTransactionID] [nvarchar](100) NULL,
	[PGTransactionID] [nvarchar](100) NULL,
	[TransactionDate] [datetime] NULL,
	[PayFlag] [char](1) NULL,
	[PayMode] [char](1) NULL,
	[Createddate] [datetime] NULL,
 CONSTRAINT [PK_PaymentDetails] PRIMARY KEY CLUSTERED 
(
	[PaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PaymentMode]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentMode](
	[PaymentModeID] [int] IDENTITY(1,1) NOT NULL,
	[PaymentType_LL] [nvarchar](30) NULL,
	[PaymentType] [nvarchar](30) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentModeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PaymentOfShooting]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PaymentOfShooting](
	[PaymentId] [bigint] IDENTITY(1,1) NOT NULL,
	[TxnUniqueNo] [bigint] NULL,
	[PaymentTransactionID] [nvarchar](200) NULL,
	[PGTransactionID] [nvarchar](200) NULL,
	[PayFlag] [char](1) NULL,
	[PayMode] [char](1) NULL,
	[PayeeName] [nvarchar](1000) NULL,
	[ApplicantName] [nvarchar](1000) NULL,
	[PaymentDate] [datetime] NULL,
	[Amount] [decimal](18, 2) NULL,
	[PortalFee] [decimal](18, 2) NULL,
	[TotalAmount] [decimal](18, 2) NULL,
	[AmountInWords] [nvarchar](1000) NULL,
	[Createddate] [datetime] NULL,
	[applicantid] [bigint] NULL,
	[BankTransactionRefNo] [nvarchar](500) NULL,
	[email] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PINCodeMaster]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PINCodeMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PINCode] [bigint] NOT NULL,
	[Area] [nvarchar](100) NOT NULL,
	[DistrictCode] [bigint] NOT NULL,
	[Availability] [bit] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductDetails]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductDetails](
	[ProductDetailID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProductID] [bigint] NOT NULL,
	[Size] [nvarchar](100) NULL,
	[Unit] [nvarchar](100) NULL,
	[Quantity] [int] NULL,
	[CreatedBy] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [int] NULL,
	[ModifiedDate] [datetime] NULL,
 CONSTRAINT [PK_ProductDetails] PRIMARY KEY CLUSTERED 
(
	[ProductDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductDetails_07102014]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductDetails_07102014](
	[ProductDetailID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProductID] [bigint] NULL,
	[ProductIdentifierName_LL] [nvarchar](100) NULL,
	[ProductIdentifierName] [nvarchar](100) NULL,
	[ProductDescription_LL] [nvarchar](1000) NULL,
	[ProductDescription] [nvarchar](1000) NULL,
	[ProductSize_LL] [nvarchar](25) NULL,
	[ProductSize] [nvarchar](25) NULL,
	[ProductWeight_LL] [nvarchar](10) NULL,
	[ProductWeight] [nvarchar](10) NULL,
	[Author_LL] [nvarchar](50) NULL,
	[Author] [nvarchar](50) NULL,
	[Publisher_LL] [nvarchar](50) NULL,
	[Publisher] [nvarchar](50) NULL,
	[Language_LL] [nvarchar](50) NULL,
	[Language] [nvarchar](50) NULL,
	[Pages] [int] NULL,
	[Price] [decimal](10, 2) NULL,
	[Thumbnail] [nvarchar](150) NULL,
	[CreatedBy] [bigint] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [bigint] NULL,
	[ModifiedDate] [datetime] NULL,
	[SupplierID] [bigint] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductMaster]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductMaster](
	[ProductID] [bigint] IDENTITY(1,1) NOT NULL,
	[SubCategoryID] [bigint] NULL,
	[ProductName_LL] [nvarchar](100) NULL,
	[ProductName] [nvarchar](100) NULL,
	[ClientID] [bigint] NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [bigint] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [bigint] NULL,
	[ModifiedDate] [datetime] NULL,
	[ProductDescription_LL] [nvarchar](2000) NULL,
	[ProductDescription] [nvarchar](2000) NULL,
	[ProductSize_LL] [nvarchar](50) NULL,
	[ProductSize] [nvarchar](50) NULL,
	[ProductWeight_LL] [nvarchar](20) NULL,
	[ProductWeight] [nvarchar](20) NULL,
	[Author_LL] [nvarchar](100) NULL,
	[Author] [nvarchar](100) NULL,
	[Publisher_LL] [nvarchar](100) NULL,
	[Publisher] [nvarchar](100) NULL,
	[Language_LL] [nvarchar](100) NULL,
	[Language] [nvarchar](100) NULL,
	[Pages] [int] NULL,
	[Price] [decimal](18, 2) NULL,
	[Thumbnail] [nvarchar](300) NULL,
	[SupplierID] [int] NULL,
	[BasePrice] [decimal](18, 2) NULL,
	[MahaonlineCharges] [decimal](18, 2) NULL,
	[ShippingCharges] [decimal](18, 2) NULL,
	[VAT] [int] NULL,
	[ServiceTax] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Publisher]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publisher](
	[PublisherId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Year] [nvarchar](4) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PublisherId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[QuickAdv]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuickAdv](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [bigint] NULL,
	[Priority] [int] NULL,
	[ImagePath] [nvarchar](400) NULL,
	[CreatedBy] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RoleMaster]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleMaster](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](50) NULL,
	[ClientID] [bigint] NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Sheet2$]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sheet2$](
	[Area] [nvarchar](255) NULL,
	[DistrictCode] [float] NULL,
	[Availability] [float] NULL,
	[code] [float] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ShootApplication_PaymentDetails]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShootApplication_PaymentDetails](
	[PaymentId] [bigint] IDENTITY(1,1) NOT NULL,
	[ReceiptID] [bigint] NOT NULL,
	[PaymentTransactionID] [nvarchar](100) NULL,
	[PGTransactionID] [nvarchar](100) NULL,
	[TransactionDate] [datetime] NULL,
	[PayFlag] [char](1) NULL,
	[PayMode] [char](1) NULL,
	[Createddate] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ShootingIdentityDocs]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShootingIdentityDocs](
	[ApplicantId] [bigint] NULL,
	[ApplicantName] [nvarchar](1000) NULL,
	[ApplicantDesignation] [nvarchar](1000) NULL,
	[clientname] [nvarchar](1000) NULL,
	[ImagePath] [nvarchar](1000) NULL,
	[CreatedDate] [datetime] NULL,
	[ID] [bigint] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ShootingPermission]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShootingPermission](
	[ReceiptID] [bigint] IDENTITY(1893,1) NOT NULL,
	[ApplicationDate] [datetime] NULL,
	[ApplicantName] [nvarchar](500) NULL,
	[ApplicantAddress1] [nvarchar](500) NULL,
	[ApplicantAddress2] [nvarchar](500) NULL,
	[ApplicantDesignation] [nvarchar](200) NULL,
	[isvalid] [bit] NULL,
	[IsNatural] [bit] NULL,
	[IsAnimal] [bit] NULL,
	[ClientName] [nvarchar](500) NULL,
	[ClientName_ll] [nvarchar](500) NULL,
	[ClientAddress1] [nvarchar](500) NULL,
	[ClientAddress1_ll] [nvarchar](500) NULL,
	[ClientAddress2] [nvarchar](500) NULL,
	[ClientAddress2_ll] [nvarchar](500) NULL,
	[ShootDate] [datetime] NULL,
	[Days] [int] NULL,
	[FilmName] [nvarchar](500) NULL,
	[FilmName_ll] [nvarchar](500) NULL,
	[FilmPlace] [nvarchar](500) NULL,
	[FilmPlace_ll] [nvarchar](500) NULL,
	[ShootDetails] [nvarchar](1000) NULL,
	[RejectionReason] [nvarchar](500) NULL,
	[Adults] [int] NULL,
	[Childs] [int] NULL,
	[TwoWheelers] [int] NULL,
	[FourWheelers] [int] NULL,
	[Bus_Heavy_vehicls] [int] NULL,
	[LangID] [int] NULL,
	[PrintOption] [varchar](50) NULL,
	[isapproved] [bit] NULL,
	[isrejected] [varchar](100) NULL,
	[shootingAmount] [decimal](18, 2) NULL,
	[DepositAmount] [decimal](18, 2) NULL,
	[TotalAmount] [decimal](18, 2) NULL,
	[email] [nvarchar](200) NULL,
	[MobileNo] [nvarchar](10) NULL,
	[ShootDone] [bit] NULL,
	[molcharges] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[ReceiptID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StatusMaster]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusMaster](
	[StatusID] [int] IDENTITY(1,1) NOT NULL,
	[StatusName_LL] [nvarchar](50) NULL,
	[StatusName] [nvarchar](50) NULL,
	[StatusCategory] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StockMaster]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockMaster](
	[StockID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProductID] [bigint] NULL,
	[Quantity] [int] NULL,
	[AvailableQuantity] [int] NULL,
	[ClientID] [bigint] NULL,
	[CreatedBy] [bigint] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [bigint] NULL,
	[ModifiedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[StockID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SubCategory]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubCategory](
	[SubCategoryID] [bigint] IDENTITY(1,1) NOT NULL,
	[CategoryID] [bigint] NOT NULL,
	[SubCategoryName_LL] [nvarchar](100) NULL,
	[SubCategoryName] [nvarchar](100) NULL,
	[ClientID] [bigint] NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [bigint] NULL,
	[ModifiedBy] [bigint] NULL,
	[ModifiedDate] [datetime] NULL,
	[createddate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SubCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SupplierMaster]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SupplierMaster](
	[SupplierID] [bigint] IDENTITY(1,1) NOT NULL,
	[SupplierName_LL] [nvarchar](100) NULL,
	[SupplierName] [nvarchar](100) NULL,
	[Address] [nvarchar](100) NULL,
	[Contact] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [bigint] NULL,
	[CreatedDate] [datetime] NULL,
	[LangID] [numeric](1, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Suppliers]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers](
	[SupplierID] [bigint] IDENTITY(1,1) NOT NULL,
	[CompanyName] [nvarchar](250) NOT NULL,
	[ContactName] [nvarchar](250) NOT NULL,
	[Address] [nvarchar](350) NULL,
	[City] [nvarchar](100) NULL,
	[District] [nvarchar](10) NULL,
	[State] [int] NULL,
	[Pincode] [nvarchar](10) NULL,
	[Phone] [nvarchar](15) NULL,
	[Mobile] [nvarchar](10) NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [bigint] NULL,
	[CreatedOn] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[t]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[t](
	[UserID] [bigint] NOT NULL,
	[RoleID] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TaxDetail]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaxDetail](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TaxTypeID] [bigint] NOT NULL,
	[AmountLimit] [nvarchar](50) NOT NULL,
	[TaxRate] [decimal](4, 2) NULL,
	[TaxDescription] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TaxMaster]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaxMaster](
	[TaxTypeID] [bigint] NOT NULL,
	[TaxType] [nvarchar](50) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TransactionLog]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TransactionLog](
	[TransactionID] [uniqueidentifier] NOT NULL,
	[TransactionTypeID] [int] NULL,
	[TransactionDate] [date] NULL,
	[IPAddress] [varchar](30) NULL,
	[PaymentDetailID] [bigint] NULL,
	[ClientID] [bigint] NULL,
	[CreatedBy] [bigint] NULL,
	[CreatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TransactionType]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionType](
	[TransactionTypeID] [int] IDENTITY(1,1) NOT NULL,
	[TransactionType] [nvarchar](30) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[TransactionTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TreeDemoCategory]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TreeDemoCategory](
	[CategoryID] [bigint] IDENTITY(1,1) NOT NULL,
	[ParentID] [bigint] NULL,
	[CategoryName] [nvarchar](100) NULL,
	[CategoryName_LL] [nvarchar](100) NULL,
	[ClientID] [bigint] NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [bigint] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [bigint] NULL,
	[ModifiedDate] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserMaster]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserMaster](
	[UserID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NULL,
	[eMail] [nvarchar](50) NULL,
	[UserPassword] [varchar](100) NULL,
	[RoleID] [int] NULL,
	[ClientID] [bigint] NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [bigint] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [bigint] NULL,
	[ModifiedDate] [datetime] NULL,
	[Full_Name] [nvarchar](50) NULL,
	[Display_Name] [nvarchar](50) NULL,
	[Mobile_No] [nvarchar](13) NULL,
	[AddressLine1] [nvarchar](300) NULL,
	[AddressLine2] [nvarchar](300) NULL,
	[census_district] [nvarchar](50) NULL,
	[Census_subdistrict] [nvarchar](50) NULL,
	[PinCode] [nvarchar](6) NULL,
	[ForgotPasswordToken] [uniqueidentifier] NULL,
	[RandomNo] [bigint] NULL,
	[currenttime] [datetime] NULL,
	[IsLocked] [bit] NULL,
	[IsOTP] [bit] NOT NULL,
	[AddressLine3] [nvarchar](300) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserMaster_BKP]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserMaster_BKP](
	[UserID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NULL,
	[eMail] [nvarchar](50) NULL,
	[UserPassword] [nvarchar](50) NULL,
	[RoleID] [int] NULL,
	[ClientID] [bigint] NULL,
	[IsActive] [bit] NULL,
	[CreatedBy] [bigint] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [bigint] NULL,
	[ModifiedDate] [datetime] NULL,
	[Full_Name] [nvarchar](50) NULL,
	[Display_Name] [nvarchar](50) NULL,
	[AddressLine1] [nvarchar](300) NULL,
	[AddressLine2] [nvarchar](300) NULL,
	[Mobile_No] [nvarchar](13) NULL,
	[census_district] [nvarchar](50) NULL,
	[Census_subdistrict] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[viewemp]    Script Date: 18-12-2014 15:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEw [dbo].[viewemp]
AS
	 SELECT		id,E.name EmpName,d.deptid,d.name DeptName,dd.desgid,dd.name  DesiName
	 from		emp E 
	 inner Join dept d on 
				E.deptid = d.deptid
	inner Join desg dd on 
				E.desgid = dd.desgid
GO
ALTER TABLE [dbo].[Carts] ADD  DEFAULT ((0)) FOR [ProductDetailID]
GO
ALTER TABLE [dbo].[Carts] ADD  DEFAULT ((0)) FOR [isSoldOut]
GO
ALTER TABLE [dbo].[CategoryMaster] ADD  DEFAULT (' ') FOR [CategoryName_LL]
GO
ALTER TABLE [dbo].[Menus] ADD  CONSTRAINT [DF__Menus__ParentID__61A66D40]  DEFAULT ((0)) FOR [ParentID]
GO
ALTER TABLE [dbo].[Menus] ADD  CONSTRAINT [DF__Menus__IsActive__629A9179]  DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Menus] ADD  CONSTRAINT [DF_Menus_CreatedDt]  DEFAULT (getdate()) FOR [CreatedDt]
GO
ALTER TABLE [dbo].[OrderDetail] ADD  DEFAULT ((0)) FOR [ProductDetailID]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((0)) FOR [HasBeenShipped]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((1)) FOR [ClientID]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((0)) FOR [MolPortalCharges]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((0)) FOR [MolServiceCharges]
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT ((0)) FOR [subTotal]
GO
ALTER TABLE [dbo].[SubCategory] ADD  DEFAULT (' ') FOR [SubCategoryName_LL]
GO
ALTER TABLE [dbo].[SubCategory] ADD  DEFAULT (getdate()) FOR [createddate]
GO
ALTER TABLE [dbo].[TransactionLog] ADD  DEFAULT (newid()) FOR [TransactionID]
GO
ALTER TABLE [dbo].[UserMaster] ADD  DEFAULT ((0)) FOR [IsOTP]
GO
USE [master]
GO
ALTER DATABASE [SGNP_Ecommerce] SET  READ_WRITE 
GO
