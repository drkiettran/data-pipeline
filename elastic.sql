#
# Examples extracted from `https://www.elastic.co/blog/an-introduction-to-elasticsearch-sql-with-practical-examples-part-1` website
#

POST _sql
{
  "query":"DESCRIBE kibana_sample_data_flights"
}


POST _sql?format=txt
{
  "query":"DESCRIBE kibana_sample_data_flights"
}

POST _sql?format=txt 
{
  "query": "SELECT * from kibana_sample_data_flights"
}

POST _sql?format=txt 
{ 
  "query": "show tables"
}

# Column name is `case sensitive`

POST _sql?format=txt
{
  "query": "SELECT FlightNum from kibana_sample_data_flights limit 1"  
}

POST _sql?format=txt
{
  "query": "SELECT OriginCountry, OriginCityName from kibana_sample_data_flights limit 1"  
}

POST _xpack/sql?format=txt
{
  "query":"SELECT OriginCityName, DestCityName FROM kibana_sample_data_flights WHERE FlightTimeHour > 5 AND OriginCountry='US' ORDER BY FlightTimeHour DESC LIMIT 10"
}


POST _xpack/sql?format=txt
{
  "query":"SELECT MONTH_OF_YEAR(timestamp), OriginCityName, DestCityName FROM kibana_sample_data_flights WHERE FlightTimeHour > 5 AND MONTH_OF_YEAR(timestamp) > 6 ORDER BY FlightTimeHour DESC LIMIT 10"
}


POST _sql?format=txt
{
  "query":"SELECT timestamp, FlightNum, AvgTicketPrice FROM kibana_sample_data_flights WHERE AvgTicketPrice > 500 ORDER BY AvgTicketPrice"
}

# Translate to DSL from SQL. This helps elasticsearch user in understanding the actual query itself
# The `WHERE` clause is expressed `range` and `term` keys.

POST _sql/translate
{
  "query":"SELECT OriginCityName, DestCityName FROM kibana_sample_data_flights WHERE FlightTimeHour > 5 AND OriginCountry='US' ORDER BY FlightTimeHour DESC LIMIT 10"
}

# POST _sql/translate
POST _sql?format=txt
{
  "query":"SELECT timestamp, FlightNum, OriginCityName, DestCityName, ROUND(DistanceMiles) AS distance, ROUND(DistanceMiles/CAST(FlightTimeHour as float)) AS speed, DAY_OF_WEEK(timestamp) AS day_of_week FROM kibana_sample_data_flights WHERE DAY_OF_WEEK(timestamp) >= 0 AND DAY_OF_WEEK(timestamp) <= 2 AND HOUR_OF_DAY(timestamp) >=9 AND HOUR_OF_DAY(timestamp) <= 10 ORDER BY speed DESC, distance DESC LIMIT 2"
}