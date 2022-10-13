
--the ranking of listing price for the boat
select *, RANK() OVER(ORDER BY [Price in US Dollar] DESC) AS Rank
from boat_data..boat_data$
Order by Rank

--the ranking of number of views in last 7 days
select *, RANK() OVER(ORDER BY [Number of views last 7 days] DESC) AS Rank
from boat_data..boat_data$
ORDER BY Rank

--to find out what are the boat type has the top 50 highest number of views in last 7 days
select COUNT([Boat Type]) AS num_boattype, [Boat Type]
from (select TOP 50 *
from boat_data..boat_data$
ORDER BY [Number of views last 7 days] DESC) AS sub
GROUP BY [Boat Type]
ORDER BY num_boattype DESC

-- to find out what are the location has the top 50 highest number of views in last 7 days
select COUNT([Location]) AS num_location, [Location]
from (select TOP 50 *
from boat_data..boat_data$
ORDER BY [Number of views last 7 days] DESC) AS sub1
GROUP BY [Location]
ORDER BY num_location DESC

--to find out what are the condition of boat has the top 50 highest number of views in last 7 days
select COUNT([Type]) AS num_boatcondition, [Type]
from (select TOP 50 *
from boat_data..boat_data$
ORDER BY [Number of views last 7 days] DESC) AS sub2
GROUP BY [Type]
ORDER BY num_boatcondition DESC

----to find out what are the years of boat has the top 50 highest number of views in last 7 days
select COUNT([Year Built]) AS num_yearbuilt, [Year Built]
from (select TOP 50 *
from boat_data..boat_data$
ORDER BY [Number of views last 7 days] DESC) AS sub3
GROUP BY [Year Built]
ORDER BY num_yearbuilt DESC

--average number of views in last 7 days in each boat type
select [Boat Type], AVG([Number of views last 7 days]) AS avg_numviews
from boat_data..boat_data$
GROUP BY [Boat Type]
ORDER BY avg_numviews DESC

--sum number of views in last 7 days in each boat type
select [Boat Type], SUM([Number of views last 7 days]) AS sum_numviews
from boat_data..boat_data$
GROUP BY [Boat Type]
ORDER BY sum_numviews DESC

--seperate each price into different caegory
select *,
CASE WHEN [Price in US Dollar] < 50000 THEN 'Cheap'
	WHEN [Price in US Dollar] < 110000 THEN 'Average'
	WHEN [Price in US Dollar] < 290000 THEN 'Expensive'
	ELSE 'Very Expensive' END AS price_category
from boat_data..boat_data$

Update boat_data..boat_data$
SET [Year Built] = 2022
From boat_data..boat_data$
Where [Year Built] = 0

--Count each boat type
Select [Boat Type], COUNT([Boat Type])
From boat_data..boat_data$
GROUP BY [Boat Type]

-- count the price_category
select COUNT(price_category) AS num_pricecategory, price_category
from (select *,
CASE WHEN [Price in US Dollar] < 50000 THEN 'Cheap'
	WHEN [Price in US Dollar] < 110000 THEN 'Average'
	WHEN [Price in US Dollar] < 290000 THEN 'Expensive'
	ELSE 'Very Expensive' END AS price_category
from boat_data..boat_data$) AS sub6
Group By price_category
Order By num_pricecategory

--Count all features for the boat
select [Boat Type], [Manufacturer], [Type], [Year Built], [Location], COUNT(*) AS total_same_type_boat
from boat_data..boat_data$
group by [Boat Type], [Manufacturer], [Type], [Year Built], [Location]
order by total_same_type_boat DESC

--total views for each group of feature, average of views for each group of feature
select [Boat Type], [Manufacturer], [Type], [Year Built], [Location], total_views_for_groups, ROUND(avg_views_for_each, 2) AS avg_views_for_each
from (select [Boat Type], [Manufacturer], [Type], [Year Built], [Location], COUNT(*) AS total_same_type_boat, SUM([Number of views last 7 days]) AS total_views_for_groups, AVG([Number of views last 7 days]) AS avg_views_for_each
from boat_data..boat_data$
group by [Boat Type], [Manufacturer], [Type], [Year Built], [Location]) AS sub3
ORDER by total_views_for_groups DESC
