USE [master]
GO
/****** Object:  Database [AdisyonTakip]    Script Date: 29.01.2024 07:11:41 ******/
CREATE DATABASE [AdisyonTakip]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AdisyonTakip', FILENAME = N'C:\SQL_DBs\SQL2017\DATA\AdisyonTakip.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AdisyonTakip_log', FILENAME = N'C:\SQL_DBs\SQL2017\DATA\AdisyonTakip_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [AdisyonTakip] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AdisyonTakip].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AdisyonTakip] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AdisyonTakip] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AdisyonTakip] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AdisyonTakip] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AdisyonTakip] SET ARITHABORT OFF 
GO
ALTER DATABASE [AdisyonTakip] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AdisyonTakip] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AdisyonTakip] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AdisyonTakip] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AdisyonTakip] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AdisyonTakip] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AdisyonTakip] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AdisyonTakip] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AdisyonTakip] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AdisyonTakip] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AdisyonTakip] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AdisyonTakip] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AdisyonTakip] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AdisyonTakip] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AdisyonTakip] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AdisyonTakip] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AdisyonTakip] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AdisyonTakip] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [AdisyonTakip] SET  MULTI_USER 
GO
ALTER DATABASE [AdisyonTakip] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AdisyonTakip] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AdisyonTakip] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AdisyonTakip] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AdisyonTakip] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [AdisyonTakip] SET QUERY_STORE = OFF
GO
USE [AdisyonTakip]
GO
/****** Object:  User [MUSTAFAB\musta]    Script Date: 29.01.2024 07:11:41 ******/
CREATE USER [MUSTAFAB\musta] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_stokAdediGetir]    Script Date: 29.01.2024 07:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE	 FUNCTION [dbo].[fn_stokAdediGetir]
(
	@stok_kod as  nvarchar(50)
)
RETURNS float
AS
BEGIN

	-- Declare the return variable here
	DECLARE @girisMiktar as float
	DECLARE @cikisMiktar as float
	DECLARE @sonucMiktar as float

	-- Add the T-SQL statements to compute the return value here
	set @girisMiktar = (select isnull(sum(sth_adet),0) from Stok_Hareketleri where sth_kod = @stok_kod and sth_tip='Giriş')
	set @cikisMiktar = (select isnull(sum(sth_adet),0) from Stok_Hareketleri where sth_kod = @stok_kod and sth_tip='Çıkış')
	set @sonucMiktar = (select @girisMiktar - @cikisMiktar as Miktar);
	
	-- Return the result of the function
	RETURN @sonucMiktar

END
GO
/****** Object:  UserDefinedFunction [dbo].[fn_stokSatisFiyatGetir]    Script Date: 29.01.2024 07:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_stokSatisFiyatGetir]
(
	@stok_kod as  nvarchar(50)
)
RETURNS float
AS
BEGIN
	-- Declare the return variable here
	DECLARE @fiyat as float

	-- Add the T-SQL statements to compute the return value here
	set @fiyat = (	select sto_satis_fiyat from Stok_Tanimlari where sto_kodu = @stok_kod)

	-- Return the result of the function
	RETURN @fiyat

END
GO
/****** Object:  Table [dbo].[Alinan_Hesaplar]    Script Date: 29.01.2024 07:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alinan_Hesaplar](
	[hsp_RECno] [int] IDENTITY(1,1) NOT NULL,
	[hsp_adisyon_sirano] [int] NULL,
	[hsp_adisyon_tarih] [datetime] NULL,
	[hsp_toplam_tutar] [float] NULL,
	[hsp_adisyonu_kapatan] [int] NULL,
	[hsp_kayit_tarih] [datetime] NULL,
 CONSTRAINT [PK_Alinan_Hesaplar] PRIMARY KEY CLUSTERED 
(
	[hsp_RECno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kullanici_Tanimlari]    Script Date: 29.01.2024 07:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kullanici_Tanimlari](
	[kul_RECno] [int] IDENTITY(1,1) NOT NULL,
	[kul_kod] [int] NOT NULL,
	[kul_adi] [nvarchar](50) NOT NULL,
	[kul_psw] [nvarchar](50) NOT NULL,
	[kul_kayit_tarihi] [datetime] NULL,
	[kul_kaydeden] [int] NULL,
	[kul_guncelleme_tarih] [datetime] NULL,
	[kul_guncelleyen] [int] NULL,
 CONSTRAINT [PK_Kullanici_Tanimlari] PRIMARY KEY CLUSTERED 
(
	[kul_RECno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_AlinanHesaplar]    Script Date: 29.01.2024 07:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fn_AlinanHesaplar]
(	
	@param as int
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT [hsp_RECno] as KayıtNo
      ,[hsp_adisyon_sirano] as [Sıra No]
      ,[hsp_adisyon_tarih] as [Tarih]
      ,[hsp_toplam_tutar] as  [Toplam Tutar ]
      ,[hsp_adisyonu_kapatan] as [Hesap Alan Kod]
	  ,(select kul_adi from Kullanici_Tanimlari where kul_kod = [hsp_adisyonu_kapatan]) as [Hesap Alan]
      
	  
  FROM [dbo].[Alinan_Hesaplar]

)
GO
/****** Object:  Table [dbo].[Stok_Tanimlari]    Script Date: 29.01.2024 07:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stok_Tanimlari](
	[sto_RECno] [int] IDENTITY(1,1) NOT NULL,
	[sto_kodu] [nvarchar](50) NULL,
	[sto_adi] [nvarchar](50) NULL,
	[sto_birim] [nvarchar](50) NULL,
	[sto_satis_fiyat] [float] NULL,
	[sto_alis_fiyat] [float] NULL,
	[sto_aktif] [bit] NULL,
	[sto_kayit_tarih] [datetime] NULL,
	[sto_kaydeden] [int] NULL,
	[sto_guncelleme_tarih] [datetime] NULL,
	[sto_guncelleyen] [int] NULL,
	[sto_gorsel] [nvarchar](max) NULL,
	[sto_max] [float] NULL,
	[sto_min] [float] NULL,
	[sto_eksi_olabilir] [bit] NULL,
 CONSTRAINT [PK_Stok_Tanimlari] PRIMARY KEY CLUSTERED 
(
	[sto_RECno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_StokAdetleri]    Script Date: 29.01.2024 07:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[fn_StokAdetleri]
(	
	@param as int
)
RETURNS TABLE 
AS
RETURN 
(
	      
	SELECT [sto_RECno] as KayıtNo 
      ,[sto_kodu] as [Kodu]
      ,[sto_adi] as Adı
	  ,dbo.fn_stokAdediGetir(sto_kodu) as [Mevcut Adet] 
	   ,isnull(sto_max,0) as [Max Stok]
	  ,isnull(sto_min,0) as [Min Stok]
      ,[sto_birim] as Birim
      ,[sto_satis_fiyat] as [Satış Fiyat]
      ,[sto_alis_fiyat] as [Alış Fiyat]
      ,[sto_aktif] as Durum
	 
	  ,isnull(sto_eksi_olabilir,0) as [Stok Eksi Olabilir Mi?]
	  , case when dbo.fn_stokAdediGetir(sto_kodu) < sto_min then 'Uyarı!' else '' end as Durumu

  FROM [dbo].[Stok_Tanimlari]  
 



)
GO
/****** Object:  Table [dbo].[Masa_Adisyonlari]    Script Date: 29.01.2024 07:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Masa_Adisyonlari](
	[adi_RECno] [int] IDENTITY(1,1) NOT NULL,
	[adi_adisyon_sirano] [int] NULL,
	[adi_masa_kod] [nvarchar](50) NOT NULL,
	[adi_garson_kod] [int] NULL,
	[adi_urun_kod] [nvarchar](50) NULL,
	[adi_urun_adet] [float] NULL,
	[adi_kayit_tarih] [datetime] NULL,
	[adi_kaydeden] [int] NULL,
	[adi_hesap_alindi] [bit] NULL,
	[adi_hesap_alan] [int] NULL,
 CONSTRAINT [PK_Masa_Adisyonlari] PRIMARY KEY CLUSTERED 
(
	[adi_RECno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_MasaAdisyonToplam]    Script Date: 29.01.2024 07:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fn_MasaAdisyonToplam]
(
	@masa_kod as nvarchar(50)
)
RETURNS TABLE 
AS
RETURN 
(
	--select 
	--	  [Ürün]
	--	, sum(adet) as adet
	--	, sum(satis) as satis_tutar
	--	 from 
	--	(
	--	select 
	--	   (select sto_adi from Stok_Tanimlari where sto_kodu = [adi_urun_kod] ) as [Ürün]
	--	   , adi_urun_adet as adet
	--	  ,(select sto_satis_fiyat from Stok_Tanimlari where sto_kodu = adi_urun_kod) as satis_fiyat  
	--	  ,(select sto_satis_fiyat from Stok_Tanimlari where sto_kodu = adi_urun_kod) * adi_urun_adet as satis
	--	 from Masa_Adisyonlari   
	--	 where adi_masa_kod = @masa_kod
	--	 ) tablo
	--	 group by [Ürün]



	select 
   count(*) as siparis_adedi
 , isnull( sum(adet),0) as siparis_edilen_urun_adet
 , isnull( sum(satis),0) as satis_tutar
 from 
(
select   
    adi_urun_adet as adet
  ,(select sto_satis_fiyat from Stok_Tanimlari where sto_kodu = adi_urun_kod) as satis_fiyat  
  ,(select sto_satis_fiyat from Stok_Tanimlari where sto_kodu = adi_urun_kod) * adi_urun_adet as satis
 from Masa_Adisyonlari   
 where adi_masa_kod = @masa_kod and adi_hesap_alindi = 0
 )  tablo


)


-- SELECT * from fn_MasaAdisyonToplam('M4')
GO
/****** Object:  UserDefinedFunction [dbo].[fn_MasaButonOzet]    Script Date: 29.01.2024 07:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE	 FUNCTION [dbo].[fn_MasaButonOzet]
(	
	@masa_kod as nvarchar(50)
)
RETURNS TABLE 
AS
RETURN 
(
select
 isnull((select sum(adi_urun_adet)  from Masa_Adisyonlari where adi_masa_kod = @masa_kod and  adi_hesap_alindi = 0 ) ,0)as siparis_adet
,isnull((select sum(adi_urun_adet * dbo.fn_stokSatisFiyatGetir(adi_urun_kod)) from Masa_Adisyonlari where adi_masa_kod = @masa_kod and adi_hesap_alindi = 0),0) as toplam_tutar
)
GO
/****** Object:  Table [dbo].[Bolum_Tanimlari]    Script Date: 29.01.2024 07:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bolum_Tanimlari](
	[bol_RECno] [int] IDENTITY(1,1) NOT NULL,
	[bol_kodu] [nvarchar](50) NOT NULL,
	[bol_adi] [nvarchar](50) NOT NULL,
	[bol_masa_limiti] [int] NOT NULL,
	[bol_aktif] [bit] NOT NULL,
	[bol_rezerve] [bit] NOT NULL,
	[bol_kayit_tarih] [datetime] NULL,
	[bol_kaydeden] [int] NULL,
	[bol_guncelleme_tarih] [datetime] NULL,
	[bol_guncelleyen] [int] NULL,
 CONSTRAINT [PK_Bolum_Tanimlari] PRIMARY KEY CLUSTERED 
(
	[bol_RECno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Masa_Tanimlari]    Script Date: 29.01.2024 07:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Masa_Tanimlari](
	[masa_RECno] [int] IDENTITY(1,1) NOT NULL,
	[masa_kodu] [nvarchar](50) NOT NULL,
	[masa_adi] [nvarchar](50) NOT NULL,
	[masa_bolum_kodu] [nvarchar](50) NOT NULL,
	[masa_rezerve] [bit] NOT NULL,
	[masa_aktif] [bit] NOT NULL,
	[masa_kayit_tarih] [datetime] NULL,
	[masa_kaydeden] [int] NULL,
	[masa_guncelleme_tarih] [datetime] NULL,
	[masa_guncelleyen] [int] NULL,
 CONSTRAINT [PK_Masa_Tanimlari] PRIMARY KEY CLUSTERED 
(
	[masa_RECno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stok_Hareketleri]    Script Date: 29.01.2024 07:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stok_Hareketleri](
	[sth_RECno] [int] IDENTITY(1,1) NOT NULL,
	[sth_kod] [nvarchar](50) NULL,
	[sth_tip] [nvarchar](50) NULL,
	[sth_adet] [float] NULL,
	[sth_fiyat] [float] NULL,
	[sth_kaydeden] [int] NULL,
	[sth_kayit_tarih] [datetime] NULL,
	[sth_guncelleyen] [int] NULL,
	[sth_guncelleme_tarih] [datetime] NULL,
 CONSTRAINT [PK_Stok_Hareketleri] PRIMARY KEY CLUSTERED 
(
	[sth_RECno] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Stok_Tanimlari_Silinenler]    Script Date: 29.01.2024 07:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Stok_Tanimlari_Silinenler](
	[sto_RECno] [int] IDENTITY(1,1) NOT NULL,
	[sto_kodu] [nvarchar](50) NULL,
	[sto_adi] [nvarchar](50) NULL,
	[sto_birim] [nvarchar](50) NULL,
	[sto_satis_fiyat] [float] NULL,
	[sto_alis_fiyat] [float] NULL,
	[sto_aktif] [bit] NULL,
	[sto_kayit_tarih] [datetime] NULL,
	[sto_kaydeden] [int] NULL,
	[sto_guncelleme_tarih] [datetime] NULL,
	[sto_guncelleyen] [int] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Alinan_Hesaplar] ON 

INSERT [dbo].[Alinan_Hesaplar] ([hsp_RECno], [hsp_adisyon_sirano], [hsp_adisyon_tarih], [hsp_toplam_tutar], [hsp_adisyonu_kapatan], [hsp_kayit_tarih]) VALUES (1, 10, CAST(N'2023-06-03T01:28:26.820' AS DateTime), 0, 0, NULL)
INSERT [dbo].[Alinan_Hesaplar] ([hsp_RECno], [hsp_adisyon_sirano], [hsp_adisyon_tarih], [hsp_toplam_tutar], [hsp_adisyonu_kapatan], [hsp_kayit_tarih]) VALUES (2, 11, CAST(N'2023-06-03T01:29:56.083' AS DateTime), 0, 0, NULL)
INSERT [dbo].[Alinan_Hesaplar] ([hsp_RECno], [hsp_adisyon_sirano], [hsp_adisyon_tarih], [hsp_toplam_tutar], [hsp_adisyonu_kapatan], [hsp_kayit_tarih]) VALUES (3, 12, CAST(N'2023-06-03T01:40:19.977' AS DateTime), 580, 0, CAST(N'2023-06-03T01:40:19.977' AS DateTime))
INSERT [dbo].[Alinan_Hesaplar] ([hsp_RECno], [hsp_adisyon_sirano], [hsp_adisyon_tarih], [hsp_toplam_tutar], [hsp_adisyonu_kapatan], [hsp_kayit_tarih]) VALUES (4, 13, CAST(N'2024-01-27T03:22:48.230' AS DateTime), 155, 0, CAST(N'2024-01-27T03:22:48.230' AS DateTime))
INSERT [dbo].[Alinan_Hesaplar] ([hsp_RECno], [hsp_adisyon_sirano], [hsp_adisyon_tarih], [hsp_toplam_tutar], [hsp_adisyonu_kapatan], [hsp_kayit_tarih]) VALUES (5, 14, CAST(N'2024-01-27T03:23:29.077' AS DateTime), 290, 0, CAST(N'2024-01-27T03:23:29.077' AS DateTime))
INSERT [dbo].[Alinan_Hesaplar] ([hsp_RECno], [hsp_adisyon_sirano], [hsp_adisyon_tarih], [hsp_toplam_tutar], [hsp_adisyonu_kapatan], [hsp_kayit_tarih]) VALUES (6, 15, CAST(N'2024-01-27T04:20:12.650' AS DateTime), 135, 0, CAST(N'2024-01-27T04:20:12.650' AS DateTime))
INSERT [dbo].[Alinan_Hesaplar] ([hsp_RECno], [hsp_adisyon_sirano], [hsp_adisyon_tarih], [hsp_toplam_tutar], [hsp_adisyonu_kapatan], [hsp_kayit_tarih]) VALUES (7, 16, CAST(N'2024-01-27T04:20:18.027' AS DateTime), 0, 0, CAST(N'2024-01-27T04:20:18.027' AS DateTime))
INSERT [dbo].[Alinan_Hesaplar] ([hsp_RECno], [hsp_adisyon_sirano], [hsp_adisyon_tarih], [hsp_toplam_tutar], [hsp_adisyonu_kapatan], [hsp_kayit_tarih]) VALUES (8, 16, CAST(N'2024-01-27T04:21:30.550' AS DateTime), 130, 0, CAST(N'2024-01-27T04:21:30.550' AS DateTime))
INSERT [dbo].[Alinan_Hesaplar] ([hsp_RECno], [hsp_adisyon_sirano], [hsp_adisyon_tarih], [hsp_toplam_tutar], [hsp_adisyonu_kapatan], [hsp_kayit_tarih]) VALUES (9, 17, CAST(N'2024-01-29T05:00:11.577' AS DateTime), 60, 0, CAST(N'2024-01-29T05:00:11.577' AS DateTime))
INSERT [dbo].[Alinan_Hesaplar] ([hsp_RECno], [hsp_adisyon_sirano], [hsp_adisyon_tarih], [hsp_toplam_tutar], [hsp_adisyonu_kapatan], [hsp_kayit_tarih]) VALUES (10, 18, CAST(N'2024-01-29T05:00:40.657' AS DateTime), 335, 0, CAST(N'2024-01-29T05:00:40.657' AS DateTime))
INSERT [dbo].[Alinan_Hesaplar] ([hsp_RECno], [hsp_adisyon_sirano], [hsp_adisyon_tarih], [hsp_toplam_tutar], [hsp_adisyonu_kapatan], [hsp_kayit_tarih]) VALUES (11, 19, CAST(N'2024-01-29T06:58:34.983' AS DateTime), 125, 0, CAST(N'2024-01-29T06:58:34.983' AS DateTime))
SET IDENTITY_INSERT [dbo].[Alinan_Hesaplar] OFF
GO
SET IDENTITY_INSERT [dbo].[Bolum_Tanimlari] ON 

INSERT [dbo].[Bolum_Tanimlari] ([bol_RECno], [bol_kodu], [bol_adi], [bol_masa_limiti], [bol_aktif], [bol_rezerve], [bol_kayit_tarih], [bol_kaydeden], [bol_guncelleme_tarih], [bol_guncelleyen]) VALUES (18, N'G1', N'Giriş Alanı', 2, 1, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Bolum_Tanimlari] ([bol_RECno], [bol_kodu], [bol_adi], [bol_masa_limiti], [bol_aktif], [bol_rezerve], [bol_kayit_tarih], [bol_kaydeden], [bol_guncelleme_tarih], [bol_guncelleyen]) VALUES (20, N'A1', N'Ana Bölüm', 5, 1, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Bolum_Tanimlari] ([bol_RECno], [bol_kodu], [bol_adi], [bol_masa_limiti], [bol_aktif], [bol_rezerve], [bol_kayit_tarih], [bol_kaydeden], [bol_guncelleme_tarih], [bol_guncelleyen]) VALUES (24, N'B1', N'Balkon ', 10, 1, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Bolum_Tanimlari] ([bol_RECno], [bol_kodu], [bol_adi], [bol_masa_limiti], [bol_aktif], [bol_rezerve], [bol_kayit_tarih], [bol_kaydeden], [bol_guncelleme_tarih], [bol_guncelleyen]) VALUES (25, N'B2', N'Balkon 2', 10, 1, 0, NULL, NULL, CAST(N'2023-05-24T00:28:10.870' AS DateTime), 0)
INSERT [dbo].[Bolum_Tanimlari] ([bol_RECno], [bol_kodu], [bol_adi], [bol_masa_limiti], [bol_aktif], [bol_rezerve], [bol_kayit_tarih], [bol_kaydeden], [bol_guncelleme_tarih], [bol_guncelleyen]) VALUES (26, N'S1', N'Sol Alan', 5, 1, 0, CAST(N'2023-05-21T00:38:06.913' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Bolum_Tanimlari] ([bol_RECno], [bol_kodu], [bol_adi], [bol_masa_limiti], [bol_aktif], [bol_rezerve], [bol_kayit_tarih], [bol_kaydeden], [bol_guncelleme_tarih], [bol_guncelleyen]) VALUES (27, N'S2', N'Sağ Alan', 5, 1, 0, CAST(N'2023-05-21T00:43:21.420' AS DateTime), 0, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Bolum_Tanimlari] OFF
GO
SET IDENTITY_INSERT [dbo].[Kullanici_Tanimlari] ON 

INSERT [dbo].[Kullanici_Tanimlari] ([kul_RECno], [kul_kod], [kul_adi], [kul_psw], [kul_kayit_tarihi], [kul_kaydeden], [kul_guncelleme_tarih], [kul_guncelleyen]) VALUES (1, 0, N'Mustafa BÜKÜMEZ', N'0', NULL, NULL, NULL, NULL)
INSERT [dbo].[Kullanici_Tanimlari] ([kul_RECno], [kul_kod], [kul_adi], [kul_psw], [kul_kayit_tarihi], [kul_kaydeden], [kul_guncelleme_tarih], [kul_guncelleyen]) VALUES (2, 1, N'Ahmet', N'1', NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Kullanici_Tanimlari] OFF
GO
SET IDENTITY_INSERT [dbo].[Masa_Adisyonlari] ON 

INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (1, 7, N'M4', 0, N'1', 5, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (2, 7, N'M4', 0, N'6', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (3, 7, N'M4', 0, N'3', 2, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (4, 7, N'M4', 0, N'5', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (5, 7, N'M4', 0, N'6', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (6, 7, N'M4', 0, N'6', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (7, 7, N'M4', 1, N'1', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (8, 7, N'M4', 1, N'1', 2, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (9, 7, N'M4', 1, N'1', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (10, 7, N'M4', 1, N'1', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (11, 2, N'M5', 0, N'1', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (12, 2, N'M5', 0, N'1', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (13, 2, N'M5', 0, N'1', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (14, 2, N'M5', 0, N'3', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (15, 2, N'M5', 0, N'3', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (16, 2, N'M5', 0, N'6', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (17, 2, N'M5', 0, N'5', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (18, 2, N'M5', 0, N'5', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (19, 2, N'M5', 0, N'4', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (20, 2, N'M5', 0, N'4', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (21, 2, N'M5', 0, N'1', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (22, 2, N'M5', 0, N'1', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (23, 2, N'M5', 0, N'1', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (24, 2, N'M5', 0, N'1', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (25, 2, N'M5', 0, N'2', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (26, 2, N'M5', 0, N'3', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (27, 2, N'M5', 0, N'5', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (28, 2, N'M5', 0, N'6', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (29, 2, N'M5', 0, N'4', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (30, 2, N'M5', 0, N'5', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (31, 2, N'M5', 0, N'2', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (32, 2, N'M5', 0, N'1', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (33, 7, N'M4', 0, N'7', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (34, 7, N'M4', 0, N'7', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (35, 7, N'M4', 0, N'7', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (36, 7, N'M4', 0, N'6', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (37, 7, N'M4', 0, N'3', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (38, 7, N'M4', 0, N'2', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (39, 7, N'M4', 0, N'5', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (40, 7, N'M4', 0, N'4', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (41, 7, N'M4', 0, N'1', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (42, 7, N'M4', 0, N'2', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (43, 7, N'M4', 0, N'5', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (44, 7, N'M4', 0, N'6', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (45, 7, N'M4', 0, N'3', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (46, 7, N'M4', 0, N'7', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (47, 2, N'M5', 0, N'2', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (48, 2, N'M5', 0, N'5', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (49, 2, N'M5', 0, N'6', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (50, 2, N'M5', 0, N'7', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (51, 2, N'M5', 0, N'4', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (52, 2, N'M5', 0, N'1', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (53, 2, N'M5', 0, N'2', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (54, 2, N'M5', 0, N'1', 5, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (55, 2, N'M5', 0, N'3', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (56, 3, N'M7', 0, N'1', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (57, 3, N'M7', 0, N'4', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (58, 3, N'M7', 0, N'5', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (59, 3, N'M7', 0, N'2', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (60, 3, N'M7', 0, N'3', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (61, 3, N'M7', 0, N'6', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (62, 3, N'M7', 0, N'7', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (63, 2, N'M5', 0, N'1', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (64, 2, N'M5', 0, N'2', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (65, 2, N'M5', 0, N'1', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (66, 2, N'M5', 0, N'2', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (67, 2, N'M5', 0, N'3', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (68, 2, N'M5', 0, N'6', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (69, 2, N'M5', 0, N'5', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (70, 2, N'M5', 0, N'4', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (71, 2, N'M5', 0, N'7', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (72, 5, N'M3', 0, N'6', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (73, 5, N'M3', 0, N'3', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (74, 5, N'M3', 0, N'2', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (75, 5, N'M3', 0, N'5', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (76, 5, N'M3', 0, N'1', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (77, 5, N'M3', 0, N'4', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (78, 5, N'M3', 0, N'7', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (79, 5, N'M3', 0, N'4', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (80, 5, N'M3', 0, N'5', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (81, 5, N'M3', 0, N'3', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (82, 5, N'M3', 0, N'2', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (83, 5, N'M3', 0, N'1', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (84, 5, N'M3', 0, N'4', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (85, 5, N'M3', 0, N'5', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (86, 5, N'M3', 0, N'7', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (87, 5, N'M3', 0, N'5', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (88, 5, N'M3', 0, N'2', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (89, 6, N'M1', 0, N'2', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (90, 6, N'M1', 0, N'3', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (91, 6, N'M1', 0, N'1', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (92, 6, N'M1', 0, N'1', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (93, 6, N'M1', 0, N'1', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (94, 6, N'M1', 0, N'1', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (95, 6, N'M1', 0, N'1', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (96, 6, N'M1', 0, N'2', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (97, 6, N'M1', 0, N'2', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (98, 6, N'M1', 0, N'6', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (99, 6, N'M1', 0, N'7', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
GO
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (100, 6, N'M1', 0, N'4', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (101, 6, N'M1', 0, N'3', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (102, 6, N'M1', 0, N'2', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (103, 6, N'M1', 0, N'1', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (104, 6, N'M1', 0, N'4', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (105, 6, N'M1', 0, N'6', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (106, 6, N'M1', 0, N'7', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (107, 6, N'M1', 0, N'2', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (108, 6, N'M1', 0, N'5', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (109, 6, N'M1', 0, N'4', 1, CAST(N'2023-06-03T00:30:03.227' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (110, 7, N'M4', 0, N'1', 1, CAST(N'2023-06-03T01:07:17.903' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (111, 7, N'M4', 0, N'2', 1, CAST(N'2023-06-03T01:07:20.300' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (112, 7, N'M4', 0, N'3', 1, CAST(N'2023-06-03T01:07:21.563' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (113, 7, N'M4', 0, N'6', 1, CAST(N'2023-06-03T01:07:22.660' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (114, 7, N'M4', 0, N'1', 1, CAST(N'2023-06-03T01:09:06.457' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (115, 7, N'M4', 0, N'1', 1, CAST(N'2023-06-03T01:09:06.617' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (116, 7, N'M4', 0, N'1', 1, CAST(N'2023-06-03T01:09:06.750' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (117, 7, N'M4', 0, N'1', 1, CAST(N'2023-06-03T01:09:06.880' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (118, 7, N'M4', 0, N'1', 1, CAST(N'2023-06-03T01:09:07.010' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (119, 7, N'M4', 0, N'2', 1, CAST(N'2023-06-03T01:09:07.510' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (120, 7, N'M4', 0, N'2', 1, CAST(N'2023-06-03T01:09:07.640' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (121, 7, N'M4', 0, N'2', 1, CAST(N'2023-06-03T01:09:07.803' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (122, 7, N'M4', 0, N'3', 1, CAST(N'2023-06-03T01:09:08.177' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (123, 7, N'M4', 0, N'3', 1, CAST(N'2023-06-03T01:09:08.297' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (124, 7, N'M4', 0, N'6', 1, CAST(N'2023-06-03T01:09:08.613' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (125, 7, N'M4', 0, N'5', 1, CAST(N'2023-06-03T01:09:08.803' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (126, 7, N'M4', 0, N'4', 1, CAST(N'2023-06-03T01:09:08.993' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (127, 7, N'M4', 0, N'7', 1, CAST(N'2023-06-03T01:09:09.157' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (128, 8, N'M4', 0, N'5', 1, CAST(N'2023-06-03T01:10:32.540' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (129, 8, N'M4', 0, N'6', 1, CAST(N'2023-06-03T01:10:33.330' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (130, 8, N'M4', 0, N'3', 1, CAST(N'2023-06-03T01:10:33.527' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (131, 8, N'M4', 0, N'2', 1, CAST(N'2023-06-03T01:10:33.713' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (132, 8, N'M4', 0, N'4', 1, CAST(N'2023-06-03T01:10:34.077' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (133, 8, N'M4', 0, N'7', 1, CAST(N'2023-06-03T01:10:34.237' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (134, 8, N'M4', 0, N'7', 1, CAST(N'2023-06-03T01:10:34.393' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (135, 8, N'M4', 0, N'1', 1, CAST(N'2023-06-03T01:10:34.703' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (136, 8, N'M4', 0, N'1', 1, CAST(N'2023-06-03T01:10:34.820' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (137, 8, N'M4', 0, N'2', 1, CAST(N'2023-06-03T01:10:35.043' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (138, 8, N'M4', 0, N'2', 1, CAST(N'2023-06-03T01:10:35.137' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (139, 8, N'M4', 0, N'3', 1, CAST(N'2023-06-03T01:10:35.333' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (140, 8, N'M4', 0, N'3', 1, CAST(N'2023-06-03T01:10:35.470' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (141, 8, N'M4', 0, N'6', 1, CAST(N'2023-06-03T01:10:35.807' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (142, 8, N'M4', 0, N'6', 1, CAST(N'2023-06-03T01:10:35.940' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (143, 8, N'M4', 0, N'5', 1, CAST(N'2023-06-03T01:10:36.160' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (144, 8, N'M4', 0, N'5', 1, CAST(N'2023-06-03T01:10:36.267' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (145, 8, N'M4', 0, N'4', 1, CAST(N'2023-06-03T01:10:36.483' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (146, 8, N'M4', 0, N'4', 1, CAST(N'2023-06-03T01:10:36.617' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (147, 8, N'M4', 0, N'7', 1, CAST(N'2023-06-03T01:10:36.860' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (148, 8, N'M4', 0, N'7', 1, CAST(N'2023-06-03T01:10:36.997' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (149, 9, N'M4', 0, N'4', 1, CAST(N'2023-06-03T01:11:14.753' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (150, 9, N'M4', 0, N'5', 1, CAST(N'2023-06-03T01:11:15.613' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (151, 9, N'M4', 0, N'1', 1, CAST(N'2023-06-03T01:11:16.170' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (152, 9, N'M4', 0, N'4', 1, CAST(N'2023-06-03T01:11:16.280' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (153, 9, N'M4', 0, N'7', 1, CAST(N'2023-06-03T01:11:16.413' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (154, 9, N'M4', 0, N'4', 1, CAST(N'2023-06-03T01:11:16.680' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (155, 9, N'M4', 0, N'3', 1, CAST(N'2023-06-03T01:11:16.923' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (156, 9, N'M4', 0, N'2', 1, CAST(N'2023-06-03T01:11:17.037' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (157, 9, N'M4', 0, N'1', 1, CAST(N'2023-06-03T01:11:17.167' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (158, 9, N'M4', 0, N'7', 1, CAST(N'2023-06-03T01:11:17.810' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (159, 10, N'M4', 0, N'1', 1, CAST(N'2023-06-03T01:28:13.153' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (160, 10, N'M4', 0, N'2', 1, CAST(N'2023-06-03T01:28:13.397' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (161, 10, N'M4', 0, N'3', 1, CAST(N'2023-06-03T01:28:13.587' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (162, 10, N'M4', 0, N'6', 1, CAST(N'2023-06-03T01:28:13.777' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (163, 10, N'M4', 0, N'5', 1, CAST(N'2023-06-03T01:28:13.967' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (164, 10, N'M4', 0, N'4', 1, CAST(N'2023-06-03T01:28:14.160' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (165, 10, N'M4', 0, N'7', 1, CAST(N'2023-06-03T01:28:14.377' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (166, 10, N'M4', 0, N'4', 1, CAST(N'2023-06-03T01:28:14.563' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (167, 10, N'M4', 0, N'1', 1, CAST(N'2023-06-03T01:28:14.727' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (168, 10, N'M4', 0, N'2', 1, CAST(N'2023-06-03T01:28:14.890' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (169, 10, N'M4', 0, N'5', 1, CAST(N'2023-06-03T01:28:15.183' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (170, 10, N'M4', 0, N'3', 1, CAST(N'2023-06-03T01:28:15.430' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (171, 10, N'M4', 0, N'3', 1, CAST(N'2023-06-03T01:28:15.563' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (172, 10, N'M4', 0, N'2', 1, CAST(N'2023-06-03T01:28:15.810' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (173, 10, N'M4', 0, N'4', 1, CAST(N'2023-06-03T01:28:15.950' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (174, 10, N'M4', 0, N'2', 1, CAST(N'2023-06-03T01:28:16.293' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (175, 10, N'M4', 0, N'3', 1, CAST(N'2023-06-03T01:28:16.443' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (176, 10, N'M4', 0, N'3', 1, CAST(N'2023-06-03T01:28:16.560' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (177, 11, N'M5', 0, N'1', 1, CAST(N'2023-06-03T01:29:51.880' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (178, 11, N'M5', 0, N'2', 1, CAST(N'2023-06-03T01:29:52.063' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (179, 11, N'M5', 0, N'3', 1, CAST(N'2023-06-03T01:29:52.247' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (180, 11, N'M5', 0, N'6', 1, CAST(N'2023-06-03T01:29:52.403' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (181, 11, N'M5', 0, N'5', 1, CAST(N'2023-06-03T01:29:52.567' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (182, 11, N'M5', 0, N'4', 1, CAST(N'2023-06-03T01:29:52.727' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (183, 11, N'M5', 0, N'7', 1, CAST(N'2023-06-03T01:29:52.910' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (184, 11, N'M5', 0, N'4', 1, CAST(N'2023-06-03T01:29:53.060' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (185, 11, N'M5', 0, N'1', 1, CAST(N'2023-06-03T01:29:53.210' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (186, 11, N'M5', 0, N'6', 1, CAST(N'2023-06-03T01:29:53.580' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (187, 11, N'M5', 0, N'5', 1, CAST(N'2023-06-03T01:29:53.713' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (188, 11, N'M5', 0, N'7', 1, CAST(N'2023-06-03T01:29:54.020' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (189, 11, N'M5', 0, N'7', 1, CAST(N'2023-06-03T01:29:54.113' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (190, 11, N'M5', 0, N'5', 1, CAST(N'2023-06-03T01:29:54.367' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (191, 11, N'M5', 0, N'6', 1, CAST(N'2023-06-03T01:29:54.487' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (192, 12, N'M4', 0, N'1', 1, CAST(N'2023-06-03T01:40:08.217' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (193, 12, N'M4', 0, N'2', 1, CAST(N'2023-06-03T01:40:10.810' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (194, 12, N'M4', 0, N'6', 1, CAST(N'2023-06-03T01:40:13.033' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (195, 12, N'M4', 0, N'5', 1, CAST(N'2023-06-03T01:40:14.560' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (196, 12, N'M4', 0, N'4', 1, CAST(N'2023-06-03T01:40:14.737' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (197, 12, N'M4', 0, N'7', 1, CAST(N'2023-06-03T01:40:14.890' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (198, 12, N'M4', 0, N'2', 1, CAST(N'2023-06-03T01:40:15.180' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (199, 12, N'M4', 0, N'1', 1, CAST(N'2023-06-03T01:40:16.133' AS DateTime), 0, 1, 0)
GO
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (200, 12, N'M4', 0, N'5', 1, CAST(N'2023-06-03T01:40:16.630' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (201, 12, N'M4', 0, N'7', 1, CAST(N'2023-06-03T01:40:17.087' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (202, 12, N'M4', 0, N'7', 1, CAST(N'2023-06-03T01:40:17.243' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (203, 12, N'M4', 0, N'7', 1, CAST(N'2023-06-03T01:40:17.380' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (204, 12, N'M4', 0, N'7', 1, CAST(N'2023-06-03T01:40:17.523' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (205, 12, N'M4', 0, N'7', 1, CAST(N'2023-06-03T01:40:17.667' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (206, 12, N'M4', 0, N'7', 1, CAST(N'2023-06-03T01:40:17.813' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (207, 12, N'M4', 0, N'7', 1, CAST(N'2023-06-03T01:40:17.947' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (208, 12, N'M4', 0, N'7', 1, CAST(N'2023-06-03T01:40:18.080' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (209, 12, N'M4', 0, N'7', 1, CAST(N'2023-06-03T01:40:18.193' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (210, 13, N'M5', 0, N'1', 1, CAST(N'2024-01-27T03:20:00.143' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (211, 13, N'M5', 0, N'2', 1, CAST(N'2024-01-27T03:20:02.883' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (212, 13, N'M5', 0, N'3', 1, CAST(N'2024-01-27T03:20:05.177' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (213, 13, N'M5', 0, N'3', 1, CAST(N'2024-01-27T03:20:10.980' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (214, 13, N'M5', 0, N'6', 1, CAST(N'2024-01-27T03:20:12.917' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (215, 13, N'M5', 0, N'5', 1, CAST(N'2024-01-27T03:20:13.167' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (216, 13, N'M5', 0, N'4', 1, CAST(N'2024-01-27T03:20:13.463' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (217, 13, N'M5', 0, N'2', 1, CAST(N'2024-01-27T03:20:13.950' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (218, 13, N'M5', 0, N'2', 1, CAST(N'2024-01-27T03:20:14.127' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (219, 13, N'M5', 0, N'2', 1, CAST(N'2024-01-27T03:20:14.873' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (220, 13, N'M5', 0, N'2', 1, CAST(N'2024-01-27T03:20:15.003' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (221, 13, N'M5', 0, N'3', 1, CAST(N'2024-01-27T03:20:15.463' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (222, 13, N'M5', 0, N'3', 1, CAST(N'2024-01-27T03:20:15.657' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (223, 13, N'M5', 0, N'2', 1, CAST(N'2024-01-27T03:20:17.903' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (224, 13, N'M5', 0, N'3', 3, CAST(N'2024-01-27T03:22:38.477' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (225, 13, N'M5', 0, N'3', 3, CAST(N'2024-01-27T03:22:41.273' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (226, 14, N'M3', 0, N'2', 1, CAST(N'2024-01-27T03:23:18.180' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (227, 14, N'M3', 0, N'2', 1, CAST(N'2024-01-27T03:23:19.383' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (228, 14, N'M3', 0, N'3', 3, CAST(N'2024-01-27T03:23:20.670' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (229, 14, N'M3', 0, N'6', 3, CAST(N'2024-01-27T03:23:22.683' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (230, 14, N'M3', 0, N'7', 3, CAST(N'2024-01-27T03:23:25.280' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (231, 14, N'M3', 0, N'5', 3, CAST(N'2024-01-27T03:23:26.870' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (232, 15, N'M5', 0, N'3', 3, CAST(N'2024-01-27T03:24:06.033' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (233, 15, N'M5', 0, N'', 5, CAST(N'2024-01-27T03:53:31.017' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (234, 15, N'M5', 1, N'2', 1, CAST(N'2024-01-27T04:19:33.397' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (235, 15, N'M5', 1, N'', 1, CAST(N'2024-01-27T04:19:37.907' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (236, 15, N'M5', 1, N'6', 1, CAST(N'2024-01-27T04:19:39.547' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (237, 15, N'M5', 1, N'7', 1, CAST(N'2024-01-27T04:19:40.903' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (238, 15, N'M5', 1, N'4', 1, CAST(N'2024-01-27T04:19:42.090' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (239, 15, N'M5', 1, N'6', 1, CAST(N'2024-01-27T04:19:49.947' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (240, 15, N'M5', 0, N'3', 1, CAST(N'2024-01-27T04:19:53.433' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (241, 16, N'M4', 0, N'', 1, CAST(N'2024-01-27T04:20:22.177' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (242, 16, N'M4', 0, N'3', 1, CAST(N'2024-01-27T04:20:24.150' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (243, 16, N'M4', 0, N'5', 1, CAST(N'2024-01-27T04:20:25.593' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (244, 16, N'M4', 0, N'2', 1, CAST(N'2024-01-27T04:20:27.037' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (245, 16, N'M4', 0, N'7', 1, CAST(N'2024-01-27T04:20:28.660' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (246, 16, N'M4', 1, N'3', 1, CAST(N'2024-01-27T04:20:36.003' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (247, 16, N'M4', 1, N'3', 1, CAST(N'2024-01-27T04:20:37.720' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (248, 16, N'M4', 0, N'1', 1, CAST(N'2024-01-27T04:21:20.217' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (249, 16, N'M4', 0, N'1', 1, CAST(N'2024-01-27T04:21:22.423' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (250, 16, N'M4', 0, N'5', 1, CAST(N'2024-01-27T04:21:27.083' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (251, 16, N'M4', 0, N'6', 1, CAST(N'2024-01-27T04:21:28.840' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (252, 17, N'M5', 0, N'3', 1, CAST(N'2024-01-27T04:21:37.740' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (253, 18, N'M4', 0, N'2', 1, CAST(N'2024-01-27T04:23:56.943' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (254, 18, N'M4', 0, N'6', 1, CAST(N'2024-01-27T04:23:58.323' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (255, 18, N'M4', 0, N'7', 1, CAST(N'2024-01-27T04:24:00.020' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (256, 18, N'M4', 1, N'3', 1, CAST(N'2024-01-27T04:24:04.820' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (257, 18, N'M4', 1, N'6', 1, CAST(N'2024-01-27T04:24:06.120' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (258, 18, N'M4', 1, N'5', 1, CAST(N'2024-01-27T04:24:07.473' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (259, 18, N'M4', 0, N'2', 3, CAST(N'2024-01-27T04:26:41.090' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (260, 18, N'M4', 0, N'6', 1, CAST(N'2024-01-27T04:26:44.503' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (261, 18, N'M4', 1, N'7', 1, CAST(N'2024-01-27T04:26:49.187' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (262, 18, N'M4', 1, N'7', 1, CAST(N'2024-01-27T04:26:51.123' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (263, 18, N'M4', 1, N'7', 1, CAST(N'2024-01-27T04:26:52.447' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (264, 18, N'M4', 1, N'4', 1, CAST(N'2024-01-27T04:26:53.677' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (265, 17, N'M5', 0, N'1', 1, CAST(N'2024-01-29T05:00:04.937' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (266, 17, N'M5', 0, N'1', 1, CAST(N'2024-01-29T05:00:06.213' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (267, 17, N'M5', 0, N'1', 1, CAST(N'2024-01-29T05:00:06.370' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (268, 17, N'M5', 0, N'2', 1, CAST(N'2024-01-29T05:00:06.917' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (269, 17, N'M5', 0, N'2', 1, CAST(N'2024-01-29T05:00:07.070' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (270, 17, N'M5', 0, N'2', 1, CAST(N'2024-01-29T05:00:08.410' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (271, 17, N'M5', 0, N'3', 1, CAST(N'2024-01-29T05:00:09.017' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (272, 17, N'M5', 0, N'3', 1, CAST(N'2024-01-29T05:00:09.187' AS DateTime), 0, 1, 0)
INSERT [dbo].[Masa_Adisyonlari] ([adi_RECno], [adi_adisyon_sirano], [adi_masa_kod], [adi_garson_kod], [adi_urun_kod], [adi_urun_adet], [adi_kayit_tarih], [adi_kaydeden], [adi_hesap_alindi], [adi_hesap_alan]) VALUES (273, 19, N'M4', 0, N'6', 5, CAST(N'2024-01-29T06:58:32.100' AS DateTime), 0, 1, 0)
SET IDENTITY_INSERT [dbo].[Masa_Adisyonlari] OFF
GO
SET IDENTITY_INSERT [dbo].[Masa_Tanimlari] ON 

INSERT [dbo].[Masa_Tanimlari] ([masa_RECno], [masa_kodu], [masa_adi], [masa_bolum_kodu], [masa_rezerve], [masa_aktif], [masa_kayit_tarih], [masa_kaydeden], [masa_guncelleme_tarih], [masa_guncelleyen]) VALUES (1, N'M1', N'Masa 1', N'B1', 1, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Masa_Tanimlari] ([masa_RECno], [masa_kodu], [masa_adi], [masa_bolum_kodu], [masa_rezerve], [masa_aktif], [masa_kayit_tarih], [masa_kaydeden], [masa_guncelleme_tarih], [masa_guncelleyen]) VALUES (2, N'M2', N'Masa 2', N'B1', 0, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Masa_Tanimlari] ([masa_RECno], [masa_kodu], [masa_adi], [masa_bolum_kodu], [masa_rezerve], [masa_aktif], [masa_kayit_tarih], [masa_kaydeden], [masa_guncelleme_tarih], [masa_guncelleyen]) VALUES (3, N'M3', N'Masa 3', N'A1', 0, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Masa_Tanimlari] ([masa_RECno], [masa_kodu], [masa_adi], [masa_bolum_kodu], [masa_rezerve], [masa_aktif], [masa_kayit_tarih], [masa_kaydeden], [masa_guncelleme_tarih], [masa_guncelleyen]) VALUES (4, N'M4', N'Masa 4', N'G1', 0, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Masa_Tanimlari] ([masa_RECno], [masa_kodu], [masa_adi], [masa_bolum_kodu], [masa_rezerve], [masa_aktif], [masa_kayit_tarih], [masa_kaydeden], [masa_guncelleme_tarih], [masa_guncelleyen]) VALUES (5, N'M5', N'Masa 5', N'G1', 1, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Masa_Tanimlari] ([masa_RECno], [masa_kodu], [masa_adi], [masa_bolum_kodu], [masa_rezerve], [masa_aktif], [masa_kayit_tarih], [masa_kaydeden], [masa_guncelleme_tarih], [masa_guncelleyen]) VALUES (6, N'M6', N'Masa 6', N'B2', 0, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Masa_Tanimlari] ([masa_RECno], [masa_kodu], [masa_adi], [masa_bolum_kodu], [masa_rezerve], [masa_aktif], [masa_kayit_tarih], [masa_kaydeden], [masa_guncelleme_tarih], [masa_guncelleyen]) VALUES (7, N'M7', N'Masa 7', N'S1', 0, 1, CAST(N'2023-05-21T00:55:40.227' AS DateTime), 0, NULL, NULL)
INSERT [dbo].[Masa_Tanimlari] ([masa_RECno], [masa_kodu], [masa_adi], [masa_bolum_kodu], [masa_rezerve], [masa_aktif], [masa_kayit_tarih], [masa_kaydeden], [masa_guncelleme_tarih], [masa_guncelleyen]) VALUES (8, N'M8', N'Masa 8', N'S2', 1, 1, CAST(N'2023-05-21T00:56:52.980' AS DateTime), 0, CAST(N'2023-05-21T00:56:58.210' AS DateTime), 0)
INSERT [dbo].[Masa_Tanimlari] ([masa_RECno], [masa_kodu], [masa_adi], [masa_bolum_kodu], [masa_rezerve], [masa_aktif], [masa_kayit_tarih], [masa_kaydeden], [masa_guncelleme_tarih], [masa_guncelleyen]) VALUES (9, N'M9', N'Masa 9', N'S2', 0, 1, CAST(N'2023-05-21T00:57:14.563' AS DateTime), 0, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Masa_Tanimlari] OFF
GO
SET IDENTITY_INSERT [dbo].[Stok_Hareketleri] ON 

INSERT [dbo].[Stok_Hareketleri] ([sth_RECno], [sth_kod], [sth_tip], [sth_adet], [sth_fiyat], [sth_kaydeden], [sth_kayit_tarih], [sth_guncelleyen], [sth_guncelleme_tarih]) VALUES (1, N'1', N'Giriş', 20, 1, 0, CAST(N'2024-01-29T06:55:44.073' AS DateTime), NULL, NULL)
INSERT [dbo].[Stok_Hareketleri] ([sth_RECno], [sth_kod], [sth_tip], [sth_adet], [sth_fiyat], [sth_kaydeden], [sth_kayit_tarih], [sth_guncelleyen], [sth_guncelleme_tarih]) VALUES (2, N'2', N'Giriş', 50, 5, 0, CAST(N'2024-01-29T06:55:49.623' AS DateTime), NULL, NULL)
INSERT [dbo].[Stok_Hareketleri] ([sth_RECno], [sth_kod], [sth_tip], [sth_adet], [sth_fiyat], [sth_kaydeden], [sth_kayit_tarih], [sth_guncelleyen], [sth_guncelleme_tarih]) VALUES (3, N'3', N'Giriş', 50, 1, 0, CAST(N'2024-01-29T06:55:56.200' AS DateTime), NULL, NULL)
INSERT [dbo].[Stok_Hareketleri] ([sth_RECno], [sth_kod], [sth_tip], [sth_adet], [sth_fiyat], [sth_kaydeden], [sth_kayit_tarih], [sth_guncelleyen], [sth_guncelleme_tarih]) VALUES (4, N'4', N'Giriş', 25, 3, 0, CAST(N'2024-01-29T06:56:02.593' AS DateTime), NULL, NULL)
INSERT [dbo].[Stok_Hareketleri] ([sth_RECno], [sth_kod], [sth_tip], [sth_adet], [sth_fiyat], [sth_kaydeden], [sth_kayit_tarih], [sth_guncelleyen], [sth_guncelleme_tarih]) VALUES (5, N'5', N'Giriş', 50, 5, 0, CAST(N'2024-01-29T06:56:11.610' AS DateTime), NULL, NULL)
INSERT [dbo].[Stok_Hareketleri] ([sth_RECno], [sth_kod], [sth_tip], [sth_adet], [sth_fiyat], [sth_kaydeden], [sth_kayit_tarih], [sth_guncelleyen], [sth_guncelleme_tarih]) VALUES (6, N'6', N'Giriş', 5, 25, 0, CAST(N'2024-01-29T06:56:19.520' AS DateTime), NULL, NULL)
INSERT [dbo].[Stok_Hareketleri] ([sth_RECno], [sth_kod], [sth_tip], [sth_adet], [sth_fiyat], [sth_kaydeden], [sth_kayit_tarih], [sth_guncelleyen], [sth_guncelleme_tarih]) VALUES (7, N'7', N'Giriş', 5, 40, 0, CAST(N'2024-01-29T06:56:28.293' AS DateTime), NULL, NULL)
INSERT [dbo].[Stok_Hareketleri] ([sth_RECno], [sth_kod], [sth_tip], [sth_adet], [sth_fiyat], [sth_kaydeden], [sth_kayit_tarih], [sth_guncelleyen], [sth_guncelleme_tarih]) VALUES (8, N'7', N'Giriş', 5, 40, 0, CAST(N'2024-01-29T06:56:55.157' AS DateTime), NULL, NULL)
INSERT [dbo].[Stok_Hareketleri] ([sth_RECno], [sth_kod], [sth_tip], [sth_adet], [sth_fiyat], [sth_kaydeden], [sth_kayit_tarih], [sth_guncelleyen], [sth_guncelleme_tarih]) VALUES (9, N'6', N'Çıkış', 5, 25, 0, CAST(N'2024-01-29T06:58:34.983' AS DateTime), NULL, NULL)
SET IDENTITY_INSERT [dbo].[Stok_Hareketleri] OFF
GO
SET IDENTITY_INSERT [dbo].[Stok_Tanimlari] ON 

INSERT [dbo].[Stok_Tanimlari] ([sto_RECno], [sto_kodu], [sto_adi], [sto_birim], [sto_satis_fiyat], [sto_alis_fiyat], [sto_aktif], [sto_kayit_tarih], [sto_kaydeden], [sto_guncelleme_tarih], [sto_guncelleyen], [sto_gorsel], [sto_max], [sto_min], [sto_eksi_olabilir]) VALUES (1, N'1', N'Çay', N'Adet', 5, 4, 1, NULL, 0, CAST(N'2024-01-29T06:54:49.563' AS DateTime), 0, N'', 100, 10, NULL)
INSERT [dbo].[Stok_Tanimlari] ([sto_RECno], [sto_kodu], [sto_adi], [sto_birim], [sto_satis_fiyat], [sto_alis_fiyat], [sto_aktif], [sto_kayit_tarih], [sto_kaydeden], [sto_guncelleme_tarih], [sto_guncelleyen], [sto_gorsel], [sto_max], [sto_min], [sto_eksi_olabilir]) VALUES (2, N'2', N'Kola', N'Adet', 10, 8, 1, NULL, 0, NULL, NULL, NULL, 50, 10, NULL)
INSERT [dbo].[Stok_Tanimlari] ([sto_RECno], [sto_kodu], [sto_adi], [sto_birim], [sto_satis_fiyat], [sto_alis_fiyat], [sto_aktif], [sto_kayit_tarih], [sto_kaydeden], [sto_guncelleme_tarih], [sto_guncelleyen], [sto_gorsel], [sto_max], [sto_min], [sto_eksi_olabilir]) VALUES (3, N'3', N'Su', N'Adet', 5, 1, 1, NULL, 0, NULL, NULL, NULL, 100, 20, NULL)
INSERT [dbo].[Stok_Tanimlari] ([sto_RECno], [sto_kodu], [sto_adi], [sto_birim], [sto_satis_fiyat], [sto_alis_fiyat], [sto_aktif], [sto_kayit_tarih], [sto_kaydeden], [sto_guncelleme_tarih], [sto_guncelleyen], [sto_gorsel], [sto_max], [sto_min], [sto_eksi_olabilir]) VALUES (4, N'4', N'Soda', N'Adet', 5, 4, 1, NULL, 0, NULL, NULL, NULL, 30, 5, NULL)
INSERT [dbo].[Stok_Tanimlari] ([sto_RECno], [sto_kodu], [sto_adi], [sto_birim], [sto_satis_fiyat], [sto_alis_fiyat], [sto_aktif], [sto_kayit_tarih], [sto_kaydeden], [sto_guncelleme_tarih], [sto_guncelleyen], [sto_gorsel], [sto_max], [sto_min], [sto_eksi_olabilir]) VALUES (5, N'5', N'Fanta', N'Adet', 10, 8, 1, CAST(N'2023-05-24T00:25:37.530' AS DateTime), 0, CAST(N'2023-05-24T00:27:30.437' AS DateTime), 0, NULL, 50, 10, NULL)
INSERT [dbo].[Stok_Tanimlari] ([sto_RECno], [sto_kodu], [sto_adi], [sto_birim], [sto_satis_fiyat], [sto_alis_fiyat], [sto_aktif], [sto_kayit_tarih], [sto_kaydeden], [sto_guncelleme_tarih], [sto_guncelleyen], [sto_gorsel], [sto_max], [sto_min], [sto_eksi_olabilir]) VALUES (6, N'6', N'Karışık Küçük Boy Pizza', N'Adet', 25, 20, 1, CAST(N'2023-05-24T00:41:12.013' AS DateTime), 0, CAST(N'2024-01-29T06:55:20.433' AS DateTime), 0, N'', 10, 2, NULL)
INSERT [dbo].[Stok_Tanimlari] ([sto_RECno], [sto_kodu], [sto_adi], [sto_birim], [sto_satis_fiyat], [sto_alis_fiyat], [sto_aktif], [sto_kayit_tarih], [sto_kaydeden], [sto_guncelleme_tarih], [sto_guncelleyen], [sto_gorsel], [sto_max], [sto_min], [sto_eksi_olabilir]) VALUES (7, N'7', N'Karışık Orta Pizza', N'Adet', 50, 40, 1, CAST(N'2023-05-24T01:33:28.947' AS DateTime), 0, CAST(N'2024-01-29T06:55:28.507' AS DateTime), 0, N'', 10, 2, NULL)
SET IDENTITY_INSERT [dbo].[Stok_Tanimlari] OFF
GO
SET IDENTITY_INSERT [dbo].[Stok_Tanimlari_Silinenler] ON 

INSERT [dbo].[Stok_Tanimlari_Silinenler] ([sto_RECno], [sto_kodu], [sto_adi], [sto_birim], [sto_satis_fiyat], [sto_alis_fiyat], [sto_aktif], [sto_kayit_tarih], [sto_kaydeden], [sto_guncelleme_tarih], [sto_guncelleyen]) VALUES (1, N'1', N'Çay', N'Adet', 5, 4, 1, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Stok_Tanimlari_Silinenler] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Bolum_Tanimlari]    Script Date: 29.01.2024 07:11:41 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Bolum_Tanimlari] ON [dbo].[Bolum_Tanimlari]
(
	[bol_kodu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Masa_Tanimlari_1]    Script Date: 29.01.2024 07:11:41 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_Masa_Tanimlari_1] ON [dbo].[Masa_Tanimlari]
(
	[masa_kodu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Bolum_Tanimlari] ADD  CONSTRAINT [DF_Bolum_Tanimlari_bol_aktif]  DEFAULT ((1)) FOR [bol_aktif]
GO
ALTER TABLE [dbo].[Bolum_Tanimlari] ADD  CONSTRAINT [DF_Bolum_Tanimlari_bol_rezerve]  DEFAULT ((0)) FOR [bol_rezerve]
GO
ALTER TABLE [dbo].[Masa_Tanimlari] ADD  CONSTRAINT [DF_Masa_Tanimlari_masa_rezerve]  DEFAULT ((0)) FOR [masa_rezerve]
GO
ALTER TABLE [dbo].[Masa_Tanimlari] ADD  CONSTRAINT [DF_Masa_Tanimlari_masa_aktif]  DEFAULT ((1)) FOR [masa_aktif]
GO
/****** Object:  StoredProcedure [dbo].[sp_MasaHesapAl]    Script Date: 29.01.2024 07:11:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_MasaHesapAl] 
	 @masa_kodu as nvarchar(10)
	,@hesabi_alan as int
AS
BEGIN
	
	declare @sira_no as int
	set @sira_no = (select max(isnull(adi_adisyon_sirano,0))+1 from [Masa_Adisyonlari])

	declare @toplam_tutar as int
	set @toplam_tutar = (select toplam_tutar from [dbo].[fn_MasaButonOzet](@masa_kodu) )
	

	UPDATE [dbo].[Masa_Adisyonlari]
	   SET  
		 adi_hesap_alindi = 1 
	   , adi_hesap_alan = @hesabi_alan 
	   , adi_adisyon_sirano = @sira_no
	where adi_masa_kod = @masa_kodu and adi_hesap_alindi = 0 and adi_adisyon_sirano = 0
		

	INSERT INTO [dbo].[Alinan_Hesaplar]
	       (
				[hsp_adisyon_sirano]
			   ,[hsp_adisyon_tarih]
			   ,[hsp_toplam_tutar]
			   ,[hsp_adisyonu_kapatan]
			   ,hsp_kayit_tarih
		   )
     VALUES
           (
				@sira_no
			   ,getdate()
			   ,@toplam_tutar
			   ,@hesabi_alan
			   ,getdate()
		   )



		   INSERT INTO [dbo].[Stok_Hareketleri]
           (
			      [sth_kod]
			    , [sth_tip]
			    , [sth_adet]
			    , [sth_fiyat]
			    , [sth_kaydeden]
			    , [sth_kayit_tarih]
		   ) 
		   SELECT 
				  [adi_urun_kod]
				, 'Çıkış'
				, [adi_urun_adet]
				, (select sto_satis_fiyat from Stok_Tanimlari where sto_kodu = [adi_urun_kod])
				, @hesabi_alan
				, GETDATE()
            FROM [dbo].[Masa_Adisyonlari]

			WHERE  
				  adi_masa_kod = @masa_kodu and 
				  adi_hesap_alan = @hesabi_alan and  
				  adi_adisyon_sirano = @sira_no


	select @sira_no

END
GO
USE [master]
GO
ALTER DATABASE [AdisyonTakip] SET  READ_WRITE 
GO
