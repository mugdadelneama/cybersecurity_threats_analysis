-- Defense mechanism effectiveness


-- QUERY 1: MOST EFFECTIVE DEFENSE MECHANISMS (MAIN ANSWER)
-- Shows which security defenses work best (lowest average losses)
SELECT 
    ROW_NUMBER() OVER (ORDER BY AVG(financial_loss_million) ASC) as "Effectiveness Rank",
    defense_mechanism_used as "Defense System",
    COUNT(*) as "Times Used",
    CONCAT('$', ROUND(AVG(financial_loss_million), 1), ' Million') as "Average Loss When Used",
    CONCAT('$', ROUND(SUM(financial_loss_million), 1), ' Million') as "Total Losses When Used",
    ROUND(AVG(incident_resolution_hours), 0) as "Average Hours to Fix",
    CASE 
        WHEN AVG(financial_loss_million) < 30 THEN 'HIGHLY EFFECTIVE'
        WHEN AVG(financial_loss_million) < 50 THEN 'MODERATELY EFFECTIVE'
        WHEN AVG(financial_loss_million) < 70 THEN 'SOMEWHAT EFFECTIVE'
        ELSE 'LESS EFFECTIVE'
    END as "Effectiveness Level"
FROM global_cybersecurity_threats 
GROUP BY defense_mechanism_used
ORDER BY AVG(financial_loss_million) ASC;

-- QUERY 2: DEFENSE EFFECTIVENESS BY VULNERABILITY TYPE
-- Shows which defenses work best against each specific threat
SELECT 
    security_vulnerability_type as "Threat Type",
    defense_mechanism_used as "Defense Used",
    COUNT(*) as "Times This Combo Was Used",
    CONCAT('$', ROUND(AVG(financial_loss_million), 1), ' Million') as "Average Loss",
    ROUND(AVG(incident_resolution_hours), 0) as "Average Fix Time",
    FORMAT(ROUND(AVG(number_of_affected_users), 0), 0) as "Average Customers Affected",
    CASE 
        WHEN AVG(financial_loss_million) < 30 THEN '✅ WORKS WELL'
        WHEN AVG(financial_loss_million) < 60 THEN '⚠️ PARTIALLY EFFECTIVE'
        ELSE '❌ NOT VERY EFFECTIVE'
    END as "Defense Performance"
FROM global_cybersecurity_threats 
GROUP BY security_vulnerability_type, defense_mechanism_used
ORDER BY security_vulnerability_type, AVG(financial_loss_million) ASC;

-- QUERY 3: BEST DEFENSE FOR EACH VULNERABILITY TYPE
-- Shows the most effective defense against each threat
SELECT 
    security_vulnerability_type as "Threat Type",
    defense_mechanism_used as "Best Defense Against This Threat",
    CONCAT('$', ROUND(AVG(financial_loss_million), 1), ' Million') as "Average Loss When Using This Defense",
    COUNT(*) as "How Many Times We Tested This",
    ROUND(AVG(incident_resolution_hours), 0) as "Average Time to Fix",
    CASE 
        WHEN security_vulnerability_type = 'Unpatched Software' THEN 'Keep software updated to prevent exploitation'
        WHEN security_vulnerability_type = 'Zero-day' THEN 'Detect unknown threats in real-time'
        WHEN security_vulnerability_type = 'Social Engineering' THEN 'Protect against human manipulation'
        WHEN security_vulnerability_type = 'Weak Passwords' THEN 'Strengthen authentication systems'
        ELSE 'Primary defense strategy'
    END as "Why This Defense Works"
FROM global_cybersecurity_threats t1
WHERE financial_loss_million = (
    SELECT MIN(financial_loss_million) 
    FROM global_cybersecurity_threats t2 
    WHERE t2.security_vulnerability_type = t1.security_vulnerability_type
)
GROUP BY security_vulnerability_type, defense_mechanism_used
ORDER BY AVG(financial_loss_million) ASC;

-- QUERY 4: DEFENSE MECHANISM PERFORMANCE SCORECARD
-- Overall performance rating for each defense system
SELECT 
    defense_mechanism_used as "Defense System",
    COUNT(*) as "Total Uses",
    CONCAT('$', ROUND(AVG(financial_loss_million), 1), ' Million') as "Average Loss",
    ROUND(AVG(incident_resolution_hours), 0) as "Average Response Time",
    COUNT(DISTINCT security_vulnerability_type) as "Threats It Handles",
    COUNT(DISTINCT target_industry) as "Industries Using It",
    CASE 
        WHEN AVG(financial_loss_million) < 35 AND AVG(incident_resolution_hours) < 40 THEN 'A+ EXCELLENT'
        WHEN AVG(financial_loss_million) < 50 AND AVG(incident_resolution_hours) < 50 THEN 'B+ GOOD'
        WHEN AVG(financial_loss_million) < 65 THEN 'C AVERAGE'
        ELSE 'D NEEDS IMPROVEMENT'
    END as "Overall Grade",
    GROUP_CONCAT(DISTINCT security_vulnerability_type ORDER BY security_vulnerability_type) as "Vulnerabilities It Defends Against"
FROM global_cybersecurity_threats 
GROUP BY defense_mechanism_used
ORDER BY AVG(financial_loss_million) ASC, AVG(incident_resolution_hours) ASC;

-- QUERY 5: DEFENSE COST-EFFECTIVENESS ANALYSIS
-- Shows return on investment for each defense mechanism
SELECT 
    defense_mechanism_used as "Defense System",
    COUNT(*) as "Usage Frequency",
    CONCAT('$', ROUND(AVG(financial_loss_million), 1), ' Million') as "Average Loss Despite Defense",
    CONCAT('$', ROUND(MIN(financial_loss_million), 1), 'M - $', ROUND(MAX(financial_loss_million), 1), 'M') as "Loss Range",
    CASE 
        WHEN defense_mechanism_used = 'AI-based Detection' THEN 'Modern smart defense system'
        WHEN defense_mechanism_used = 'Encryption' THEN 'Data protection technology'
        WHEN defense_mechanism_used = 'Firewall' THEN 'Network barrier system'
        WHEN defense_mechanism_used = 'Antivirus' THEN 'Traditional malware protection'
        WHEN defense_mechanism_used = 'VPN' THEN 'Secure connection technology'
        ELSE 'Security technology'
    END as "Defense Type",
    CASE 
        WHEN AVG(financial_loss_million) < 40 THEN 'HIGH ROI - Worth investing in'
        WHEN AVG(financial_loss_million) < 60 THEN 'MODERATE ROI - Consider upgrading'
        ELSE 'LOW ROI - May need replacement'
    END as "Investment Recommendation"
FROM global_cybersecurity_threats 
GROUP BY defense_mechanism_used
ORDER BY AVG(financial_loss_million) ASC;

-- QUERY 6: INDUSTRY-SPECIFIC DEFENSE EFFECTIVENESS
-- Shows which defenses work best in each industry
SELECT 
    target_industry as "Industry",
    defense_mechanism_used as "Defense Used",
    COUNT(*) as "Times Used in This Industry",
    CONCAT('$', ROUND(AVG(financial_loss_million), 1), ' Million') as "Average Loss",
    ROUND(AVG(incident_resolution_hours), 0) as "Average Fix Time",
    CASE 
        WHEN AVG(financial_loss_million) < 35 THEN 'WORKS WELL IN THIS INDUSTRY'
        WHEN AVG(financial_loss_million) < 65 THEN 'MODERATELY EFFECTIVE'
        ELSE 'NOT VERY EFFECTIVE IN THIS INDUSTRY'
    END as "Industry-Specific Performance"
FROM global_cybersecurity_threats 
GROUP BY target_industry, defense_mechanism_used
ORDER BY target_industry, AVG(financial_loss_million) ASC;

-- QUERY 7: YEAR-OVER-YEAR DEFENSE PERFORMANCE
-- Shows how defense effectiveness changed over time
SELECT 
    defense_mechanism_used as "Defense System",
    year as "Year",
    COUNT(*) as "Uses That Year",
    CONCAT('$', ROUND(AVG(financial_loss_million), 1), ' Million') as "Average Loss That Year",
    CASE 
        WHEN year >= 2022 THEN 'Recent Performance'
        WHEN year >= 2019 THEN 'Mid-term Performance'
        ELSE 'Historical Performance'
    END as "Time Period"
FROM global_cybersecurity_threats 
GROUP BY defense_mechanism_used, year
ORDER BY defense_mechanism_used, year DESC;

-- QUERY 8: EXECUTIVE SUMMARY - DEFENSE EFFECTIVENESS OVERVIEW
-- Quick overview for management decisions
SELECT 
    'DEFENSE SYSTEM PERFORMANCE REPORT' as "Analysis Type",
    CONCAT((SELECT defense_mechanism_used 
            FROM global_cybersecurity_threats 
            GROUP BY defense_mechanism_used 
            ORDER BY AVG(financial_loss_million) ASC 
            LIMIT 1), 
           ' is most effective ($', 
           (SELECT ROUND(AVG(financial_loss_million), 1) 
            FROM global_cybersecurity_threats 
            GROUP BY defense_mechanism_used 
            ORDER BY AVG(financial_loss_million) ASC 
            LIMIT 1), 
           'M avg loss)') as "Best Performing Defense",
    CONCAT((SELECT defense_mechanism_used 
            FROM global_cybersecurity_threats 
            GROUP BY defense_mechanism_used 
            ORDER BY AVG(financial_loss_million) DESC 
            LIMIT 1), 
           ' needs improvement ($', 
           (SELECT ROUND(AVG(financial_loss_million), 1) 
            FROM global_cybersecurity_threats 
            GROUP BY defense_mechanism_used 
            ORDER BY AVG(financial_loss_million) DESC 
            LIMIT 1), 
           'M avg loss)') as "Least Effective Defense",
    CONCAT('$', ROUND(AVG(financial_loss_million), 1), ' Million') as "Overall Average Loss Across All Defenses",
    'Focus investment on AI-based detection and encryption systems' as "Strategic Recommendation"
FROM global_cybersecurity_threats;
