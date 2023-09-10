--Create table schema
CREATE TABLE "category" (
    "category_id" VARCHAR(50) PRIMARY KEY  NOT NULL,
    "category" VARCHAR(50)   NOT NULL
);
CREATE TABLE "contact" (
    "contact_id" INT PRIMARY KEY  NOT NULL,
    "first_name" VARCHAR(50)   NOT NULL,
    "last_name" VARCHAR(50)   NOT NULL,
    "email" VARCHAR(50)   NOT NULL
);
CREATE TABLE "subcategory" (
    "subcategory_id" VARCHAR(50) PRIMARY KEY NOT NULL,
    "subcategory" VARCHAR(50)   NOT NULL
);
CREATE TABLE "campaign" (
    "cf_id" INT PRIMARY KEY  NOT NULL,
    "contact_id" INT   NOT NULL,
        FOREIGN KEY (contact_id) REFERENCES contact(contact_id),
    "company_name" VARCHAR(50)   NOT NULL,
    "description" VARCHAR(225)   NOT NULL,
    "goal" NUMERIC(10,2)   NOT NULL,
    "pledged" NUMERIC(10,2)   NOT NULL,
    "outcome" VARCHAR(50)   NOT NULL,
    "backers_count" INT   NOT NULL,
    "country" VARCHAR(50)   NOT NULL,
    "currency" VARCHAR(50)   NOT NULL,
    "launched_date" DATE   NOT NULL,
    "end_date" DATE   NOT NULL,
    "category_id" VARCHAR(50)   NOT NULL,
        FOREIGN KEY (category_id) REFERENCES category(category_id),
    "subcategory_id" VARCHAR(50)   NOT NULL,
        FOREIGN KEY (subcategory_id) REFERENCES subcategory(subcategory_id)
);

SELECT * FROM category;
SELECT * FROM subcategory;
SELECT * FROM contact;
SELECT * FROM campaign;

CREATE TABLE contact_campaign(
	contact_id INT NOT NULL,
	FOREIGN KEY (contact_id) REFERENCES contact(contact_id),
    cf_id INT NOT NULL,
	FOREIGN KEY (cf_id) REFERENCES campaign(cf_id),
	PRIMARY KEY (contact_id, cf_id)
);

CREATE TABLE category_campaign(
	category_id VARCHAR(50) NOT NULL,
	FOREIGN KEY (category_id) REFERENCES category(category_id),
    cf_id INT NOT NULL,
	FOREIGN KEY (cf_id) REFERENCES campaign(cf_id),
	PRIMARY KEY (category_id, cf_id)
);

CREATE TABLE subcategory_campaign(
	subcategory_id VARCHAR(50) NOT NULL,
	FOREIGN KEY (subcategory_id) REFERENCES subcategory(subcategory_id),
    cf_id INT NOT NULL,
	FOREIGN KEY (cf_id) REFERENCES campaign(cf_id),
	PRIMARY KEY (subcategory_id, cf_id)
);

CREATE TABLE subcategory_category(
	subcategory_id VARCHAR(50) NOT NULL,
	FOREIGN KEY (subcategory_id) REFERENCES subcategory(subcategory_id),
    category_id VARCHAR(50) NOT NULL,
	FOREIGN KEY (category_id) REFERENCES category(category_id),
	PRIMARY KEY (subcategory_id, category_id)
);

INSERT INTO contact_campaign (contact_id, cf_id)
SELECT DISTINCT contact_id, cf_id
FROM campaign;

INSERT INTO category_campaign (category_id, cf_id)
SELECT DISTINCT category_id, cf_id
FROM campaign;

INSERT INTO subcategory_campaign (subcategory_id, cf_id)
SELECT DISTINCT subcategory_id, cf_id
FROM campaign;

INSERT INTO subcategory_category (subcategory_id, category_id)
SELECT subcategory.subcategory_id, category.category_id
FROM subcategory
JOIN (
SELECT DISTINCT subcategory_id, category_id
FROM campaign
) AS sub_cat
ON sub_cat.subcategory_id = subcategory.subcategory_id
JOIN category
ON sub_cat.category_id = category.category_id;

SELECT * FROM contact_campaign;

SELECT * FROM category_campaign;

SELECT * FROM subcategory_campaign;

SELECT * FROM subcategory_category;

ALTER TABLE campaign
DROP COLUMN category_id;

ALTER TABLE campaign
DROP COLUMN subcategory_id;


SELECT * FROM campaign;

ALTER TABLE campaign
DROP COLUMN contact_id;


SELECT * FROM campaign;

SELECT campaign.cf_id, subcategory.subcategory, category.category
FROM campaign
JOIN subcategory_campaign
ON campaign.cf_id = subcategory_campaign.cf_id
JOIN subcategory
ON subcategory_campaign.subcategory_id = subcategory.subcategory_id
JOIN subcategory_category
ON subcategory.subcategory_id = subcategory_category.subcategory_id
JOIN category
ON category.category_id = subcategory_category.category_id;

SELECT campaign.cf_id, subcategory.subcategory, category.category
FROM campaign
JOIN category_campaign
ON campaign.cf_id = category_campaign.cf_id
JOIN category
ON category_campaign.category_id = category.category_id
JOIN subcategory_category
ON category.category_id = subcategory_category.category_id
JOIN subcategory
ON subcategory.subcategory_id = subcategory_category.subcategory_id;

SELECT campaign.cf_id, contact.first_name, contact.last_name, contact.email
FROM campaign
JOIN contact_campaign
ON campaign.cf_id = contact_campaign.cf_id
JOIN contact
ON contact_campaign.contact_id = contact.contact_id;


SELECT  country, SUM(pledged) Sum_of_Pledges
FROM campaign
GROUP BY country
ORDER BY Sum_of_Pledges DESC;

SELECT  country, COUNT(outcome) Number_of_Successful_Campaigns
FROM campaign
WHERE outcome = 'successful'
GROUP BY country
ORDER BY Number_of_Successful_Campaigns DESC;


SELECT  country, COUNT(outcome) Number_of_Campaigns
FROM campaign
GROUP BY country
ORDER BY Number_of_Campaigns DESC;

SELECT 
num_camps.country, 
num_camps.Number_of_Campaigns, 
succ_camps.Number_of_Successful_Campaigns, 
100 * succ_camps.Number_of_Successful_Campaigns / num_camps.Number_of_Campaigns AS percent_successful_campaigns
FROM (SELECT  country, COUNT(outcome) Number_of_Campaigns
FROM campaign
GROUP BY country) AS num_camps
JOIN (SELECT  country, COUNT(outcome) Number_of_Successful_Campaigns
FROM campaign
WHERE outcome = 'successful'
GROUP BY country) AS succ_camps
ON num_camps.country = succ_camps.country
ORDER BY percent_successful_campaigns DESC;

