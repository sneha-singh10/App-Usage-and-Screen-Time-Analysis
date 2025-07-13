-- total rows
select count(*) from screen_time

-- select top 5 dataset
select TOP 5 * FROM screen_time

-- Total unique rows
select count(distinct user_id) from screen_time

-- user summary of 101 distinct user
WITH user_summary AS (
    SELECT
        user_id,
        SUM(screen_time_min) AS total_screen_time,
        SUM(launches) AS total_launches,
        SUM(interactions) AS total_interactions,
        COUNT(DISTINCT app_name) AS total_apps_used,
        SUM(CASE WHEN is_productive = 1 THEN 1 ELSE 0 END) AS productive_apps,
        SUM(CASE WHEN is_productive = 0 THEN 1 ELSE 0 END) AS non_productive_apps,
        ROUND(
            (SUM(CASE WHEN is_productive = 0 THEN screen_time_min ELSE 0 END) * 100.0) / 
            NULLIF(SUM(screen_time_min), 0), 2
        ) AS unproductivity_percent
    FROM screen_time
    GROUP BY user_id
)

SELECT * FROM user_summary;

-- overall unproductivity percentage
SELECT
  ROUND(
    (SUM(CASE WHEN is_productive = 0 THEN screen_time_min ELSE 0 END) * 100.0) / 
    NULLIF(SUM(screen_time_min), 0), 2
  ) AS unproductivity_percent
FROM screen_time;

