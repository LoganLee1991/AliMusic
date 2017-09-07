drop table test_user_actions;
create table test_user_actions select * from
    user_actions
where
    record_day between '2015-3-15' and '2015-3-17'#15/16/17 三天的数据
limit 5000 ;

select 
    sf.song_id,
    songs.artist_id,
    sf.play_time_d,
	sf.play_time_h,
    sf.num_play,
    sf.num_download,
    sf.num_collect,
    sf.weekday,
    songs.gender,
    songs.init_play,
    songs.lang
from
    (SELECT 
        song_id,
            sum(case
                when action = 1 then 1
                else 0
            end) as num_play,
            sum(case
                when action = 2 then 1
                else 0
            end) as num_download,
            sum(case
                when action = 3 then 1
                else 0
            end) as num_collect,
            play_time_d,
			play_time_h,
            weekday(play_time_d) + 1 as weekday,
            unixtime
    FROM
        AliMusic.test_user_actions
    group by song_id , record_day
    order by song_id , record_day) as sf
        join
    songs ON sf.song_id = songs.song_id
order by song_id , play_time_d;

#构造用于测试的基本特征表
drop table test_song_features;
create table test_song_features
select * from
    song_features
where
    play_time_d between '2015-3-14' and '2015-3-15'
limit 5000;

#基于歌手的特征
select 
    artist_id,
    play_time_d,
    sum(num_play) as num_play,
    sum(num_download) as num_download,
    sum(num_collect) as num_collect,
    weekday,
    gender
from
    AliMusic.song_features
group by artist_id , play_time_d
order by artist_id , play_time_d;



























