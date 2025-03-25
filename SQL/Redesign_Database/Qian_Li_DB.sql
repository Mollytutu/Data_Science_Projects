-- SAAS BUSINESS FOR SALE: This dataset contains information about businesses built on SaaS products, scraped from acquire.com. 

-- TABLE 1
CREATE TABLE BUSINESS (
	Business_ID INT PRIMARY KEY AUTO_INCREMENT, 
    Business_Focus VARCHAR(100) NOT NULL,
    Asking_Price DECIMAL(12,2) NOT NULL,
	Team_Size SMALLINT DEFAULT 1,
    Location VARCHAR(32),
    Date_Founded DATE,
    Listed_Date DATE,
    Listing_Type ENUM('Platinum', 'Premium') NOT NULL
);

-- 2 refined and combined with BUSINESS DES table compare to the ligical_Diagram
CREATE TABLE FINANCIAL (
	Financial_ID INT PRIMARY KEY AUTO_INCREMENT, 
    Business_ID INT NOT NULL,
    
    Revenue_Multiple DECIMAL(3,1) NOT NULL,
    Total_Revenue_Annual DECIMAL(12,0) NOT NULL,
    Total_Profit_Annual DECIMAL(12,0) Not NULL,
    Total_Annual_Growth DECIMAL(5,2),
	TTM_Revenue DECIMAL(12,2), 
    TTM_Profit DECIMAL(12,2), 
    LAST_Month_Revenue DECIMAL(12,2), 
    LAST_Month_Profit DECIMAL(12,2),
    
    CONSTRAINT FK_FINANCIAL_BUSINESS_ID 
		FOREIGN KEY (Business_ID) 
		REFERENCES BUSINESS(Business_ID) 
        ON DELETE CASCADE
        
)AUTO_INCREMENT = 100001;
 
 -- 3
CREATE TABLE BUSINESS_MODEL(
	Business_ID INT PRIMARY KEY,
    Subscription_Type VARCHAR(32),
    Charge_Period ENUM('Monthly', 'Yearly') NOT NULL,
    Charge_Type ENUM('Flat', 'Commission', 'Hybrid') NOT NULL,
    Charge_Rate DECIMAL(10,2) NOT NULL,
    B2B BOOLEAN DEFAULT FALSE,
    CONSTRAINT FK_BUSINESS_MODEL_BUSINESS_ID 
		FOREIGN KEY(Business_ID)
		REFERENCES BUSINESS(Business_ID)
		ON DELETE CASCADE
);

-- 4
CREATE TABLE MARKETING_DATA(
	Business_ID INT PRIMARY KEY, 
    Customers ENUM('10-100', '100-1,000', '1,000-10,000', '10,000-100,000','100,000+') NOT NULL,
    Keywords VARCHAR(32) NOT NULL, 
    Weekly_View INT NOT NULL CHECK(Weekly_View >0),
    
    CONSTRAINT FK_MARKETING_DATA_BUSINESS_ID 
		FOREIGN KEY(Business_ID) 
		REFERENCES BUSINESS(Business_ID) 
		ON DELETE CASCADE
);

-- 5 table to seperate multivalue column 
CREATE TABLE COMPETITORS (
	Business_ID INT PRIMARY KEY,
    Competitor_Name VARCHAR(50) NOT NULL,
	Competitor_Business_ID INT,
    
    CONSTRAINT FK_COMPETITORS_BUSINESS
        FOREIGN KEY (Business_ID) 
        REFERENCES BUSINESS(Business_ID) 
        ON DELETE CASCADE,

    CONSTRAINT FK_COMPETITORS_COMPETITOR_BUSINESS_ID 
		FOREIGN KEY (Competitor_Business_ID)
		REFERENCES BUSINESS(Business_ID)
        ON DELETE CASCADE
);

-- 6 many to many relationship
CREATE TABLE TECHNOLOGY (
	Tech_Stack_ID INT PRIMARY KEY AUTO_INCREMENT,
    Tech_Stack_Name VARCHAR(32) NOT NULL,
    Tech_Stack_Type VARCHAR(16) NOT NULL
) AUTO_INCREMENT = 33001 ;
    
-- 7 Junction table. Refined from LOGICAL DIAGRAM. This table creates a many-to-many relationship between businesses and technologies.
CREATE TABLE BUSINESS_TECHNOLOGY (
	Business_ID INT NOT NULL, 
    Tech_Stack_ID INT NOT NULL, 
    
    PRIMARY KEY (Business_ID, Tech_Stack_ID),
    
    CONSTRAINT FK_BUSINESS_TECHNOLOGY_BUSINESS_ID
        FOREIGN KEY (Business_ID) 
        REFERENCES BUSINESS(Business_ID) 
        ON DELETE CASCADE,
        
    CONSTRAINT FK_BUSINESS_TECHNOLOGY_TECH_STACK_ID
        FOREIGN KEY (Tech_Stack_ID) 
        REFERENCES TECHNOLOGY(Tech_Stack_ID) 
        ON DELETE CASCADE
);

-- 8 Annual_Profit was multivalue column. use seperate table to void multivalue. 
CREATE TABLE ANNUAL_PROFIT (
    Financial_ID INT PRIMARY KEY,
    Profit_From_Region VARCHAR(32) NOT NULL,
    Profit_From_Sector VARCHAR(32 )NOT NULL,
    CONSTRAINT FK_ANNUAL_PROFIT_FINANCIAL_ID
        FOREIGN KEY (Financial_ID) 
        REFERENCES FINANCIAL(Financial_ID)
        ON DELETE CASCADE
);

SHOW TABLES;