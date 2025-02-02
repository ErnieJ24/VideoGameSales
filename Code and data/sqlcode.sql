--Database source https://www.kaggle.com/datasets/gregorut/videogamesales 
--Here are the questions I came up with to figure out the data I was looking for in this dataset


  -- Full Dataset View--
      select * 
        from vgsales
      order by  year desc;


  --Found out the Highest earning game Globally from 1980 - 2020?--

    select Name, SUM(Global_Sales) as Global_sales
        from vgsales
        where Year between 1980 and 2020;

  --Which Platform had more games released in 2005?--

    select platform, COUNT(name) as total_games_released
        from vgsales
        where year = 2005
    Group by platform
    order by total_games_released desc
        LIMIT 1;

  --What were the total sales in North America from 2005 - 2009?--

    select SUM(NA_Sales)
        from vgsales
        where year between 2005 and 2009;

  --What were the total sales Globally in 2010?--

    select Year, SUM(NA_Sales) as NA_Sales, SUM(EU_Sales) as EU_Sales, SUM(JP_Sales) as JP_Sales, SUM(Other_sales) as Other_Sales, SUM(Global_Sales) as Global_Sales
        from vgsales
        where year = 2010;

  --What genres had the least sales Globally in year 2000 and who were the publishers?--

    select Genre, MIN(Global_Sales) as Global_Sales, Publisher
        from vgsales
        where Year= 2000
    group by Genre
    order by Global_Sales asc
        LIMIT 3;

  --Which year had the most action games released--

    select Year, COUNT(Genre) as Genres_released
        from vgsales
        where genre = 'Action' 
        AND Year <> 'N/A'
    Group by year
    order by Genres_released desc
        LIMIT 1;

  --What are the top 10 games that sold in North america?--
  --Had to clean up some data here--

    select distinct name
        from vgsales
    group by name
        HAVING MAX(NA_Sales) REGEXP '^[0-9]+(\.[0-9]+)?$' 
        AND NA_Sales <> 2008 
        AND NA_Sales <> 2007
    order by NA_Sales desc
    LIMIT 10;


  --Which publisher had the lowest games released in 2016 in North America?--
  --I listed multiple publishers since they all had only 1 game released in 2016--

    select publisher
        from vgsales
        where Year = 2016 
    group by publisher
        HAVING COUNT(name) = 1;
    

  --What were the top 3 publishers in 2016 with the most Europe sales--

    select publisher
        from vgsales
    group by publisher
        HAVING MAX(EU_Sales) 
        AND Year = 2016
    order by MAX(EU_Sales) desc
        LIMIT 3;

  --What was the most popular platform in 2005? and how many games did they release in that platform?--

    select platform, COUNT(name) as Released_games
        from vgsales
        where Year = 2005
    group by Platform
    order by  Released_games desc
        LIMIT 1;
