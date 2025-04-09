CREATE TABLE [dbo].[mfg_cus] (
	first_name NVARCHAR(255),
	last_name NVARCHAR(255),
	email NVARCHAR(255),
	country NVARCHAR(10),
	is_current NVARCHAR(5),
	start_date DATETIME,
	end_date DATETIME,
	customer_code NVARCHAR(255) NOT NULL
)

-- SELECT * FROM mfg_cus
-- TRUNCATE TABLE mfg_cus