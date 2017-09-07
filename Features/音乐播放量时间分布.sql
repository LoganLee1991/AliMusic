drop table test_song_featureV2;

create table test_song_featureV2
select * from 
(Select * FROM AliMusic.song_featuresV2
order by rand()
limit 5000) as temp
order by artist_id,play_time_d,play_time_h;

update test_song_featureV2 set weekday=(weekday+1);

select * from test_song_featureV2;

select artist_id, weekday, play_time_h, sum(num_play) as totalPlay
from AliMusic.song_featuresV2
group by artist_id,weekday,play_time_h
order by artist_id,weekday,play_time_h
