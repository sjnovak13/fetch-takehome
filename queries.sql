/*
Second: Write queries that directly answer predetermined questions from a business stakeholder
Write SQL queries against your new structured relational data model that answer at least two of the following bullet points below of your choosing. Commit them to the git repository along with the rest of the exercise.

Note: When creating your data model be mindful of the other requests being made by the business stakeholder. If you can capture more than two bullet points in your model while keeping it clean, efficient, and performant, that benefits you as well as your team.
*/

-- What are the top 5 brands by receipts scanned for most recent month?
select 
    b.brand_name, 
    COUNT(r.receipt_id) AS receipt_count
from receipt r
left join purchases p on r.receipt_id = p.receipt_id
left join brand b ON p.brand_id = b.brand_id
where month(r.date_scanned) = month(add_months(current_date, -1)) 
group by b.brand_name
order by receipt_count desc
limit 5;

-- How does the ranking of the top 5 brands by receipts scanned for the recent month compare to the ranking for the previous month?
select 
    b.brand_name, 
    COUNT(r.receipt_id) AS receipt_count,
    month(r.date_scanned) AS month_scanned
from receipt r
left join purchases p on r.receipt_id = p.receipt_id
left join brand b ON p.brand_id = b.brand_id
group by b.brand_name
order by month_scanned, receipt_count desc
limit 5;

-- When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
select avg(total_spent) as average_spend
    , rewards_receipt_status
from receipt
where rewards_receipt_status in ('Accepted', 'Rejected')
group by rewards_receipt_status
order by average_spend desc;

-- When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?
select sum(p.purchase_item_count) as total_items_purchased
    , r.rewards_receipt_status
from receipt r
left join purchases p on r.receipt_id = p.receipt_id
where r.rewards_receipt_status in ('Accepted', 'Rejected')
group by r.rewards_receipt_status
order by total_items_purchased desc;

-- Which brand has the most spend among users who were created within the past 6 months?
with recent_users as (
    select user_id
    from user
    where month(created_date) > month(add_months(current_date, -6)) 
)
select 
    b.brand_name, 
    sum(r.total_spent) AS total_spend
from receipt r
join recent_users u on r.user_id = u.user_id
left join purchases p on r.receipt_id = p.receipt_id
left join brand b ON p.brand_id = b.brand_id
group by b.brand_name
order by total_spend desc
limit 1;

-- Which brand has the most transactions among users who were created within the past 6 months?
with recent_users as (
    select user_id
    from user
    where month(created_date) > month(add_months(current_date, -6)) 
)
select 
    b.brand_name, 
    count(r.receipt_id) AS total_transactions
from receipt r
join recent_users u on r.user_id = u.user_id
left join purchases p on r.receipt_id = p.receipt_id
left join brand b ON p.brand_id = b.brand_id
group by b.brand_name
order by total_transactions desc
limit 1;

