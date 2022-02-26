-- Heaviest hitters: team with the highest average weight of its batters on a given year
WITH previous_query AS (
  SELECT batting.*, people.weight AS player_weight, teams.name AS team_name FROM batting
  LEFT JOIN people ON batting.playerid = people.playerid
  LEFT JOIN teams ON batting.team_id = teams.id
  )
SELECT team_name, yearid, AVG(player_weight) AS avg_weight FROM previous_query
GROUP BY team_name, yearid
ORDER BY avg_weight DESC;

-- Shortest slugers: team with the smallest average height of its batters on a given year
WITH previous_query AS (
  SELECT batting.*, people.height AS player_height, teams.name AS team_name FROM batting
  LEFT JOIN people ON batting.playerid = people.playerid
  LEFT JOIN teams ON batting.team_id = teams.id
  )
SELECT team_name, yearid, AVG(player_height) AS avg_height FROM previous_query
GROUP BY team_name, yearid
ORDER BY avg_height ASC;

-- Biggest spenders: team with the largest total salary of all players in a given year
WITH previous_query AS (
  SELECT salaries.*, teams.name AS team_name FROM salaries
  LEFT JOIN teams ON salaries.team_id = teams.id
  )
SELECT team_name, yearid, SUM(salary) AS salary FROM previous_query
GROUP BY team_name, yearid
ORDER BY salary DESC;

-- Bang for buck in 2010: smallest cost per win (total team salary/number of wins) in 2010
WITH previous_query AS (
  SELECT salaries.*, teams.name AS team_name, teams.w AS number_of_wins FROM salaries
  LEFT JOIN teams ON salaries.team_id = teams.id
  )
SELECT team_name, yearid, SUM(salary) AS total_salary, SUM(salary) / number_of_wins AS cost_per_win FROM previous_query
GROUP BY team_name, yearid, number_of_wins HAVING yearid = 2010
ORDER BY cost_per_win ASC;

-- Priciest starter: pitcher who cost the most money per game in which they were the starting pitcher for at least 10 games
SELECT pitching.*, salaries.salary, salaries.salary/pitching.gs AS price_per_game FROM pitching
LEFT JOIN salaries ON pitching.playerid = salaries.playerid AND pitching.yearid = salaries.yearid AND pitching.team_id = salaries.team_id
WHERE pitching.gs >= 10 AND salaries.salary != 0
ORDER BY price_per_game DESC;