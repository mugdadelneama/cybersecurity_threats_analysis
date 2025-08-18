select * from global_cybersecurity_threats;

-- The dataset is already clean, with no duplicates, null values, or blank fields.
-- First, the column names need to be changed, as they might cause errors during the analysis. 

ALTER TABLE global_cybersecurity_threats 
CHANGE `Security Vulnerability Type` security_vulnerability_type VARCHAR(100);

ALTER TABLE global_cybersecurity_threats 
CHANGE `Target Industry` target_industry VARCHAR(50);

ALTER TABLE global_cybersecurity_threats 
CHANGE `Financial Loss (in Million $)` financial_loss_million DECIMAL(10,2);

ALTER TABLE global_cybersecurity_threats 
CHANGE `Number of Affected Users` number_of_affected_users INT;

ALTER TABLE global_cybersecurity_threats 
CHANGE `Attack Source` attack_source VARCHAR(50);

ALTER TABLE global_cybersecurity_threats 
CHANGE `Attack Type` attack_type VARCHAR(50);

ALTER TABLE global_cybersecurity_threats 
CHANGE `Defense Mechanism Used` defense_mechanism_used VARCHAR(50);

ALTER TABLE global_cybersecurity_threats 
CHANGE `Incident Resolution Time (in Hours)` incident_resolution_hours INT;

ALTER TABLE global_cybersecurity_threats 
CHANGE `Year` `year` INT; 

ALTER TABLE global_cybersecurity_threats 
CHANGE Country country VARCHAR(50);   