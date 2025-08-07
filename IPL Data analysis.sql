-- create Database IPL;
-- 1. Which team won the most matches in IPL ?

select winner , count(winner) as total_win
from `ipl - ipl`
group by winner
order by count(winner) desc;

-- 2. Which player won the most 'Player of the Match' awards?

select player_of_match, count(player_of_match) as number_of_player_of_the_match
from `ipl - ipl`
group by player_of_match
order by number_of_player_of_the_match desc limit 5;

-- 3. Which city hosted the most matches?

select city , count(city) as total_game
from `ipl - ipl`
group by city
order by total_game desc limit 5;

-- 4. What was the highest win by runs (defending)? Which team achieved it?

select winner, result_margin
from `ipl - ipl`
where result = "runs"
order by result_margin desc limit 5;

-- 5. What was the highest win by wickets (chasing)? Which team achieved it?

select winner, result_margin
from `ipl - ipl`
where result = "wickets"
order by result_margin desc; 

-- 6. . How many matches were won by teams that won the toss?

select winner, count(*) as win
from `ipl - ipl`
where winner = toss_winner
group by winner
order by count(*) desc;

-- 7. How many matches were decided by runs vs wickets?

select result, count(*)
from `ipl - ipl`
group by result 
order by count(*) desc;

-- 8. Which venues hosted the most matches?

select venue, count(*) as total
from `ipl - ipl`
group by venue
order by total desc limit 5;

-- 9. How many matches did each team win? (Including both team1 and team2)

select winner, count(*) as total
from `ipl - ipl`
group by winner
order by total desc;

-- 10. Which toss decision (bat/field) led to more wins?

select toss_decision , count(*)
from `ipl - ipl`
where toss_winner = winner
group by toss_decision
order by count(*) desc;

-- 11. List all matches where the team won by more than 50 runs.

select *
from `ipl - ipl`
where result_margin > 50 and result = 'runs';

-- 12. List all matches that ended with a 1-run or 1-wicket victory (nail-biters).

select *
from `ipl - ipl`
where result_margin = 1;

-- 13. . Get the number of matches each team played (as team1 or team2).

select team ,  count(*) as match_played
from (
select team1 as team from `ipl - ipl`
UNION ALL
select team2 as team from `ipl - ipl`) as all_team
group by team 
order by match_played desc;

-- 14. Which team won the most matches after choosing to bat first?

select winner, count(*)
from `ipl - ipl`
where toss_decision = 'bat' and toss_winner = winner
group by winner
order by count(*) desc;

-- 15. What percentage of toss-winning teams also won the match?

select (select count(*) from `ipl - ipl` where toss_winner = winner) * 100 / (select count(*) from `ipl - ipl`) as toss_win_match_win_percentage;

-- 16. List the matches with no margin (tie or no result).

select distinct result
from `ipl - ipl` 
where result IS NULL;
-- 17. . Top 5 players with the most ‘Player of the Match’ awards.

select player_of_match, count(*)
from `ipl - ipl`
group by player_of_match
order by count(*) desc limit 5;

-- 18. Compare the number of wins for each team when batting first vs. chasing.

select winner,
count(case when result = 'runs' then 1 END ) as batting_first,
count(case when result = 'wickets' then 1 END) as chasing
from `ipl - ipl`
group by winner;




-- 19. Which team won the most matches at a specific venue (e.g., Mumbai)?
with sales as (
select winner, venue, count(*),
Rank() over(partition by venue order by count(*) desc) as number
from `ipl - ipl`
group by venue, winner
order by count(*) desc )


select * from sales
where number = 1;


