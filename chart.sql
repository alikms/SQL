WITH cte (name,id,managerid,managers) as
(SELECT h1.name,h1.id,h1.managerid,CAST(concat(h1.manager,'/',h2.manager)AS VARCHAR(150)) 
FROM  human_chart AS H1 INNER JOIN human_chart AS H2 ON H1.managerid=h2.id 
UNION ALL
SELECT c.name,c.id,p.managerid,CAST(concat(c.name,'/',p.managers)AS VARCHAR(150))
FROM human_chart AS C INNER JOIN cte AS P ON c.managerid=p.id)
SELECT cte.name,cte.id,cte.managerid,cte.managers,len(cte.managers)-len(replace(cte.managers,'/',''))+1as lvl 
FROM human_chart AS H RIGHT OUTER JOIN cte ON cte.managerid=h.id
WHERE cte.managerid =1 OR cte.managerid=2

UNION ALL
SELECT name,id,managerid,manager,1 FROM human_chart WHERE managerid IS NULL
ORDER BY 2






