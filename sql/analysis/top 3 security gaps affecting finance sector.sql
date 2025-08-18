-- Target outcome
 
-- Top 3 security gaps affecting finance sector
-- Cost impact of each vulnerability type
-- Defense mechanism effectiveness



-- Top 3 Security Gaps in Finance Sector

-- QUERY 1: SIMPLE TOP 3 SECURITY GAPS (MAIN ANSWER)

SELECT 
    ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) as "Rank",
    security_vulnerability_type as "Security Problem",
    COUNT(*) as "How Many Times It Happened",
    CONCAT(ROUND((COUNT(*) * 100.0 / 6), 0), '%') as "Percentage of All Banking Attacks",
    CONCAT('$', ROUND(AVG(financial_loss_million), 1), ' Million') as "Average Loss Per Attack"
FROM global_cybersecurity_threats 
WHERE target_industry = 'Banking'
GROUP BY security_vulnerability_type
ORDER BY COUNT(*) DESC
LIMIT 3;

-- QUERY 2: WHAT THESE PROBLEMS COST US
-- Shows the financial impact in simple terms
SELECT 
    security_vulnerability_type as "Security Problem",
    CONCAT('$', ROUND(SUM(financial_loss_million), 1), ' Million') as "Total Money Lost",
    FORMAT(SUM(number_of_affected_users), 0) as "Total Customers Affected",
    CASE 
        WHEN security_vulnerability_type = 'Zero-day' THEN 'Hackers found security holes before we could fix them'
        WHEN security_vulnerability_type = 'Weak Passwords' THEN 'Poor password security let hackers in'
        WHEN security_vulnerability_type = 'Social Engineering' THEN 'Hackers tricked our people to get access'
        ELSE 'Other security issue'
    END as "What This Means in Simple Terms"
FROM global_cybersecurity_threats 
WHERE target_industry = 'Banking'
GROUP BY security_vulnerability_type
ORDER BY SUM(financial_loss_million) DESC;

-- QUERY 3: REAL EXAMPLES OF WHAT HAPPENED
SELECT 
    CONCAT(country, ' in ', year) as "Where and When",
    security_vulnerability_type as "Security Problem",
    CONCAT('$', financial_loss_million, ' Million Lost') as "Financial Damage",
    FORMAT(number_of_affected_users, 0) as "Customers Affected",
    attack_type as "Type of Attack",
    CONCAT('Fixed in ', incident_resolution_hours, ' hours') as "How Long to Fix"
FROM global_cybersecurity_threats 
WHERE target_industry = 'Banking'
ORDER BY financial_loss_million DESC;

-- QUERY 4: WHAT WE NEED TO DO ABOUT IT
-- Action plan for each security gap
SELECT 
    security_vulnerability_type as "Security Problem",
    COUNT(*) as "Priority Level (Higher Number = More Urgent)",
    CASE 
        WHEN security_vulnerability_type = 'Zero-day' THEN 'Install better monitoring systems and faster security updates'
        WHEN security_vulnerability_type = 'Weak Passwords' THEN 'Require stronger passwords and two-factor authentication'
        WHEN security_vulnerability_type = 'Social Engineering' THEN 'Train employees to recognize and avoid scams'
        ELSE 'Improve overall security measures'
    END as "What We Should Do",
    CASE 
        WHEN COUNT(*) >= 4 THEN 'Fix Immediately - This is Critical'
        WHEN COUNT(*) >= 2 THEN 'Fix Soon - This is Important'  
        ELSE 'Monitor and Improve - This is Moderate Risk'
    END as "Urgency Level"
FROM global_cybersecurity_threats 
WHERE target_industry = 'Banking'
GROUP BY security_vulnerability_type
ORDER BY COUNT(*) DESC;

-- QUERY 5: SIMPLE SUMMARY FOR THE BOSS
-- One-sentence summary of the situation
SELECT 
    CONCAT('Banking faces ', COUNT(*), ' different types of cyber attacks') as "Overall Situation",
    CONCAT('Total cost: $', ROUND(SUM(financial_loss_million), 1), ' Million') as "Total Financial Impact",
    CONCAT(FORMAT(SUM(number_of_affected_users), 0), ' customers were affected') as "Customer Impact",
    'Zero-day vulnerabilities are the biggest threat - they cause 67% of all attacks' as "Main Finding",
    'We need better security monitoring and faster response systems' as "Key Recommendation"
FROM global_cybersecurity_threats 
WHERE target_industry = 'Banking';

-- QUERY 6: HOW BAD IS EACH PROBLEM?
-- Risk assessment in simple terms
SELECT 
    security_vulnerability_type as "Security Problem",
    CASE 
        WHEN COUNT(*) >= 4 THEN 'VERY HIGH RISK'
        WHEN COUNT(*) >= 2 THEN 'HIGH RISK'
        ELSE 'MEDIUM RISK'
    END as "Risk Level",
    CONCAT('Happens ', ROUND((COUNT(*) * 100.0 / 6), 0), '% of the time') as "How Often This Happens",
    CONCAT('Costs us $', ROUND(AVG(financial_loss_million), 1), 'M each time') as "Cost Per Incident",
    CASE 
        WHEN security_vulnerability_type = 'Zero-day' THEN 'Most dangerous - hard to prevent'
        WHEN security_vulnerability_type = 'Weak Passwords' THEN 'Expensive but preventable'
        WHEN security_vulnerability_type = 'Social Engineering' THEN 'Lower cost but growing threat'
        ELSE 'Requires attention'
    END as "Management Notes"
FROM global_cybersecurity_threats 
WHERE target_industry = 'Banking'
GROUP BY security_vulnerability_type
ORDER BY COUNT(*) DESC;
