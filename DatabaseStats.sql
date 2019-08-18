SELECT t.name AS TableName
     , i.name AS IndexName
	 , p.[Rows]
	 , SUM(a.total_pages) AS TotalPages
	 , SUM(a.used_pages) AS UsedPages
	 , SUM(a.data_pages) AS DataPages
	 , ( SUM(a.total_pages) * 8) / 1024 as TotalSpaceMB
	 , ( SUM(a.used_pages) * 8) / 1024 as UsedSpaceMB
	 , ( SUM(a.data_pages) * 8) / 1024 as DataSpaceMB
  FROM sys.tables t
  INNER JOIN sys.indexes i ON t.object_id = i.object_id
  INNER JOIN sys.partitions p ON i.object_id = p.object_id AND i.index_id = p.index_id
  INNER JOIN sys.allocation_units a ON p.partition_id = a.container_id
  GROUP BY t.name, i.object_id, i.index_id, i.name, p.[Rows]
  ORDER BY OBJECT_NAME(i.object_id)
