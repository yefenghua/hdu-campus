package com.example.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.entity.dto.Topic;
import com.example.entity.dto.TopicType;
import com.example.entity.vo.response.TopicPreviewVO;
import net.sf.jsqlparser.statement.select.Top;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface TopicMapper extends BaseMapper<Topic> {
    @Select("""
            select * from db_topic left join db_account on uid=db_account.id
              order by `time` desc limit ${start}, 10
          """)
    List<TopicType> topicList(int start);

    @Select("""
            select * from db_topic left join db_account on uid=db_account.id
              where type=#{type}
              order by `time` desc limit ${start}, 10
          """)
    List<TopicPreviewVO> topicListByType(int start,int type);
}
