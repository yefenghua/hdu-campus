package com.example.service.impl;

import com.alibaba.fastjson2.JSONArray;
import com.alibaba.fastjson2.JSONObject;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.entity.dto.Topic;
import com.example.entity.dto.TopicType;
import com.example.entity.vo.request.TopicCreateVO;
import com.example.entity.vo.response.TopicPreviewVO;
import com.example.entity.vo.response.TopicTopVO;
import com.example.mapper.AccountMapper;
import com.example.mapper.TopicMapper;
import com.example.mapper.TopicTypeMapper;
import com.example.service.TopicService;
import com.example.utils.CacheUtils;
import com.example.utils.Const;
import com.example.utils.FlowUtils;
import jakarta.annotation.PostConstruct;
import jakarta.annotation.Resource;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class TopicServiceImpl extends ServiceImpl<TopicMapper, Topic> implements TopicService  {
    @Resource
    TopicTypeMapper mapper;

    @Resource
    FlowUtils flowUtils;

    @Resource
    CacheUtils cacheUtils;

    private Set<Integer> types = null;

    @Resource
    private AccountMapper accountMapper;

    @PostConstruct
    private void initTypes() {
        types = this.listTypes()
                .stream()
                .map(TopicType::getId)
                .collect(Collectors.toSet());
    }

    @Override
    public List<TopicType> listTypes() {
        return mapper.selectList(null);
    }

    @Override
    public List<TopicPreviewVO> listTopicByPage(int pageNumber, int type) {
        String key = Const.Forum_TOPIC_PREVIEW_CACHE + pageNumber + ":" + type;
        List<TopicPreviewVO> list = cacheUtils.takeListFromCache(key, TopicPreviewVO.class);
        if(list != null){
            System.out.println("cache:"+key+":"+list.size());
            return list;
        }
        Page<Topic> page = Page.of(pageNumber, 10);
        if(type == 0)
            baseMapper.selectPage(page, Wrappers.<Topic>query().orderByDesc("time"));
        else
            baseMapper.selectPage(page, Wrappers.<Topic>query().eq("type", type).orderByDesc("time"));
        List<Topic> topics = page.getRecords();
        System.out.println(topics.size());
        if(topics.isEmpty()) return null;
        list = topics.stream().map(this::resolveToPreview).toList();
        cacheUtils.saveListToCache(key, list, 60);
        return list;
    }

    @Override
    public List<TopicTopVO> listTopicTop() {
        List<Topic> topics=baseMapper.selectList(Wrappers.<Topic>query().select("id","title","time").eq("top",1));
        return topics.stream().map(topic -> {
            TopicTopVO vo = new TopicTopVO();
            BeanUtils.copyProperties(topic,vo);
            return vo;
        }).toList();
    }

    private TopicPreviewVO resolveToPreview(Topic topic){
        TopicPreviewVO vo=new TopicPreviewVO();
        BeanUtils.copyProperties(accountMapper.selectById(topic.getUid()),vo);
        BeanUtils.copyProperties(topic,vo);
        List<String> images=new ArrayList<>();
        StringBuilder previewText=new StringBuilder();
        JSONArray ops=JSONObject.parseObject(topic.getContent()).getJSONArray("ops");
        for (Object op:ops){
            Object insert=JSONObject.from(op).get("insert");
            if (insert instanceof String text){
                if (previewText.length()>=300) continue;
                previewText.append(text);
            }else if (insert instanceof Map<?,?> map){
                Optional.ofNullable(map.get("image")).ifPresent(obj->images.add(obj.toString()));
            }
        }
        vo.setText(previewText.length()>300? previewText.substring(0,300):previewText.toString());
        vo.setImages(images);
        return vo;
    }

    @Override
    public String createTopic(int uid, TopicCreateVO vo) {
        if (!textLimitCheck(vo.getContent())) return "文章内容太多，发文失败！";
        if(!types.contains(vo.getType())) return "文章类型非法！";
        String key= Const.Forum_TOPIC_CREATE_COUNTER+uid;
        if (!flowUtils.limitPeriodCounterCheck(key,3,3600))
            return "发文频繁，请稍后再试";
        Topic topic=new Topic();
        BeanUtils.copyProperties(vo,topic);
        topic.setContent(vo.getContent().toJSONString());
        topic.setUid(uid);
        topic.setTime(new Date());
        if (this.save(topic)){
            cacheUtils.deleteCache(Const.Forum_TOPIC_PREVIEW_CACHE +"*");
            return null;
        }
        else
            return "内部错误，请联系管理员";
    }

    private boolean textLimitCheck(JSONObject object){
        if (object==null) return false;
        long length=0;
        for (Object ops : object.getJSONArray("ops")) {
            length+=JSONObject.from(ops).getString("insert").length();
            if (length>20000) return false;
        }
        return true;
    }

}
