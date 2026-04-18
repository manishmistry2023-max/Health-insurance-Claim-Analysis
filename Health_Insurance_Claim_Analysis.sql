create database Health_Insurance_Claim;

Use Health_Insurance_Claim;

select * from Health_Insurance_Claim


1.'What is the total number of claims?'

select Count(*)As Total_Claim
from Health_Insurance_Claim;

2.'What is the total claim amount paid by the insurance company?'

select Round(Sum(total_claim_Amount),2)As Total_Claim 
	from Health_Insurance_Claim;

3.'What is the average claim amount per customer?'

select Round(Avg(Total_Claim_Amount),2)As Avg_Claim_per_Customer
	from Health_Insurance_Claim;

4.'What is the average hospitalization cost'

select Round(Avg(Hospital_Bill_Amount),2)As Avg_Hospitalization_Cost
from Health_Insurance_Claim;

5.'What is the total out-of-pocket expense paid by customers?'

Select round(Sum(Non_Payable_Items+Deductible_Amount+Co_Pay_Amount),2)As Out_of_Pocket from Health_Insurance_Claim;

6.'Which Policy type claims have the highest total cost?'

select policy_type,round(sum(Total_Claim_Amount),2)As Highest_Claim_Amount from Health_Insurance_Claim
Group by policy_type
order by Highest_Claim_Amount desc
limit 1


7.'Which expense type contributes most:

* Pre-hospitalization
* Post-hospitalization
* Hospital bill'

Select 'Hospital bill' As Expense_type,round(Sum(Hospital_Bill_Amount),2)As Expernse_Amount from Health_Insurance_Claim
Union all
Select 'Pre-hospitalization' As Expense_type,round(Sum(Pre_Hospitalization_Expense),2)As Expernse_Amount from Health_Insurance_Claim
Union all
Select 'Post-hospitalization' As Expense_type,round(Sum(Post_Hospitalization_Expense),2)As Expernse_Amount from Health_Insurance_Claim

8.'Which age group claims the most claim amount?'

Select
(Case when Age>=0 and age <=20 then "0-20"
		when Age>20 and age <=40 then"21-40"
        when Age>40 and age <=60 then"41-60"
		else "Above 60"end ) As Age_Category,Count(Total_claim_amount)as Policy_Holder,
round(Sum(Total_Claim_Amount),2) As Claim_Amount From Health_Insurance_Claim
Group by Age_Category
order by age_category asc

9.'what is the avaerage treatment cost per person'.

Select round(avg(Hospital_Bill_Amount+Pre_Hospitalization_Expense+Post_Hospitalization_Expense),2) AS avg_Treatment_cost
	from health_insurance_claim

10.'what is the Health insurance claim ratio?'

With Total_Cost as
(
Select Sum(Hospital_Bill_Amount+Pre_Hospitalization_Expense+Post_Hospitalization_Expense) AS Hospital_Cost,
	Sum(Total_Claim_Amount) as Claim_Amount from health_insurance_claim
    )
    
    Select round(Claim_Amount/Hospital_Cost*100,2) as claim_ratio from Total_Cost
    
    
    11.'Find top 10 hospitals name with high claim ratio'
    
With Claim as
(
Select Hospital_Name,Sum(Hospital_Bill_Amount+Pre_Hospitalization_Expense+Post_Hospitalization_Expense) AS Total_Treatment_cost,
	Sum(Total_Claim_Amount) as Insurance_Claim_Amount from health_insurance_claim
    group by Hospital_Name
    )
    
    Select Hospital_Name,round(Insurance_Claim_Amount/Total_Treatment_cost*100,2) as claim_ratio from Claim
    having claim_ratio >100
    Order by claim_ratio Desc
    limit 10
    
    12.'How the claim is trend by the year'
    
    SELECT 
    YEAR(STR_TO_DATE(Claim_Date, '%d-%m-%Y')) AS yr,round(sum(Total_Claim_Amount),2)As Claim
FROM health_insurance_claim
  group by yr
Order by yr 

13.'what is the Avearge out of pocket expense per customer'?

Select round(avg(Non_Payable_Items+Deductible_Amount+Co_Pay_Amount),2)As Avg_Out_of_Pocket 
from Health_Insurance_Claim;

14.'what is the average treatment cost per customer?'

Select round(avg(Hospital_Bill_Amount+Pre_Hospitalization_Expense+Post_Hospitalization_Expense),2)As Avg_Treatment_cost
 from Health_Insurance_Claim;
 
 15.'which city is claim highest claim amount ?'
  
Select City,Round(Sum(total_claim_Amount),2) As Total_Claim
From Health_Insurance_Claim
Group by City
Order by Total_Claim Desc
 
16.'which BMI Categories are show highest Claim Amount?'

	Select
    (CASE WHEN BMI<18 THEN "UnderWeight"
			WHEN BMI>=18 AND BMI <25 THEN "Normal"
            when BMI >=25 AND BMI <30 THEN "Overweight"
            when BMI >=30 THEN "Obese" end) as BMI_Category,
            Round(Sum(total_claim_amount),2) As Total_Claim
    from Health_Insurance_Claim
    Group by BMI_Category
    Order by Total_Claim desc
    
    17.'Which income level category obtain highest claim Amount?'
    
    Select
    (Case when Annual_Income_Inr<500000 then "Low_level_Income"
		when Annual_Income_Inr>=500000 and Annual_Income_Inr<1000000 then "Middle_level_Income"
        when Annual_Income_Inr>=1000000 then "High_level_Income" end)as Income_Level_Category,
    round(sum(total_claim_amount),2) as Total_Claim 
		from Health_Insurance_Claim
    Group by Income_Level_Category
    
    18.'which type of Tobacco users claim highest Claim'
    
    Select tobacco_Usage,ROUND(Sum(total_claim_amount),2)as total_claim from
    Health_Insurance_Claim
    
    Group by tobacco_Usage
    
    20.'Find top 20 customer who claimed highest claim Insurance amount'.
    
    Select Customer_Name,round(Sum(Total_claim_Amount),2)As Total_Claim from Health_Insurance_Claim
    Group by Customer_Name
	Order by Total_Claim desc
    Limit 20
    
    21.'How much the average claim amounts would have under the hospital tier?'
    
    Select Hospital_tier, Round(Avg(Total_Claim_Amount),2)as Avg_Claim_Amount from Health_Insurance_Claim
    Group by Hospital_tier
    Order by Avg_Claim_Amount Desc
    
    22.'How Much amounts of claim have Claimed under the Cashless Service.?'
    
    Select 
    (Case when Cashless_Claim="Yes" then "Cashless" else "Non-Cashless" end) Payment_Category,
    Round(Sum(Total_Claim_Amount),2)as Payment_Amount 
    from Health_Insurance_Claim
    Group by Payment_Category
    
    24.'Which agent channel is most preferred policy Purchase?'
    
    Select Agent_Channel, Count(policy_id) As total_Policy_Purchase
From Health_Insurance_Claim
GROUP BY Agent_Channel
Order by total_Policy_Purchase Desc
   
   
   